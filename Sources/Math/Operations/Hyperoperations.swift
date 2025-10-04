//
//  Hyperoperations.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation
import BigInt

// MARK: - Hyperoperations

precedencegroup ExponentiationPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: right
}

precedencegroup TetrationPrecedence {
    higherThan: ExponentiationPrecedence
    associativity: right
}

precedencegroup PentationPrecedence {
    higherThan: TetrationPrecedence
    associativity: right
}

precedencegroup HexationPrecedence {
    higherThan: PentationPrecedence
    associativity: right
}

precedencegroup HeptationPrecedence {
    higherThan: HexationPrecedence
    associativity: right
}

precedencegroup OctationPrecedence {
    higherThan: HeptationPrecedence
    associativity: right
}

precedencegroup NonationPrecedence {
    higherThan: OctationPrecedence
    associativity: right
}

precedencegroup DekationPrecedence {
    higherThan: NonationPrecedence
    associativity: right
}

// Operators
infix operator **: ExponentiationPrecedence
infix operator ^^: TetrationPrecedence
infix operator ^^^: PentationPrecedence
infix operator ^^^^: HexationPrecedence
infix operator ^^^^^: HeptationPrecedence
infix operator ^^^^^^: OctationPrecedence
infix operator ^^^^^^^: NonationPrecedence
infix operator ^^^^^^^^: DekationPrecedence

public extension Math {
    /// Generalized hyperoperation:
    /// Level 0 = addition, 1 = multiplication, 2 = exponentiation,
    /// 3 = tetration, 4 = pentation, etc.
    ///
    /// - Parameters:
    ///   - a: Base
    ///   - b: Height/iteration count
    ///   - level: Hyperoperation level
    /// - Returns: Result of hyperoperation `H_level(a, b)`
    static func hyper(_ a: Math, _ b: Math, level: Int) -> Math {
        // Validate input
        guard level >= 0 else { fatalError("Hyperoperation level must be non-negative") }
        guard let n = b.asInt, n >= 0 else { fatalError("Hyperoperation 'b' must be non-negative integer") }

        // Base cases for hyperoperations
        switch level {
        case 0: // Addition: a + b
            return a + b
        case 1: // Multiplication: a * b
            return a * b
        case 2: // Exponentiation: a ** b
            return a ** b
        case 3 where n == 0: // Tetration: a^^0 = 1
            return 1
        default:
            if n == 0 { return 1 } // General fallback: H_level(a,0) = 1
        }

        // Use iterative approach for levels >= 3 to avoid stack overflow
        var result: Math = 1
        switch level {
        case 3: // Tetration: a^^b = a^(a^(... b times))
            result = 1
            for _ in 0..<n {
                result = a ** result
            }
        default:
            // For level > 3: hyperoperation recursive definition
            result = 1
            var temp = Math(1)
            for _ in 0..<n {
                temp = hyper(a, temp, level: level - 1)
            }
            result = temp
        }

        return result
    }

    /// Exponentiation operator.
    static func ** (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv.power(Int(rv)), scale: scale)
    }

    /// Tetration operator.
    static func ^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 3) }

    /// Pentation operator.
    static func ^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 4) }

    /// Hexation operator.
    static func ^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 5) }

    /// Heptation operator.
    static func ^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 6) }

    /// Octation operator.
    static func ^^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 7) }

    /// Nonation operator.
    static func ^^^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 8) }

    /// Dekation operator.
    static func ^^^^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 9) }
}
