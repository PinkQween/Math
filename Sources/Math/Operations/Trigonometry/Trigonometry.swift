//
//  Trigonometry.swift
//  Math
//
//  Comprehensive trigonometric functions and triangle solving capabilities.
//
//  Created by Hanna Skairipa on 9/19/25.
//

import Foundation

// MARK: - Precedence Group for Math Functions
// Ensures functions like sin, cos, etc., are evaluated with correct precedence
precedencegroup FunctionPrecedence {
    higherThan: DekationPrecedence
    associativity: right
}

// MARK: - Trigonometric Functions

public extension Math {

    // MARK: - Sine Function
    /// Computes the sine of a Math value using a Taylor series expansion.
    /// - Parameter x: Angle in degrees or radians based on MathSettings.
    /// - Returns: sin(x) as a Math value.
    ///
    /// Note: Precision depends on `MathSettings.shared.precision`.
    static func sin(_ x: Math) -> Math {
        // 1. Get current settings (angle mode and precision)
        let settings = MathSettings.shared

        // 2. Convert input to radians if necessary (Taylor series expects radians)
        let rad: Math
        switch settings.angleMode {
        case .degrees:
            rad = x * .pi / 180
        case .radians:
            rad = x
        }

        let n = settings.precision

        // 3. Compute sine using Taylor expansion
        var result: Math = 0
        for k in 0..<n {
            let numerator = ((-1) ** k) * (rad ** (2 * k + 1))
            let denominator = (2 * k + 1)~!
            result += numerator / denominator
        }
        return result
    }

    // MARK: - Cosine Function
    /// Computes the cosine of a Math value using a Taylor series expansion.
    /// - Parameter x: Angle in degrees or radians based on MathSettings.
    /// - Returns: cos(x) as a Math value.
    static func cos(_ x: Math) -> Math {
        // Convert input to radians
        let rad: Math
        switch MathSettings.shared.angleMode {
        case .degrees:
            rad = x * .pi / 180
        case .radians:
            rad = x
        }

        let n = MathSettings.shared.precision

        // Compute cosine using Taylor expansion
        var result: Math = 0
        for k in 0..<n {
            let numerator = ((-1) ** k) * (rad ** (2 * k))
            let denominator = (2 * k)~!
            result += numerator / denominator
        }
        return result
    }

    // MARK: - Tangent Function
    /// Computes the tangent of a Math value: tan(x) = sin(x) / cos(x).
    /// - Parameter x: Angle in degrees or radians based on MathSettings.
    /// - Returns: tan(x) as a Math value.
    static func tan(_ x: Math) -> Math {
        let sinVal = sin(x)
        let cosVal = cos(x)
        guard cosVal != 0 else {
            fatalError("tan undefined at x = ±90° (±π/2)")
        }
        return sinVal / cosVal
    }

    // MARK: - Arcsine Function
    /// Computes arcsin(y) using Newton-Raphson iteration.
    /// - Parameter y: Value in [-1, 1] range.
    /// - Returns: asin(y) as a Math value (degrees or radians depending on MathSettings).
    ///
    /// ⚠️ Warning: Precision issues may occur when y = 1 / sqrt(2) (≈0.7071067812),
    /// resulting in small errors (~1e-16). Use caution and verify results for critical calculations.
    static func asin(_ y: Math) -> Math {
        // 1. Clamp input domain [-1, 1]
        guard y >= -1 && y <= 1 else {
            fatalError("asin domain error: value must be between -1 and 1")
        }

        // 2. Initial guess using small-angle approximation: asin(y) ≈ y
        var x = y

        // 3. Newton-Raphson iterations
        let iterations = MathSettings.shared.precision
        for _ in 0..<iterations {
            let f = Calculate(settings: .init(angleMode: .radians, precision: iterations)) {
                sin(x)
            } - y
            let fPrime = Calculate(settings: .init(angleMode: .radians, precision: iterations)) {
                cos(x)
            }
            x -= f / fPrime
        }

        // 4. Convert result back to the current angle unit
        switch MathSettings.shared.angleMode {
        case .degrees:
            return x * 180 / .pi
        case .radians:
            return x
        }
    }

    // MARK: - Arccosine Function
    /// Computes arccos(x) using the identity: acos(x) = π/2 - asin(x).
    /// - Parameter x: Value in [-1, 1] range.
    /// - Returns: acos(x) as a Math value (degrees or radians depending on MathSettings).
    static func acos(_ x: Math) -> Math {
        guard x >= -1 && x <= 1 else {
            fatalError("acos domain error: value must be between -1 and 1")
        }

        let asinVal = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            asin(x)
        }

