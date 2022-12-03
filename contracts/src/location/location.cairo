%lang starknet

%builtins pedersen range_check ecdsa

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin

@storage_var
func _wallet_location( wallet ) -> (wallet_location: felt) {
}

@storage_var
func _owner() -> (owner_address: felt) {
}

@constructor
func constructor{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(owner_address: felt) {
    _owner.write(owner_address);
    return ();
}

func _insecure_set_wallet_location{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    wallet: felt, location: felt
) {
    _wallet_location.write( wallet, location );
    return();
}

@external
func set_wallet_location{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    wallet: felt, location: felt
) {
    let (owner) = owner.read();
    let (caller) = get_caller_address();
    assert caller = owner;

    _insecure_set_wallet_location( wallet, location );

    return ();
}

@view
func get_wallet_location{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(wallet: felt) -> (location: felt) {
    return _wallet_location.read( wallet );
}
