//
//  Roots.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Roots

infix operator |/: ExponentiationPrecedence
infix operator √: ExponentiationPrecedence

public extension Math {
    /// Computes n-th root using Newton's method. Only positive values.
    ///
    /// - Parameters:
    ///   - lhs: The value to compute the root of
    ///   - rhs: The degree of the root (e.g., 2 for square root)
    /// - Returns: The n-th root of the value
    static func |/ (lhs: Math, rhs: Math) -> Math {
        guard rhs > 0 else { fatalError("Root degree must be positive") }
        guard lhs >= 0 else { fatalError("Cannot compute real root of negative number") }
        guard let lhsDouble = lhs.asDouble, let nDouble = rhs.asDouble else {
            fatalError("Cannot convert Math to Double for root calculation")
        }

        var x = lhsDouble / nDouble
        let iterations = min(Int(MathSettings.shared.precision.asDouble ?? 100), 10_000)
        let tolerance = 1e-12

        for _ in 0..<iterations {
            let xPrev = x
            x = ((nDouble - 1) * x + lhsDouble / pow(x, nDouble - 1)) / nDouble
            if abs(x - xPrev) < tolerance { break }
        }
        return Math(floatLiteral: x)
    }

    /// Alternative root operator syntax.
    static func √ (lhs: Math, rhs: Math) -> Math { lhs |/ rhs }
}