        let result: Math
        switch MathSettings.shared.angleMode {
        case .radians:
            result = .pi / 2 - asinVal
        case .degrees:
            result = 90 - (asinVal * 180 / .pi)
        }
        return result
    }

    // MARK: - Arctangent Function
    /// Computes arctan(y) using Newton-Raphson iteration.
    /// - Parameter y: Any real value.
    /// - Returns: atan(y) as a Math value in range (-90°, 90°) or (-π/2, π/2).
    static func atan(_ y: Math) -> Math {
        // Initial guess using small-angle approximation
        var x = y / (1 + y * y)

        let iterations = MathSettings.shared.precision
        for _ in 0..<iterations {
            let tanVal = Calculate(settings: .init(angleMode: .radians, precision: iterations)) {
                tan(x)
            }
            let cosVal = Calculate(settings: .init(angleMode: .radians, precision: iterations)) {
                cos(x)
            }
            let f = tanVal - y
            let fPrime = 1 / (cosVal * cosVal)
            x -= f / fPrime
        }

        // Convert result back to the current angle unit
        switch MathSettings.shared.angleMode {
        case .degrees:
            return x * 180 / .pi
        case .radians:
            return x
        }
    }

    // MARK: - Two-argument Arctangent
    /// Computes atan2(y, x), the angle of the point (x, y) from the positive x-axis.
    /// - Parameters:
    ///   - y: Y-coordinate
    ///   - x: X-coordinate
    /// - Returns: Angle in range (-180°, 180°] or (-π, π].
    static func atan2(_ y: Math, _ x: Math) -> Math {
        // Handle special cases
        if x > 0 {
            return atan(y / x)
        } else if x < 0 {
            if y >= 0 {
                let atanVal = atan(y / x)
                switch MathSettings.shared.angleMode {
                case .radians: return atanVal + .pi
                case .degrees: return atanVal + 180
                }
            } else {
                let atanVal = atan(y / x)
                switch MathSettings.shared.angleMode {
                case .radians: return atanVal - .pi
                case .degrees: return atanVal - 180
                }
            }
        } else { // x == 0
            if y > 0 {
                switch MathSettings.shared.angleMode {
                case .radians: return .pi / 2
                case .degrees: return 90
                }
            } else if y < 0 {
                switch MathSettings.shared.angleMode {
                case .radians: return -.pi / 2
                case .degrees: return -90
                }
            } else {
                return 0 // undefined, but return 0
            }
        }
    }

    // MARK: - Hyperbolic Functions

    /// Computes the hyperbolic sine: sinh(x) = (e^x - e^-x) / 2.
    /// - Parameter x: Any real value.
    /// - Returns: sinh(x).
    static func sinh(_ x: Math) -> Math {
        let expPos = Math.exp(x)
        let expNeg = Math.exp(-x)
        return (expPos - expNeg) / 2
    }

    /// Computes the hyperbolic cosine: cosh(x) = (e^x + e^-x) / 2.
    /// - Parameter x: Any real value.
    /// - Returns: cosh(x).
    static func cosh(_ x: Math) -> Math {
        let expPos = Math.exp(x)
        let expNeg = Math.exp(-x)
        return (expPos + expNeg) / 2
    }

    /// Computes the hyperbolic tangent: tanh(x) = sinh(x) / cosh(x).
    /// - Parameter x: Any real value.
    /// - Returns: tanh(x).
    static func tanh(_ x: Math) -> Math {
        return sinh(x) / cosh(x)
    }

    /// Computes the inverse hyperbolic sine: asinh(x) = ln(x + sqrt(x^2 + 1)).
    /// - Parameter x: Any real value.
    /// - Returns: asinh(x).
    static func asinh(_ x: Math) -> Math {
        return Math.ln(x + Math.sqrt(x * x + 1))
    }

    /// Computes the inverse hyperbolic cosine: acosh(x) = ln(x + sqrt(x^2 - 1)).
    /// - Parameter x: Value >= 1.
    /// - Returns: acosh(x).
    static func acosh(_ x: Math) -> Math {
        guard x >= 1 else {
            fatalError("acosh domain error: value must be >= 1")
        }
        return Math.ln(x + Math.sqrt(x * x - 1))
    }

    /// Computes the inverse hyperbolic tangent: atanh(x) = 0.5 * ln((1 + x) / (1 - x)).
    /// - Parameter x: Value in (-1, 1).
    /// - Returns: atanh(x).
    static func atanh(_ x: Math) -> Math {
        guard x > -1 && x < 1 else {
            fatalError("atanh domain error: value must be in (-1, 1)")
        }
        return Math.ln((1 + x) / (1 - x)) / 2
    }

    // MARK: - Helper Functions

    /// Computes e^x using Taylor series.
    /// - Parameter x: Exponent.
    /// - Returns: e^x.
    static func exp(_ x: Math) -> Math {
        var result: Math = 1
        var term: Math = 1
        let iterations = MathSettings.shared.precision

        for n in 1..<iterations {
            term *= x / Math(n)
            result += term
        }
        return result
    }

    /// Computes natural logarithm ln(x) using Newton-Raphson.
    /// - Parameter x: Value > 0.
    /// - Returns: ln(x).
    static func ln(_ x: Math) -> Math {
        guard x > 0 else {
            fatalError("ln domain error: value must be > 0")
        }

        // Initial guess
        var guess: Math = x < 1 ? 0 : 1

        let iterations = MathSettings.shared.precision
        for _ in 0..<iterations {
            let expGuess = exp(guess)
            guess -= (expGuess - x) / expGuess
        }
        return guess
    }

    /// Computes square root: sqrt(x).
    /// - Parameter x: Value >= 0.
    /// - Returns: sqrt(x).
    static func sqrt(_ x: Math) -> Math {
        guard x >= 0 else {
            fatalError("sqrt domain error: value must be >= 0")
        }
        return x |/ 2
    }
}

