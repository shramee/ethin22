%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.vdf.vdf import _vdfy_salt, _unvdfy_salt

@external
func test_vdf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let orig = 3;
    let vdfied = _vdfy_salt( orig, 4 );
    let orig2 = _vdfy_salt( vdfied, 4 );

    assert orig = orig2;
}