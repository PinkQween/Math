//
//  Complex.swift
//  Math
//
//  Comprehensive complex number support for scientific and engineering applications.
//
//  Created by Hanna Skairipa on 10/4/25.
//

import Foundation

// MARK: - Complex Number Type

/// Represents a complex number of the form `a + bi` where `i² = -1`.
///
/// ## Features
/// - Full arithmetic operations (`+`, `-`, `*`, `/`)
/// - Polar and rectangular form conversions
/// - Magnitude, phase, and conjugate
/// - Exponential and logarithmic functions
/// - Trigonometric functions with complex arguments
/// - Power operations
///
/// ## Usage
/// ```swift
/// let z1 = Complex(real: 3, imaginary: 4)
/// let z2 = Complex(real: 1, imaginary: -2)
///
/// let sum = z1 + z2              // 4 + 2i
/// let product = z1 * z2          // 11 - 2i
/// let magnitude = z1.magnitude   // 5
/// let phase = z1.phase           // ≈53.13° or ≈0.927 radians
/// let conjugate = z1.conjugate   // 3 - 4i
///
/// // Polar form
/// let polar = Complex(magnitude: 5, phase: .pi / 4)
/// ```
public struct Complex: Equatable, CustomStringConvertible, Sendable {
    // MARK: - Properties

    /// Real part (a in a + bi)
    public let real: Math

    /// Imaginary part (b in a + bi)
    public let imaginary: Math

    // MARK: - Initializers

    /// Creates a complex number from real and imaginary parts.
    ///
    /// - Parameters:
    ///   - real: The real part (default: 0)
    ///   - imaginary: The imaginary part (default: 0)
    public init(real: Math = 0, imaginary: Math = 0) {
        self.real = real
        self.imaginary = imaginary
    }

    /// Creates a complex number from polar form: r·e^(iθ)
    ///
    /// - Parameters:
    ///   - magnitude: The magnitude (r)
    ///   - phase: The phase angle (θ) in radians or degrees based on MathSettings
    public init(magnitude: Math, phase: Math) {
        // Convert phase to radians if necessary
        let phaseRad: Math
        switch MathSettings.shared.angleMode {
        case .degrees:
            phaseRad = phase * .pi / 180
        case .radians:
            phaseRad = phase
        }

        // r·cos(θ) + i·r·sin(θ)
        self.real = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            magnitude * Math.cos(phaseRad)
        }
        self.imaginary = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            magnitude * Math.sin(phaseRad)
        }
    }

    /// Creates a purely real complex number.
    ///
    /// - Parameter real: The real value
    public init(_ real: Math) {
        self.real = real
        self.imaginary = 0
    }

    // MARK: - Computed Properties

    /// The magnitude (absolute value) of the complex number: |z| = √(a² + b²)
    public var magnitude: Math {
        Math.sqrt(real * real + imaginary * imaginary)
    }

    /// Alias for magnitude
    public var abs: Math {
        magnitude
    }

    /// The phase (argument) of the complex number: arg(z) = atan2(b, a)
    ///
    /// Returns angle in current angle mode (degrees or radians).
    public var phase: Math {
        Math.atan2(imaginary, real)
    }

    /// Alias for phase
    public var argument: Math {
        phase
    }

    /// The complex conjugate: conj(a + bi) = a - bi
    public var conjugate: Complex {
        Complex(real: real, imaginary: -imaginary)
    }

    /// Returns true if the complex number is purely real (imaginary part is zero)
    public var isReal: Bool {
        imaginary == 0
    }

    /// Returns true if the complex number is purely imaginary (real part is zero)
    public var isImaginary: Bool {
        real == 0 && imaginary != 0
    }

    /// Returns true if both parts are zero
    public var isZero: Bool {
        real == 0 && imaginary == 0
    }

    // MARK: - String Representation

    public var description: String {
        if isZero {
            return "0"
        }

        if imaginary == 0 {
            return "\(real)"
        }

        if real == 0 {
            if imaginary == 1 {
                return "i"
            } else if imaginary == -1 {
                return "-i"
            } else {
                return "\(imaginary)i"
            }
        }

        let sign = imaginary >= 0 ? "+" : ""
        let imagPart = imaginary == 1 ? "i" : (imaginary == -1 ? "-i" : "\(imaginary)i")
        return "\(real) \(sign) \(imagPart)"
    }

    // MARK: - Equatable

    public static func == (lhs: Complex, rhs: Complex) -> Bool {
        lhs.real == rhs.real && lhs.imaginary == rhs.imaginary
    }
}

// MARK: - Arithmetic Operations

