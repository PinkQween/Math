//
//  Geometry.swift
//  Math
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
}

// MARK: - Triangle Solver (Commented Out)
// The following triangle solver is currently inactive. It can solve triangles
// using combinations of the Law of Sines and Law of Cosines, and compute
// perimeter or area. Requires at least 3 known pieces of information
// (sides/angles) to solve.
//
// ⚠️ Warning: Trigonometric calculations like sin(45°) ≈ 1/sqrt(2) are
// untested for full precision due to small floating-point errors (~1e-16).

/*
struct Triangle {
    var a: Math? // side opposite alpha
    var b: Math?
    var c: Math?
    var alpha: Math? // angle in degrees
    var beta: Math?
    var gamma: Math?
    
    ...
}
*/
