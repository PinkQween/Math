//
//  ExtendedMathConstants.swift
//  Math
//
//  Created by Hanna Skairipa on 10/4/25.
//

/// Extended mathematical constants beyond the basic set.
///
/// This includes transcendental numbers, special constants,
/// and commonly used mathematical values.
public struct ExtendedMathConstants: Sendable {

    // MARK: - Transcendental Numbers

    /// Euler's number (e ≈ 2.71828...)
    public static let e = Math.Ɛ

    /// Alias for Euler's number
    public static let Ɛ = Math.Ɛ

    /// Pi (π ≈ 3.14159...)
    public static let π = Math.π

    /// Alias for pi
    public static let pi = Math.π

    /// Tau (τ = 2π ≈ 6.28318...)
    /// The circle constant (ratio of circumference to radius)
    public static let τ = Math.π * 2

    /// Alias for tau
    public static let tau = τ

    /// Golden ratio (φ ≈ 1.61803...)
    /// φ = (1 + √5) / 2
    public static let φ = (1 + Math.sqrt(Math(5))) / 2

    /// Alias for golden ratio
    public static let goldenRatio = φ

    /// Silver ratio (δ_S ≈ 2.41421...)
    /// δ_S = 1 + √2
    public static let silverRatio = 1 + Math.sqrt(Math(2))

    /// Alias for silver ratio
    public static let δ_S = silverRatio

    /// Bronze ratio (≈ 3.30277...)
    /// (3 + √13) / 2
    public static let bronzeRatio = (3 + Math.sqrt(Math(13))) / 2

    /// Euler-Mascheroni constant (γ ≈ 0.57721...)
    public static let eulerMascheroniConstant = Math(0.5772156649015329)

    /// Alias for Euler-Mascheroni constant
    public static let γ = eulerMascheroniConstant

    /// Apéry's constant (ζ(3) ≈ 1.20205...)
    /// Sum of reciprocals of cubes
    public static let aperysConstant = Math(1.2020569031595943)

    /// Alias for Apéry's constant
    public static let ζ3 = aperysConstant

    // MARK: - Roots and Powers

    /// Square root of 2 (√2 ≈ 1.41421...)
    public static let sqrt2 = Math.sqrt2

    /// Square root of 3 (√3 ≈ 1.73205...)
    public static let sqrt3 = Math.sqrt3

    /// Square root of 5 (√5 ≈ 2.23606...)
    public static let sqrt5 = Math.sqrt(Math(5))

    /// Cube root of 2 (∛2 ≈ 1.25992...)
    public static let cbrt2 = 3 |/ 2

    /// Cube root of 3 (∛3 ≈ 1.44224...)
    public static let cbrt3 = 3 |/ 3

    // MARK: - Trigonometric Constants

    /// π/2 (≈ 1.5708...)
    public static let piOver2 = Math.π / 2

    /// Alias for π/2
    public static let π_2 = piOver2

    /// π/3 (≈ 1.0472...)
    public static let piOver3 = Math.π / 3

    /// Alias for π/3
    public static let π_3 = piOver3

    /// π/4 (≈ 0.7854...)
    public static let piOver4 = Math.π / 4

    /// Alias for π/4
    public static let π_4 = piOver4

    /// π/6 (≈ 0.5236...)
    public static let piOver6 = Math.π / 6

    /// Alias for π/6
    public static let π_6 = piOver6

    /// 2π (≈ 6.2832...)
    public static let twoPi = Math.π * 2

    /// 3π/2 (≈ 4.7124...)
    public static let threePiOver2 = Math.π * 3 / 2

    // MARK: - Logarithmic Constants

    /// Natural logarithm of 2 (ln(2) ≈ 0.69315...)
    public static let ln2 = Math(0.6931471805599453)

    /// Natural logarithm of 10 (ln(10) ≈ 2.30259...)
    public static let ln10 = Math(2.302585092994046)

    /// Base-10 logarithm of e (log₁₀(e) ≈ 0.43429...)
    public static let log10e = Math(0.4342944819032518)

