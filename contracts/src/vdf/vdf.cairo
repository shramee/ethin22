%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import sqrt

struct VDF_Secret {
    hashedSecret: felt,
    rounds: felt,
    salt_hash: felt,
}

struct VDF_Job {
    secret: felt,
    rounds: felt,
    salt_hash: felt,
}

@storage_var
func vdf_secrets( id: felt ) -> (res: VDF_Secret) {
}

@storage_var
func vdf_jobs( id: felt ) -> (res: VDF_Job) {
}

func _vdfy_salt( random_salt: felt, rounds: felt ) -> (vdfified_salt: felt) {
    if ( rounds == 0 ) {
        return (vdfified_salt=random_salt);
    }
    let vdfified_salt = random_salt * random_salt;
    return _vdfy_salt(vdfified_salt, rounds - 1);
}

// Don't run this on chain, this should run outside the chain.
// The result can be submitted on pending jobs and proven (or simply vdfied again and tested).
func _unvdfy_salt{range_check_ptr}( vdfified_salt: felt, rounds: felt ) -> (salt: felt) {
    if ( rounds == 0 ) {
        return (salt=vdfified_salt);
    }
    let salt = sqrt(vdfified_salt);
    return _unvdfy_salt{range_check_ptr=range_check_ptr}(salt, rounds - 1);
}

// Takes a secret and hashes it with a random number passed through VDF function(s)
@external
func vdfy{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    secret_value: felt, rounds: felt
) {
    // Get a good random number
    let random_salt = 'good_random';
    // Use the salt to hash the value

    // vdfy the salt

    // Save vdfied salt
}