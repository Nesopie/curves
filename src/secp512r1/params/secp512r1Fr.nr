use bignum::params::BigNumParams;
use bignum::params::BigNumParamsGetter;

pub struct Secp512r1_Fr_Params {}

impl BigNumParamsGetter<5, 512> for Secp512r1_Fr_Params {
    fn get_params() -> BigNumParams<5, 512> {
        Secp512r1_Fr_PARAMS
    }
}

global Secp512r1_Fr_PARAMS: BigNumParams<5, 512> = BigNumParams::new(
    true,
    [
        0xb5c9b8899c47aebb6fb71e91386409,
        0x8783bf2f966b7fcc0148f709a5d03b,
        0xfffffffffffffffffffffffffa5186,
        0xffffffffffffffffffffffffffffff,
        0x01ffffffffff,
    ],
    [0xbf1128d91dd98ee14512412385bb10, 0xb9e5e1f10341a65200cffadc23d968, 0x16, 0x0, 0x8000000],
);