// MARK: - Triangle Solver

/// Represents a triangle with sides and angles.
///
/// ## Usage
/// Provide any 3 known values (sides and/or angles) and call `solve()` to compute the rest.
///
/// ## Naming Convention
/// - Sides: `a`, `b`, `c` (lowercase)
/// - Angles: `alpha` (∠A opposite side a), `beta` (∠B opposite side b), `gamma` (∠C opposite side c)
///
/// ## Example
/// ```swift
/// // Right triangle with sides 3, 4
/// var triangle = Triangle(a: 3, b: 4)
/// triangle.solve()
/// print(triangle.c)  // 5 (Pythagorean theorem)
/// print(triangle.alpha)  // ~36.87°
/// ```
///
/// ## Supported Cases
/// - **SSS** (3 sides): Uses Law of Cosines
/// - **SAS** (2 sides + included angle): Uses Law of Cosines
/// - **ASA** (2 angles + included side): Uses Law of Sines
/// - **AAS** (2 angles + non-included side): Uses Law of Sines
/// - **SSA** (2 sides + non-included angle): Ambiguous case, uses Law of Sines
///
/// - SeeAlso: `solve()`, `area`, `perimeter`
public struct Triangle {
    /// Side opposite to angle alpha
    public var a: Math?
    /// Side opposite to angle beta
    public var b: Math?
    /// Side opposite to angle gamma
    public var c: Math?

    /// Angle opposite to side a (in degrees or radians based on MathSettings)
    public var alpha: Math?
    /// Angle opposite to side b
    public var beta: Math?
    /// Angle opposite to side c
    public var gamma: Math?

    /// Creates a triangle with the given sides and angles.
    ///
    /// - Parameters:
    ///   - a: Side opposite angle alpha
    ///   - b: Side opposite angle beta
    ///   - c: Side opposite angle gamma
    ///   - alpha: Angle opposite side a
    ///   - beta: Angle opposite side b
    ///   - gamma: Angle opposite side c
    public init(a: Math? = nil, b: Math? = nil, c: Math? = nil,
                alpha: Math? = nil, beta: Math? = nil, gamma: Math? = nil) {
        self.a = a
        self.b = b
        self.c = c
        self.alpha = alpha
        self.beta = beta
        self.gamma = gamma
    }

    /// Number of known sides
    private var knownSides: Int {
        [a, b, c].compactMap { $0 }.count
    }

    /// Number of known angles
    private var knownAngles: Int {
        [alpha, beta, gamma].compactMap { $0 }.count
    }

