use bignum::params::BigNumParams;
use bignum::params::BigNumParamsGetter;

pub struct Secp512r1_Fq_Params {}

impl BigNumParamsGetter<5, 512> for Secp512r1_Fq_Params {
    fn get_params() -> BigNumParams<5, 512> {
        Secp512r1_Fq_PARAMS
    }
}

global Secp512r1_Fq_PARAMS: BigNumParams<5, 512> = BigNumParams::new(
    true,
    [
        0xffffffffffffffffffffffffffffff,
        0xffffffffffffffffffffffffffffff,
        0xffffffffffffffffffffffffffffff,
        0xffffffffffffffffffffffffffffff,
        0x01ffffffffff,
    ],
    [0x0, 0x0, 0x0, 0x0, 0x8000000],
);
