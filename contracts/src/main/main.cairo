%lang starknet
%builtins pedersen range_check ecdsa

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.cairo.common.hash import hash2
from starkware.cairo.common.math import assert_not_zero
from starkware.cairo.common.math_cmp import is_le
from starkware.cairo.common.signature import verify_ecdsa_signature
from starkware.starknet.common.syscalls import get_tx_signature, get_caller_address

from src.main.register import registered_members, register_voter, get_is_voter_registered

// Poll ID is IPFS hash
struct Poll {
    initiator: felt, // Wallet of owner
    poll_ipfs: felt, // Poll ID
    n_options: felt, // Number of options
    action: felt, // Maybe take an action
    payload: felt, // Additional data for action if needed
}

// Stores a map for ID of the Poll -> Public Key of the owner who created the poll
@storage_var
func poll_details(poll_ipfs: felt) -> (Poll: Poll) {
}

@storage_var
func poll_indices(index: felt) -> (Poll: Poll) {
}

@storage_var
func voting_state(poll_ipfs: felt, answer: felt) -> (n_votes: felt) {
}

@storage_var
func voter_state(poll_ipfs: felt, voter_public_key: felt) -> (has_voted: felt) {
}

@storage_var
func exams( wallet: felt ) -> (address: felt) {
}

@storage_var
func department_data( key: felt ) -> (res: felt) {
}


@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    exam_ipfs_hash: felt, exam_solution: felt, solution_salt: felt, genesis_account: felt
) {
    exams.write('exam', exam_ipfs_hash);
    department_data.write('exam', exam_ipfs_hash);
    department_data.write('number_of_polls', 0);
    department_data.write('exam', exam_ipfs_hash);
    registered_members.write(genesis_account, value=1); 
    return ();
}

@external
func init_poll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    poll_ipfs: felt, n_options: felt, action: felt, payload: felt
) -> (result: felt) {
    alloc_locals;
    let (is_poll_id_taken) = poll_details.read(poll_ipfs);

    // Verify that the poll ID is available.
    assert is_poll_id_taken.initiator = 0;

    let (initiator) = get_caller_address();

    let poll_deets = Poll(
        initiator=initiator,
        poll_ipfs=poll_ipfs,
        n_options=n_options,
        action=action,
        payload=payload
    );

    poll_details.write(poll_ipfs, poll_deets);
    
    let (number_of_polls) = department_data.read('number_of_polls');
    
    poll_indices.write( number_of_polls, poll_deets );
    department_data.write('number_of_polls', number_of_polls + 1 );
    return (result=1);
}

@view
func get_voting_state{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    poll_ipfs: felt
) -> (n_no_votes: felt, n_yes_votes: felt) {
    let (n_no_votes) = voting_state.read(poll_ipfs=poll_ipfs, answer=0);
    let (n_yes_votes) = voting_state.read(poll_ipfs=poll_ipfs, answer=1);

    return (n_no_votes=n_no_votes, n_yes_votes=n_yes_votes);
}

func verify_vote{
    pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, ecdsa_ptr: SignatureBuiltin*, range_check_ptr
}(poll_ipfs: felt, voter_public_key: felt, vote: felt, r: felt, s: felt) {
    // Verify the vote value is legal, i.e. 0 or 1
    assert (vote - 1) * (vote - 0) = 0;

    // Read from registered_members and verify that the voter is registered.
    let (is_voter_registered) = get_is_voter_registered(voter_public_key);

    assert is_voter_registered = 1;

    // Read from voter_state and verify that the voter has not voted for this poll yet.
    let (has_voter_voted) = voter_state.read(poll_ipfs=poll_ipfs, voter_public_key=voter_public_key);

    assert has_voter_voted = 0;

    // Verify the validity of the signature. The hash should be on the poll_ipfs and the vote.
    let (message) = hash2{hash_ptr=pedersen_ptr}(x=poll_ipfs, y=vote);

    verify_ecdsa_signature(
        message=message, public_key=voter_public_key, signature_r=r, signature_s=s
    );

    return ();
}

@external
func vote{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, ecdsa_ptr: SignatureBuiltin*
}(poll_ipfs: felt, voter_public_key: felt, vote: felt) {
    let (sig_len: felt, sig: felt*) = get_tx_signature();

    assert sig_len = 2;

    // Verify Vote
    verify_vote(poll_ipfs=poll_ipfs, voter_public_key=voter_public_key, vote=vote, r=sig[0], s=sig[1]);

    // Vote.
    let (current_n_votes) = voting_state.read(poll_ipfs, answer=vote);

    voting_state.write(poll_ipfs=poll_ipfs, answer=vote, value=current_n_votes + 1);
    voter_state.write(poll_ipfs=poll_ipfs, voter_public_key=voter_public_key, value=1);
    return ();
}

@external
func finalize_poll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    poll_ipfs: felt
) -> (result: felt) {
    alloc_locals;

    let (n_no_votes, n_yes_votes) = get_voting_state(poll_ipfs=poll_ipfs);

    // Store these references in local variables as they might be revoked by is_le().
    local syscall_ptr: felt* = syscall_ptr;
    local pedersen_ptr: HashBuiltin* = pedersen_ptr;
    let result = is_le(n_no_votes, n_yes_votes);

    // Demonstrate Cairo short strings. "Yes" == int.from_bytes("Yes".encode("ascii"), "big").
    let result = (result * 'Yes') + ((1 - result) * 'No');

    return (result=1);
}