    /// Solves the triangle using the known values.
    ///
    /// Requires at least 3 known values (combination of sides and angles).
    /// Modifies the triangle in place to fill in missing values.
    ///
    /// ## Throws
    /// - `fatalError` if fewer than 3 values are known
    /// - `fatalError` if the triangle is invalid (e.g., angles don't sum to 180°)
    ///
    /// ## Example
    /// ```swift
    /// var t = Triangle(a: 3, b: 4, gamma: 90)
    /// t.solve()
    /// print(t.c)  // 5
    /// ```
    public mutating func solve() {
        let totalKnown = knownSides + knownAngles

        guard totalKnown >= 3 else {
            fatalError("Triangle requires at least 3 known values to solve")
        }

        // Iterate until triangle is fully solved or no progress is made
        var iterations = 0
        let maxIterations = 10

        while (a == nil || b == nil || c == nil || alpha == nil || beta == nil || gamma == nil) && iterations < maxIterations {
            iterations += 1

            // Fill in missing angle if two angles are known (angles sum to 180°)
            if knownAngles == 2 {
                solveThirdAngle()
            }

            // SSS: All three sides known
            if knownSides == 3, knownAngles == 0 {
                solveSSS()
            }

            // SAS: Two sides and included angle
            if knownSides == 2, knownAngles == 1 {
                solveSAS()
            }

            // ASA or AAS: Two angles and one side
            if knownAngles == 2, knownSides == 1 {
                solveASA_AAS()
            }

            // SSA: Two sides and a non-included angle (ambiguous case)
            if knownSides == 2, knownAngles == 1 {
                solveSSA()
            }
        }

        // Validation
        if let a = alpha, let b = beta, let g = gamma {
            let sum = a + b + g
            let expected: Math = MathSettings.shared.angleMode == .degrees ? 180 : .pi
            let diff = abs(Double(sum - expected))
            if diff > 0.1 {
                print("Warning: Angles sum to \(sum), expected \(expected)")
            }
        }
    }

    // MARK: - Pythagorean Theorem Helpers

    /// Computes the hypotenuse: c = sqrt(a² + b²)
    ///
    /// ## Example
    /// ```swift
    /// let c = Triangle.pythagorean(a: 3, b: 4)  // 5
    /// ```
    public static func pythagorean(a: Math, b: Math) -> Math {
        return Math.sqrt(a * a + b * b)
    }

    /// Computes a leg: a = sqrt(c² - b²)
    ///
    /// ## Example
    /// ```swift
    /// let a = Triangle.pythagoreanLeg(c: 5, b: 4)  // 3
    /// ```
    public static func pythagoreanLeg(c: Math, b: Math) -> Math {
        guard c * c >= b * b else {
            fatalError("Invalid triangle: c² must be >= b²")
        }
        return Math.sqrt(c * c - b * b)
    }

    // MARK: - Computed Properties

    /// Perimeter of the triangle.
    public var perimeter: Math? {
        guard let a = a, let b = b, let c = c else { return nil }
        return a + b + c
    }

    /// Area of the triangle using Heron's formula.
    public var area: Math? {
        guard let a = a, let b = b, let c = c else { return nil }
        let s = (a + b + c) / 2  // semi-perimeter
        let product = s * (s - a) * (s - b) * (s - c)
        guard product >= 0 else { return nil }
        return Math.sqrt(product)
    }

    // MARK: - Private Solving Methods

    /// Solves for the third angle when two angles are known.
    private mutating func solveThirdAngle() {
        let angleSum: Math = MathSettings.shared.angleMode == .degrees ? 180 : .pi

        if alpha == nil, let b = beta, let g = gamma {
            alpha = angleSum - b - g
        } else if beta == nil, let a = alpha, let g = gamma {
            beta = angleSum - a - g
        } else if gamma == nil, let a = alpha, let b = beta {
            gamma = angleSum - a - b
        }
    }

    /// Solves triangle when all three sides are known (SSS).
    /// Uses Law of Cosines: cos(A) = (b² + c² - a²) / (2bc)
    private mutating func solveSSS() {
        guard let sideA = a, let sideB = b, let sideC = c else { return }

        if alpha == nil {
            // cos(alpha) = (b² + c² - a²) / (2bc)
            let cosAlpha = (sideB * sideB + sideC * sideC - sideA * sideA) / (2 * sideB * sideC)
            alpha = Calculate(settings: .init(angleMode: MathSettings.shared.angleMode, precision: MathSettings.shared.precision)) {
                Math.acos(cosAlpha)
            }
        }

        if beta == nil {
            let cosBeta = (sideA * sideA + sideC * sideC - sideB * sideB) / (2 * sideA * sideC)
            beta = Calculate(settings: .init(angleMode: MathSettings.shared.angleMode, precision: MathSettings.shared.precision)) {
                Math.acos(cosBeta)
            }
        }

        if gamma == nil {
            let cosGamma = (sideA * sideA + sideB * sideB - sideC * sideC) / (2 * sideA * sideB)
            gamma = Calculate(settings: .init(angleMode: MathSettings.shared.angleMode, precision: MathSettings.shared.precision)) {
                Math.acos(cosGamma)
            }
        }
    }

