//
//  Arithmetic.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation


// MARK: - Arithmetic Operators

public extension Math {

    static func + (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv + rv, scale: scale)
    }

    static func - (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv - rv, scale: scale)
    }

    static func * (lhs: Math, rhs: Math) -> Math {
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()
        return .init(bigDecimal: lv * rv, scale: ls + rs)
    }

    static func / (lhs: Math, rhs: Math) -> Math {
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()

        // Guard against division by zero
        guard rv != 0 else {
            fatalError("Division by zero")
        }

        // For (lv/10^ls) / (rv/10^rs), we need scale = ls - rs + precision
        let precision = 10
        let resultScale = ls - rs + precision
        let factor = BigInt(10).power(precision)
        let quotient = (lv * factor) / rv
        return .init(bigDecimal: quotient, scale: resultScale)
    }

    static func % (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv % rv, scale: scale)
    }

    static func += (lhs: inout Math, rhs: Math) { lhs = lhs + rhs }
    static func -= (lhs: inout Math, rhs: Math) { lhs = lhs - rhs }
    static func *= (lhs: inout Math, rhs: Math) { lhs = lhs * rhs }
    static func /= (lhs: inout Math, rhs: Math) { lhs = lhs / rhs }
    static func %= (lhs: inout Math, rhs: Math) { lhs = lhs % rhs }
}
