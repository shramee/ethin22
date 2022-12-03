%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin

// A storage_var can accept a Tuple (poll_id, voter_public_key) and return a single felt.
// This can also be done in vice-versa manner
@storage_var
func registered_voters(poll_id: felt, voter_public_key: felt) -> (is_registered: felt) {
}

@external
func register_voter{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, ecdsa_ptr: SignatureBuiltin*
}(poll_id: felt, voter_public_key: felt) {
    let (current_poll_owner) = poll_owner_public_key.read(poll_id=poll_id);

    assert_not_zero(current_poll_owner);

    let (sig_len: felt, sig: felt*) = get_tx_signature();

    assert sig_len = 2;

    // Verify validity of Signature
    let (message) = hash2{hash_ptr=pedersen_ptr}(x=poll_id, y=voter_public_key);
    verify_ecdsa_signature(
        message=message, public_key=current_poll_owner, signature_r=sig[0], signature_s=sig[1]
    );

    registered_voters.write(poll_id=poll_id, voter_public_key=voter_public_key, value=1);
    return ();
}

@view
func get_is_voter_registered{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    poll_id: felt, voter_public_key: felt
) -> (result: felt) {
    // Read from registered_voters and verify that the voter is registered.
    let (is_voter_registered) = registered_voters.read(
        poll_id=poll_id, voter_public_key=voter_public_key
    );

    return (result=is_voter_registered);
}
