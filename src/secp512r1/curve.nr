use bignum::BigNum;
use super::params::secp512r1Fq::Secp512r1_Fq_Params;
use dep::bigcurve::CurveParamsTrait;

pub struct Secp512r1_Params {}
impl CurveParamsTrait<BigNum<5, 512, Secp512r1_Fq_Params>> for Secp512r1_Params {
    fn a() -> BigNum<5, 512, Secp512r1_Fq_Params> {
        BigNum {
            limbs: [
                0xfffffffffffffffffffffffffffffc,
                0xffffffffffffffffffffffffffffff,
                0xffffffffffffffffffffffffffffff,
                0xffffffffffffffffffffffffffffff,
                0x01ffffffffff,
            ],
        }
    }
    fn b() -> BigNum<5, 512, Secp512r1_Fq_Params> {
        BigNum {
            limbs: {
                [
                    0x73df883d2c34f1ef451fd46b503f00,
                    0x3951ec7e937b1652c0bd3bb1bf0735,
                    0x5b99b315f3b8b489918ef109e15619,
                    0x8e1c9a1f929a21a0b68540eea2da72,
                    0x51953eb961,
                ]
            },
        }
    }

    fn offset_generator() -> [BigNum<5, 512, Secp512r1_Fq_Params>; 2] {
        panic(f"Implement offset_generator")
    }

    fn offset_generator_final() -> [BigNum<5, 512, Secp512r1_Fq_Params>; 2] {
        panic(f"Implement offset_generator_final")
    }

    fn one() -> [BigNum<5, 512, Secp512r1_Fq_Params>; 2] {
        [
            BigNum {
                limbs: {
                    [
                        0x48b3c1856a429bf97e7e31c2e5bd66,
                        0x5e77efe75928fe1dc127a2ffa8de33,
                        0x39053fb521f828af606b4d3dbaa14b,
                        0x404e9cd9e3ecb662395b4429c6481,
                        0xc6858e06b7,
                    ]
                },
            },
            BigNum {
                limbs: {
                    [
                        0x3c7086a272c24088be94769fd16650,
                        0x72995ef42640c550b9013fad076135,
                        0x49579b446817afbd17273e662c97ee,
                        0x9a3bc0045c8a5fb42c7d1bd998f544,
                        0x011839296a78,
                    ]
                },
            },
        ]
    }
}
