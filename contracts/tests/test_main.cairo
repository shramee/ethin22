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

from src.main.main import department_data, poll_details, poll_indices, init_poll

@external
func test_add_poll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // init_poll(  );
    let (number_of_polls) = department_data.read('number_of_polls');
    assert number_of_polls = 0;

    init_poll('1jSUCLEWt16mNCSVVhNq3SdSqrDVzh1', 2, '', '',);

    let (number_of_polls) = department_data.read('number_of_polls');
    assert number_of_polls = 1;

    return();
}