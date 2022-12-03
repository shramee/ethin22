%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from src.voting import get_voting_state

@external
func test_get_voting_state{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() -> (n: felt, y: felt) {
    let (n, y) = get_voting_state( 1 );
    return (n=n, y=y);
}