    /// Base-2 logarithm of e (log₂(e) ≈ 1.44270...)
    public static let log2e = Math(1.4426950408889634)

    // MARK: - Special Mathematical Constants

    /// Catalan's constant (G ≈ 0.91596...)
    public static let catalanConstant = Math(0.9159655941772190)

    /// Alias for Catalan's constant
    public static let G_catalan = catalanConstant

    /// Khinchin's constant (K ≈ 2.68545...)
    public static let khinchinsConstant = Math(2.6854520010653064)

    /// Alias for Khinchin's constant
    public static let K_khinchin = khinchinsConstant

    /// Glaisher-Kinkelin constant (A ≈ 1.28243...)
    public static let glaisherKinkelinConstant = Math(1.2824271291006226)

    /// Alias for Glaisher-Kinkelin constant
    public static let A_gk = glaisherKinkelinConstant

    /// Conway's constant (λ ≈ 1.30357...)
    public static let conwaysConstant = Math(1.303577269034296)

    /// Alias for Conway's constant
    public static let λ_conway = conwaysConstant

    /// Ramanujan-Soldner constant (μ ≈ 1.45136...)
    public static let ramanujanSoldnerConstant = Math(1.4513692348833810)

    /// Alias for Ramanujan-Soldner constant
    public static let μ_rs = ramanujanSoldnerConstant

    /// Erdős-Borwein constant (E ≈ 1.60669...)
    public static let erdosBorweinConstant = Math(1.6066951524152918)

    /// Alias for Erdős-Borwein constant
    public static let E_eb = erdosBorweinConstant

    /// Omega constant (Ω ≈ 0.56714...)
    /// Solution to Ω * e^Ω = 1
    public static let omegaConstant = Math(0.5671432904097839)

    /// Alias for omega constant
    public static let Ω = omegaConstant

    /// Plastic constant (ρ ≈ 1.32472...)
    /// Real root of x³ = x + 1
    public static let plasticConstant = Math(1.3247179572447460)

    /// Alias for plastic constant
    public static let ρ_plastic = plasticConstant

    // MARK: - Numerical Constants

    /// Feigenbaum delta constant (δ ≈ 4.66920...)
    /// Chaos theory constant
    public static let feigenbaumDelta = Math(4.6692016091029906)

    /// Alias for Feigenbaum delta
    public static let δ_feigenbaum = feigenbaumDelta

    /// Feigenbaum alpha constant (α ≈ 2.50291...)
    public static let feigenbaumAlpha = Math(2.5029078750958928)

    /// Alias for Feigenbaum alpha
    public static let α_feigenbaum = feigenbaumAlpha

    /// Meissel-Mertens constant (M ≈ 0.26149...)
    public static let meisselMertensConstant = Math(0.2614972128476428)

    /// Alias for Meissel-Mertens constant
    public static let M_mm = meisselMertensConstant

    /// Twin primes constant (C₂ ≈ 0.66016...)
    public static let twinPrimesConstant = Math(0.6601618158468696)

    /// Alias for twin primes constant
    public static let C₂ = twinPrimesConstant

    // MARK: - Degrees/Radians Conversion

    /// Degrees in one radian (180/π ≈ 57.2958...)
    public static let degreesPerRadian = 180 / Math.π

    /// Radians in one degree (π/180 ≈ 0.01745...)
    public static let radiansPerDegree = Math.π / 180

    // MARK: - Common Fractions

    /// 1/2
    public static let oneHalf = Math(0.5)

    /// 1/3
    public static let oneThird = Math(1) / 3

    /// 2/3
    public static let twoThirds = Math(2) / 3

    /// 1/4
    public static let oneQuarter = Math(0.25)

    /// 3/4
    public static let threeQuarters = Math(0.75)

    /// 1/√2 (≈ 0.70711...)
    public static let oneOverSqrt2 = 1 / sqrt2

    /// 1/√3 (≈ 0.57735...)
    public static let oneOverSqrt3 = 1 / sqrt3
}
