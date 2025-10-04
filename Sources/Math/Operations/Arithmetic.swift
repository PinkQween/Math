//
//  Arithmetic.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation
import BigInt

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
        let scale = max(ls, rs) + 10 // precision buffer
        let factor = BigInt(10).power(scale)
        let quotient = (lv * factor) / rv
        return .init(bigDecimal: quotient, scale: scale)
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
