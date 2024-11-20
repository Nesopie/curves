use dep::bignum::BigNumTrait;
use dep::bigcurve::CurveParamsTrait;
use bigcurve::BigCurve;
use bigcurve::curve_jac::CurveJ;

use crate::secp512r1::params::secp512r1Fq::Secp512r1_Fq_Params;
use crate::secp512r1::curve::Secp512r1_Params;
use bignum::bignum::BigNum;
use bignum::fields::secp384r1Fq::Secp384r1_Fq_Params;

type Secp512r1BN = BigNum<5, 512, Secp512r1_Fq_Params>;
type Secp384r1BN = BigNum<4, 384, Secp384r1_Fq_Params>;

unconstrained fn compute_and_print_offset_generators<Fq, Curve, let K: u32, let J: u32, let NScalarSlices: u32>(
    n: u32,
    paramstr: str<K>,
    curvestr: str<J>,
    cofactor: Field,
)
where
    Fq: BigNumTrait + std::ops::Mul + std::ops::Add + std::cmp::Eq,
    Curve: CurveParamsTrait<Fq>,
{
    let a = Curve::a();
    let b = Curve::b();

    let one = Curve::one();

    let input: BigCurve<Fq, Curve> = BigCurve::one();
    input.validate_on_curve();

    let seed: [u8; 25] = "bigcurve offset generator".as_bytes();

    // we only need well-defined parameters for a and b, for hash_to_curve to work
    // (no offset gneerators needed)
    let g: BigCurve<Fq, Curve> = BigCurve::hash_to_curve(seed);
    println("hi");

    let g_init: CurveJ<Fq, Curve> = CurveJ { x: g.x, y: g.y, z: Fq::one(), is_infinity: false };
    let mut gen = g_init;

    let cofactor_bits: [u1; 128] = cofactor.to_be_bits();
    let mut it: u32 = 0;
    for i in 0..128 {
        if (cofactor_bits[i] == 1) {
            it = i + 1;
            break;
        }
    }

    for i in it..128 {
        gen = gen.dbl().0;
        if (cofactor_bits[i] == 1) {
            gen = gen.incomplete_add(g_init).0;
        }
    }

    let mut offset_generator_initial: [Fq; 2] = [Fq::new(); 2];
    let mut offset_generator_final: [Fq; 2] = [Fq::new(); 2];

    {
        let mut genz = gen.z;
        genz = genz.__invmod();
        let zz = genz.__mul(genz);
        let zzz = zz.__mul(genz);

        offset_generator_initial[0] = gen.x.__mul(zz);
        offset_generator_initial[1] = gen.y.__mul(zzz);
    }

    let end = (NScalarSlices - 1) * 4;
    for _ in 0..end {
        gen = gen.dbl().0;
    }
    {
        let mut genz = gen.z;
        genz = genz.__invmod();
        let zz = genz.__mul(genz);
        let zzz = zz.__mul(genz);

        offset_generator_final[0] = gen.x.__mul(zz);
        offset_generator_final[1] = gen.y.__mul(zzz);
    }
    println(f"pub struct {curvestr} {}");
    println(
        f"impl CurveParamsTrait<BigNum<{n}, {paramstr}>> for {curvestr} {",
    );
    println(f"  fn a() -> BigNum<{n}, {paramstr}> { {a} }");
    println(f"  fn b() -> BigNum<{n}, {paramstr}> { {b} }");
    println(f"  fn one() -> [BigNum<{n}, {paramstr}>; 2] { {one} }");
    println(
        f"  fn offset_generator() -> [BigNum<{n}, {paramstr}>; 2] { {offset_generator_initial} }",
    );
    println(
        f"  fn offset_generator_final() -> [BigNum<{n}, {paramstr}>; 2] { {offset_generator_final} }",
    );
    println("}");
}

pub struct Secp384r1PartialCurveParams {}
impl CurveParamsTrait<Secp384r1BN> for Secp384r1PartialCurveParams {
    fn a() -> Secp384r1BN {
        let x: Secp384r1BN = BigNum { limbs: [3, 0, 0, 0] };
        x.neg()
    }
    fn b() -> Secp384r1BN {
        BigNum {
            limbs: [
                0x56398D8A2ED19D2A85C8EDD3EC2AEF,
                0x9C6EFE8141120314088F5013875AC6,
                0xA7E23EE7E4988E056BE3F82D19181D,
                0xB3312F,
            ],
        }
    }

    fn one() -> [Secp384r1BN; 2] {
        let mut y: Secp384r1BN = BigNum {
            limbs: [
                0x60B1CE1D7E819D7A431D7C90EA0E5F,
                0x1DBD289A147CE9DA3113B5F0B8C00A,
                0x4A96262C6F5D9E98BF9292DC29F8F4,
                0x3617DE,
            ],
        };

        let mut x: Secp384r1BN = BigNum {
            limbs: [
                0x02F25DBF55296C3A545E3872760AB7,
                0x3B628BA79B9859F741E082542A3855,
                0x22BE8B05378EB1C71EF320AD746E1D,
                0xAA87CA,
            ],
        };
        [x, y]
    }

    fn offset_generator_final() -> [Secp384r1BN; 2] {
        assert(true == false, "generator does not exist!");
        Secp384r1PartialCurveParams::one()
    }

    fn offset_generator() -> [Secp384r1BN; 2] {
        assert(true == false, "generator does not exist!");
        Secp384r1PartialCurveParams::one()
    }
}

#[test]
fn generate_p512_seed() {
    unsafe {
        compute_and_print_offset_generators::<Secp512r1BN, Secp512r1_Params, _, _, 129>(
            5,
            "Secp512r1_Fq_Params",
            "Secp512r1_Params",
            1,
        );
        // compute_and_print_offset_generators::<Secp384r1BN, Secp384r1PartialCurveParams, _, _, 97>(
        //     4,
        //     "Secp384r1_Fq_Params",
        //     "Secp384r1_Params",
        //     1,
        // );
    }
}
