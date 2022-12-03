%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from src.main.main import register_voter, get_is_voter_registered

@external
func test_register{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() -> () {
    let (is_user_registered) = get_is_voter_registered( 'test' );
    assert is_user_registered = 0; // User should not be registered
    register_voter( 'test' ); // Registering user

    let (is_user_registered) = get_is_voter_registered( 'test' );
    assert is_user_registered = 1; // User should not be registered
    return ();
}
