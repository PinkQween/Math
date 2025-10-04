//
//  Math.swift
//  Math
//
//  Created by Hanna Skairipa on 9/19/25.
//

import Foundation


// MARK: - Core Math Type

/// Main type supporting arbitrary-precision math, hyperoperations, roots, and factorials.
public struct Math: NumberProtocol {
    internal var storage: MathStorage
    public typealias Stride = Int

    // MARK: - Initializers

    public init(integerLiteral value: Int) {
        self.storage = .int(value)
    }

    public init(floatLiteral value: Double) {
        self.storage = .double(value.isFinite ? value : 0)
    }

    public init(stringLiteral value: String) {
        if let intVal = Int(value) {
            self.storage = .int(intVal)
        } else if let dblVal = Double(value) {
            self.storage = .double(dblVal)
        } else if value.contains(".") {
            let parts = value.split(separator: ".")
            let scale = parts.count > 1 ? parts[1].count : 0
            let combined = parts.joined()
            self.storage = .bigDecimal(BigInt(combined) ?? .zero, scale: scale)
        } else {
            self.storage = .bigInt(BigInt(value) ?? .zero)
        }
    }

    public init(_ value: Math) {
        self = value
    }

    /// Internal initializer for BigDecimal values.
    init(bigDecimal value: BigInt, scale: Int) {
        self.storage = (scale == 0) ? .bigInt(value) : .bigDecimal(value, scale: scale)
    }

    // MARK: - Conversion Helpers

    /// Converts this value to a `Double`, if possible.
    public var asDouble: Double? {
        switch storage {
        case .int(let v): return Double(v)
        case .double(let v): return v
        case .bigInt(let v): return Double(String(v))
        case .bigDecimal(let v, let scale):
            guard let base = Double(String(v)) else { return nil }
            return base / pow(10.0, Double(scale))
        }
    }

    /// Converts this value to an `Int`, if possible.
    public var asInt: Int? {
        switch storage {
        case .int(let v): return v
        case .double(let v): return Int(v)
        case .bigInt(let v): return Int(v)
        case .bigDecimal(let v, let scale):
            let divisor = pow(10.0, Double(scale))
            return Int((Double(String(v)) ?? 0) / divisor)
        }
    }

    // MARK: - BigDecimal Helpers

    /// Returns the value as a BigDecimal (BigInt with scale).
    public func asBigDecimal() -> (BigInt, Int) {
        switch storage {
        case .int(let v): return (BigInt(v), 0)
        case .double(let v):
            // Handle zero
            if v == 0 { return (.zero, 0) }

            // Use Decimal's internal representation for accuracy
            var decimal = Decimal(v)
            var rounded = Decimal()
            NSDecimalRound(&rounded, &decimal, 15, .plain) // Round to 15 significant digits

            // Extract components
            let isNegative = rounded < 0
            let absDecimal = abs(rounded)

            // Convert to string with enough precision
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 15
            formatter.usesGroupingSeparator = false

            guard let str = formatter.string(from: absDecimal as NSNumber) else {
                return (BigInt(Int(v)), 0)
            }

            var resultStr = str
            if isNegative {
                resultStr = "-" + resultStr
            }

            if let dot = resultStr.firstIndex(of: ".") {
                let decimals = resultStr.distance(from: dot, to: resultStr.endIndex) - 1
                let cleaned = resultStr.replacingOccurrences(of: ".", with: "")
                return (BigInt(cleaned) ?? .zero, decimals)
            }
            return (BigInt(resultStr) ?? .zero, 0)
        case .bigInt(let v): return (v, 0)
        case .bigDecimal(let v, let scale): return (v, scale)
        }
    }

    /// Aligns two Math values to the same scale for arithmetic operations.
    internal func align(_ other: Math) -> (BigInt, BigInt, Int) {
        let (lv, ls) = self.asBigDecimal()
        let (rv, rs) = other.asBigDecimal()
        if ls == rs { return (lv, rv, ls) }
        if ls > rs { return (lv, rv * BigInt(10).power(ls - rs), ls) }
        return (lv * BigInt(10).power(rs - ls), rv, rs)
    }

    // MARK: - Strideable Conformance

    public func distance(to other: Math) -> Int {
        guard let lhs = self.asDouble, let rhs = other.asDouble else { return 0 }
        return Int(round(rhs - lhs))
    }

    public func advanced(by n: Int) -> Math {
        switch storage {
        case .int(let v): return Math(integerLiteral: v + n)
        case .double(let v): return Math(floatLiteral: v + Double(n))
        case .bigInt(let v): return Math(bigDecimal: v + BigInt(n), scale: 0)
        case .bigDecimal(let v, let scale):
            let addVal = BigInt(n) * BigInt(10).power(scale)
            return Math(bigDecimal: v + addVal, scale: scale)
        }
    }

    // MARK: - Equatable & Comparable

    public static func == (lhs: Math, rhs: Math) -> Bool {
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()

        if ls > rs {
            let scaleDiff = ls - rs
            return lv == rv * BigInt(10).power(scaleDiff)
        } else if rs > ls {
            let scaleDiff = rs - ls
            return lv * BigInt(10).power(scaleDiff) == rv
        } else {
            return lv == rv
        }
    }

    public static func < (lhs: Math, rhs: Math) -> Bool {
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()

        if ls > rs {
            let scaleDiff = ls - rs
            return lv < rv * BigInt(10).power(scaleDiff)
        } else if rs > ls {
            let scaleDiff = rs - ls
            return lv * BigInt(10).power(scaleDiff) < rv
        } else {
            return lv < rv
        }
    }

}

// MARK: - String Convertible

extension Math: CustomStringConvertible {
    /// A textual description of the `Math` value.
    ///
    /// Handles conversion for:
    /// - `Int`
    /// - `Double`
    /// - `BigInt`
    /// - `BigDecimal` (with proper decimal placement and trimming of trailing zeros).
    public var description: String {
        switch storage {
        case .int(let v):
            return "\(v)"
        case .double(let v):
            return String(v)
        case .bigInt(let v):
            return v.description
        case .bigDecimal(let v, let scale):
            var s = v.description
            if scale == 0 { return s }

            // Pad with leading zeros if scale > length
            if s.count <= scale {
                s = String(repeating: "0", count: scale - s.count + 1) + s
            }

            // Insert decimal point
            let index = s.index(s.endIndex, offsetBy: -scale)
            s.insert(".", at: index)

            // Strip trailing zeros
            while s.last == "0" { s.removeLast() }
            if s.last == "." { s.removeLast() }

            return s
        }
    }
}

// MARK: - SwiftUI Support

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension LocalizedStringKey.StringInterpolation {

    /// Interpolates `Math` safely in SwiftUI `Text`.
    public mutating func appendInterpolation(_ value: Math) {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            appendInterpolation(value.localizedStringResource)
        } else {
            appendLiteral(value.description)
        }
    }
}

extension Math {
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public var localizedStringResource: LocalizedStringResource {
        .init(stringLiteral: description)
    }
}
#endif

// MARK: - Numeric Conversions

public extension Int    { init(_ value: Math) { self = value.asInt ?? 0 } }
public extension Double { init(_ value: Math) { self = value.asDouble ?? 0 } }
public extension Float  { init(_ value: Math) { self = value.asDouble.map(Float.init) ?? 0 } }
