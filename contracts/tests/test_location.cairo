from src.location import _insecure_set_wallet_location, get_wallet_location

const test_address = 0x4EBB0E6CC112563DC34E9B8DE7ECB326DB748F22;

@external
func test_set_and_get_location{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    _insecure_set_wallet_location( test_address, 'Sydney' );

    assert get_wallet_location( test_address ) = 'Sydney';

    return ();
}
