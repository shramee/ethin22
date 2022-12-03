%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin

// A storage_var can accept a Tuple (poll_id, voter_public_key) and return a single felt.
// This can also be done in vice-versa manner
@storage_var
func registered_members(voter_public_key: felt) -> (is_registered: felt) {
}

@external
func register_voter{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}(voter_public_key: felt) {
    registered_members.write(voter_public_key=voter_public_key, value=1);
    return ();
}

@view
func get_is_voter_registered{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    voter_public_key: felt
) -> (result: felt) {
    // Read from registered_members and verify that the voter is registered.
    let (is_voter_registered) = registered_members.read(
        voter_public_key=voter_public_key
    );

    return (result=is_voter_registered);
}
