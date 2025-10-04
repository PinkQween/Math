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

        // Special cases
        if nDouble == 1 { return lhs }
        if lhsDouble == 0 { return Math(0) }
        if nDouble == 2 { return Math(floatLiteral: sqrt(lhsDouble)) }

        // Use Swift's pow for direct calculation
        let result = pow(lhsDouble, 1.0 / nDouble)
        return Math(floatLiteral: result)
    }

    /// Alternative root operator syntax.
    static func √ (lhs: Math, rhs: Math) -> Math { lhs |/ rhs }
}