extension Complex {
    /// Addition: (a + bi) + (c + di) = (a+c) + (b+d)i
    public static func + (lhs: Complex, rhs: Complex) -> Complex {
        Complex(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
    }

    /// Subtraction: (a + bi) - (c + di) = (a-c) + (b-d)i
    public static func - (lhs: Complex, rhs: Complex) -> Complex {
        Complex(real: lhs.real - rhs.real, imaginary: lhs.imaginary - rhs.imaginary)
    }

    /// Multiplication: (a + bi)(c + di) = (ac - bd) + (ad + bc)i
    public static func * (lhs: Complex, rhs: Complex) -> Complex {
        let realPart = lhs.real * rhs.real - lhs.imaginary * rhs.imaginary
        let imagPart = lhs.real * rhs.imaginary + lhs.imaginary * rhs.real
        return Complex(real: realPart, imaginary: imagPart)
    }

    /// Division: (a + bi) / (c + di) = [(ac + bd) + (bc - ad)i] / (c² + d²)
    public static func / (lhs: Complex, rhs: Complex) -> Complex {
        let denominator = rhs.real * rhs.real + rhs.imaginary * rhs.imaginary
        guard denominator != 0 else {
            fatalError("Complex division by zero")
        }

        let realPart = (lhs.real * rhs.real + lhs.imaginary * rhs.imaginary) / denominator
        let imagPart = (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary) / denominator
        return Complex(real: realPart, imaginary: imagPart)
    }

    /// Negation: -(a + bi) = -a - bi
    public static prefix func - (z: Complex) -> Complex {
        Complex(real: -z.real, imaginary: -z.imaginary)
    }

    /// Scalar multiplication
    public static func * (scalar: Math, z: Complex) -> Complex {
        Complex(real: scalar * z.real, imaginary: scalar * z.imaginary)
    }

    /// Scalar multiplication (commutative)
    public static func * (z: Complex, scalar: Math) -> Complex {
        scalar * z
    }

    /// Scalar division
    public static func / (z: Complex, scalar: Math) -> Complex {
        guard scalar != 0 else {
            fatalError("Division by zero")
        }
        return Complex(real: z.real / scalar, imaginary: z.imaginary / scalar)
    }
}

// MARK: - Advanced Functions

extension Complex {
    /// Exponential function: e^(a + bi) = e^a · (cos(b) + i·sin(b))
    public static func exp(_ z: Complex) -> Complex {
        let expReal = Math.exp(z.real)

        let cosImag = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            Math.cos(z.imaginary)
        }
        let sinImag = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            Math.sin(z.imaginary)
        }

        return Complex(real: expReal * cosImag, imaginary: expReal * sinImag)
    }

    /// Natural logarithm: ln(a + bi) = ln|z| + i·arg(z)
    public static func ln(_ z: Complex) -> Complex {
        guard !z.isZero else {
            fatalError("Logarithm of zero is undefined")
        }

        let magnitude = z.magnitude
        let phase = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            z.phase
        }

        return Complex(real: Math.ln(magnitude), imaginary: phase)
    }

    /// Power function: z^w = e^(w·ln(z))
    public static func pow(_ z: Complex, _ w: Complex) -> Complex {
        if z.isZero {
            return w.isZero ? Complex(real: 1) : Complex(real: 0)
        }
        return exp(w * ln(z))
    }

    /// Integer power: z^n (optimized for integer exponents)
    public func power(_ n: Int) -> Complex {
        if n == 0 {
            return Complex(real: 1)
        }

        if n < 0 {
            return Complex(real: 1) / power(-n)
        }

        var result = Complex(real: 1)
        var base = self
        var exponent = n

        // Fast exponentiation by squaring
        while exponent > 0 {
            if exponent % 2 == 1 {
                result = result * base
            }
            base = base * base
            exponent /= 2
        }

        return result
    }

    /// Square root: √z
    ///
    /// Returns the principal square root (with non-negative real part).
    public static func sqrt(_ z: Complex) -> Complex {
        if z.isReal && z.real >= 0 {
            return Complex(real: Math.sqrt(z.real))
        }

        let r = z.magnitude
        let realPart = Math.sqrt((z.real + r) / 2)
        let imagPart = (z.imaginary >= 0 ? 1 : -1) * Math.sqrt((r - z.real) / 2)

        return Complex(real: realPart, imaginary: imagPart)
    }
}

// MARK: - Trigonometric Functions

extension Complex {
    /// Sine: sin(z) = (e^(iz) - e^(-iz)) / (2i)
    public static func sin(_ z: Complex) -> Complex {
        let i = Complex(real: 0, imaginary: 1)
        let ePos = exp(i * z)
        let eNeg = exp(-i * z)
        return (ePos - eNeg) / (Math(2) * i)
    }

    /// Cosine: cos(z) = (e^(iz) + e^(-iz)) / 2
    public static func cos(_ z: Complex) -> Complex {
        let i = Complex(real: 0, imaginary: 1)
        let ePos = exp(i * z)
        let eNeg = exp(-i * z)
        return (ePos + eNeg) / Math(2)
    }

    /// Tangent: tan(z) = sin(z) / cos(z)
    public static func tan(_ z: Complex) -> Complex {
        let sinZ = sin(z)
        let cosZ = cos(z)
        guard !cosZ.isZero else {
            fatalError("Tangent undefined (division by zero)")
        }
        return sinZ / cosZ
    }
}

// MARK: - Hyperbolic Functions

extension Complex {
    /// Hyperbolic sine: sinh(z) = (e^z - e^(-z)) / 2
    public static func sinh(_ z: Complex) -> Complex {
        let ePos = exp(z)
        let eNeg = exp(-z)
        return (ePos - eNeg) / Math(2)
    }

    /// Hyperbolic cosine: cosh(z) = (e^z + e^(-z)) / 2
    public static func cosh(_ z: Complex) -> Complex {
        let ePos = exp(z)
        let eNeg = exp(-z)
        return (ePos + eNeg) / Math(2)
    }

    /// Hyperbolic tangent: tanh(z) = sinh(z) / cosh(z)
    public static func tanh(_ z: Complex) -> Complex {
        let sinhZ = sinh(z)
        let coshZ = cosh(z)
        return sinhZ / coshZ
    }
}

// MARK: - Convenience Constants

extension Complex {
    /// The imaginary unit: i (0 + 1i)
    public static let i = Complex(real: 0, imaginary: 1)

    /// Zero: 0 + 0i
    public static let zero = Complex(real: 0, imaginary: 0)

    /// One: 1 + 0i
    public static let one = Complex(real: 1, imaginary: 0)
}