    /// Solves triangle when two sides and included angle are known (SAS).
    /// Uses Law of Cosines: c² = a² + b² - 2ab·cos(C)
    private mutating func solveSAS() {
        // Case: a, b, gamma known
        if let sideA = a, let sideB = b, let angleGamma = gamma, c == nil {
            // c² = a² + b² - 2ab·cos(gamma)
            let cosGamma = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
                Math.cos(angleGamma)
            }
            let cSquared = sideA * sideA + sideB * sideB - 2 * sideA * sideB * cosGamma
            c = Math.sqrt(cSquared)
        }

        // Case: a, c, beta known
        if let sideA = a, let sideC = c, let angleBeta = beta, b == nil {
            let cosBeta = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
                Math.cos(angleBeta)
            }
            let bSquared = sideA * sideA + sideC * sideC - 2 * sideA * sideC * cosBeta
            b = Math.sqrt(bSquared)
        }

        // Case: b, c, alpha known
        if let sideB = b, let sideC = c, let angleAlpha = alpha, a == nil {
            let cosAlpha = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
                Math.cos(angleAlpha)
            }
            let aSquared = sideB * sideB + sideC * sideC - 2 * sideB * sideC * cosAlpha
            a = Math.sqrt(aSquared)
        }
    }

    /// Solves triangle when two angles and one side are known (ASA/AAS).
    /// Uses Law of Sines: a/sin(A) = b/sin(B) = c/sin(C)
    private mutating func solveASA_AAS() {
        // First ensure all angles are known
        solveThirdAngle()

        guard let angleAlpha = alpha, let angleBeta = beta, let angleGamma = gamma else { return }

        let sinAlpha = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            Math.sin(angleAlpha)
        }
        let sinBeta = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            Math.sin(angleBeta)
        }
        let sinGamma = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
            Math.sin(angleGamma)
        }

        // Use Law of Sines to find missing sides
        if let sideA = a {
            if b == nil {
                b = sideA * sinBeta / sinAlpha
            }
            if c == nil {
                c = sideA * sinGamma / sinAlpha
            }
        } else if let sideB = b {
            if a == nil {
                a = sideB * sinAlpha / sinBeta
            }
            if c == nil {
                c = sideB * sinGamma / sinBeta
            }
        } else if let sideC = c {
            if a == nil {
                a = sideC * sinAlpha / sinGamma
            }
            if b == nil {
                b = sideC * sinBeta / sinGamma
            }
        }
    }

    /// Solves triangle when two sides and a non-included angle are known (SSA).
    /// This is the ambiguous case - may have 0, 1, or 2 solutions.
    private mutating func solveSSA() {
        // Case: a, b, alpha known
        if let sideA = a, let sideB = b, let angleAlpha = alpha, beta == nil {
            let sinAlpha = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
                Math.sin(angleAlpha)
            }
            let sinBeta = sideB * sinAlpha / sideA

            // Check if solution exists
            guard sinBeta <= 1 && sinBeta >= -1 else {
                fatalError("No valid triangle (SSA case): sin(beta) out of range")
            }

            beta = Calculate(settings: .init(angleMode: MathSettings.shared.angleMode, precision: MathSettings.shared.precision)) {
                Math.asin(sinBeta)
            }
        }

        // Case: a, c, alpha known
        if let sideA = a, let sideC = c, let angleAlpha = alpha, gamma == nil {
            let sinAlpha = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
                Math.sin(angleAlpha)
            }
            let sinGamma = sideC * sinAlpha / sideA

            guard sinGamma <= 1 && sinGamma >= -1 else {
                fatalError("No valid triangle (SSA case): sin(gamma) out of range")
            }

            gamma = Calculate(settings: .init(angleMode: MathSettings.shared.angleMode, precision: MathSettings.shared.precision)) {
                Math.asin(sinGamma)
            }
        }

        // Case: b, c, beta known
        if let sideB = b, let sideC = c, let angleBeta = beta, gamma == nil {
            let sinBeta = Calculate(settings: .init(angleMode: .radians, precision: MathSettings.shared.precision)) {
                Math.sin(angleBeta)
            }
            let sinGamma = sideC * sinBeta / sideB

            guard sinGamma <= 1 && sinGamma >= -1 else {
                fatalError("No valid triangle (SSA case): sin(gamma) out of range")
            }

            gamma = Calculate(settings: .init(angleMode: MathSettings.shared.angleMode, precision: MathSettings.shared.precision)) {
                Math.asin(sinGamma)
            }
        }
    }
}
