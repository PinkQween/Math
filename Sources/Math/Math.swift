//
//  Math.swift
//  Math Library
//
//  Created by Hanna Skairipa on 9/19/25.
//
//  Core Math type supporting arbitrary-precision arithmetic, hyperoperations,
//  factorials, roots, and angle-based functions. Includes thread-safe global
//  settings and helpers for calculations.
//

import Foundation
import BigInt

// MARK: - Angle Modes
/// Determines how angles are interpreted.
public enum AngleMode: Sendable {
    case degrees
    case radians
}

// MARK: - Math State
/// Encapsulates calculation settings for Math operations.
/// Can be expanded with rounding modes or additional precision options.
public struct MathState: Sendable {
    public var angleMode: AngleMode
    public var precision: Math
}

// MARK: - Global Math Settings
/// Thread-safe singleton storing global settings for Math calculations.
public final class MathSettings: @unchecked Sendable {
    public static let shared = MathSettings()
    private init() {}
    
    private let lock = NSLock()
    
    private var _angleMode: AngleMode = .degrees
    private var _percision: Math = 28174
    
    // Thread-safe accessors
    public var angleMode: AngleMode {
        get { lock.withLock { _angleMode } }
        set { lock.withLock { _angleMode = newValue } }
    }
    
    public var percision: Math {
        get { lock.withLock { _percision } }
        set { lock.withLock { _percision = newValue } }
    }
    
    /// Get or set the full state atomically.
    public var state: MathState {
        get { lock.withLock { MathState(angleMode: _angleMode, precision: _percision ) } }
        set { lock.withLock { _angleMode = newValue.angleMode; _percision = newValue.precision } }
    }
}

// MARK: - Lock Convenience
extension NSLock {
    /// Executes a closure while holding the lock for thread safety.
    func withLock<T>(_ body: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try body()
    }
}

// MARK: - Scoped Calculation
/// Temporarily sets a MathState for the duration of the closure, then restores old state.
public func Calculate<T>(
    settings newState: MathState,
    perform work: () throws -> T
) rethrows -> T {
    let oldState = MathSettings.shared.state
    MathSettings.shared.state = newState
    defer { MathSettings.shared.state = oldState }
    return try work()
}

// MARK: - Internal Storage
/// Represents numeric values internally.
public enum MathStorage: Sendable {
    case int(Int)
    case double(Double)
    case bigInt(BigInt)
    case bigDecimal(BigInt, scale: Int)
}

// MARK: - Number Protocol
/// Protocol conformance for numeric behaviors Math supports.
public protocol NumberProtocol: Equatable, Comparable, ExpressibleByIntegerLiteral,
    ExpressibleByFloatLiteral, ExpressibleByStringLiteral, Sendable, Strideable {}

// MARK: - Core Math Type
/// Main type supporting arbitrary-precision math, hyperoperations, roots, and factorials.
public struct Math: NumberProtocol {
    private var storage: MathStorage
    public typealias Stride = Int
    
    // MARK: - Conversion Helpers
    public var asDouble: Double? {
        switch storage {
        case .int(let v): return Double(v)
        case .double(let v): return v
        case .bigInt(let v): return Double(String(v))
        case .bigDecimal(let v, let scale):
            if let base = Double(String(v)) {
                return base / pow(10.0, Double(scale))
            }
            return nil
        }
    }
    
    public var asInt: Int? {
        switch storage {
        case .int(let v): return v
        case .bigInt(let v): return Int(v)
        case .double(let v): return Int(v)
        case .bigDecimal(let v, let scale):
            let divisor = pow(10.0, Double(scale))
            return Int((Double(String(v)) ?? 0) / divisor)
        }
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
    
    // MARK: - Initializers
    public init(integerLiteral value: Int) { self.storage = .int(value) }
    public init(floatLiteral value: Double) { self.storage = value.isFinite ? .double(value) : .double(0) }
    
    public init(stringLiteral value: String) {
        if let intVal = Int(value) { self.storage = .int(intVal) }
        else if let dblVal = Double(value) { self.storage = .double(dblVal) }
        else if value.contains(".") {
            let parts = value.split(separator: ".")
            let scale = parts[1].count
            let combined = parts.joined()
            self.storage = .bigDecimal(BigInt(combined) ?? BigInt(0), scale: scale)
        } else {
            self.storage = .bigInt(BigInt(value) ?? BigInt(0))
        }
    }
    
    public init(_ value: Math) { self = value }
    
    // MARK: - BigDecimal Helpers
    private func asBigDecimal() -> (BigInt, Int) {
        switch storage {
        case .int(let v): return (BigInt(v), 0)
        case .double(let v):
            let str = String(v)
            if let dot = str.firstIndex(of: ".") {
                let decimals = str.distance(from: dot, to: str.endIndex) - 1
                let cleaned = str.replacingOccurrences(of: ".", with: "")
                return (BigInt(cleaned) ?? BigInt(0), decimals)
            } else {
                return (BigInt(Int(v)), 0)
            }
        case .bigInt(let v): return (v, 0)
        case .bigDecimal(let v, let scale): return (v, scale)
        }
    }
    
    private func align(_ other: Math) -> (BigInt, BigInt, Int) {
        let (lv, ls) = self.asBigDecimal()
        let (rv, rs) = other.asBigDecimal()
        if ls == rs { return (lv, rv, ls) }
        else if ls > rs { return (lv, rv * BigInt(10).power(ls - rs), ls) }
        else { return (lv * BigInt(10).power(rs - ls), rv, rs) }
    }
    
    // MARK: - Comparison Operators
    public static func == (lhs: Math, rhs: Math) -> Bool {
        let (lv, rv, _) = lhs.align(rhs)
        return lv == rv
    }
    
    public static func < (lhs: Math, rhs: Math) -> Bool {
        let (lv, rv, _) = lhs.align(rhs)
        return lv < rv
    }
}

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
    
    // BigDecimal initializer
    init(bigDecimal value: BigInt, scale: Int) {
        self.storage = scale == 0 ? .bigInt(value) : .bigDecimal(value, scale: scale)
    }
}

// MARK: - Hyperoperation Precedence Groups
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

// Hyperoperation operators
infix operator **: ExponentiationPrecedence
infix operator ^^: TetrationPrecedence
infix operator ^^^: PentationPrecedence
infix operator ^^^^: HexationPrecedence
infix operator ^^^^^: HeptationPrecedence
infix operator ^^^^^^: OctationPrecedence
infix operator ^^^^^^^: NonationPrecedence
infix operator ^^^^^^^^: DekationPrecedence

public extension Math {
    /// Recursive hyperoperation implementation. Level 2 = exponentiation, 3 = tetration, etc.
    private static func hyper(_ a: Math, _ b: Math, level: Int) -> Math {
        let n: Int
        switch b.storage {
        case .int(let v): n = v
        case .bigInt(let v): n = Int(v)
        case .double(let v): n = Int(v)
        case .bigDecimal(let v, _): n = Int(v)
        }
        guard n > 0 else { return Math(integerLiteral: 1) }
        
        switch level {
        case 2: return n == 1 ? a : a ** hyper(a, Math(integerLiteral: n - 1), level: 2)
        case 3: return n == 1 ? a : a ** hyper(a, Math(integerLiteral: n - 1), level: 3)
        case 4: return n == 1 ? a : hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 3), level: 3)
        case 5: return n == 1 ? a : hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 4), level: 4)
        case 6: return n == 1 ? a : hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 5), level: 5)
        case 7: return n == 1 ? a : hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 6), level: 6)
        case 8: return n == 1 ? a : hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 7), level: 7)
        case 9: return n == 1 ? a : hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 8), level: 8)
        default: return Math(integerLiteral: 0)
        }
    }
    
    static func ** (lhs: Math, rhs: Math) -> Math { let (lv, rv, scale) = lhs.align(rhs); return .init(bigDecimal: lv.power(Int(rv)), scale: scale) }
    static func ^^ (lhs: Math, rhs: Math) -> Math { return hyper(lhs, rhs, level: 3) }
    static func ^^^ (lhs: Math, rhs: Math) -> Math { return hyper(lhs, rhs, level: 4) }
    static func ^^^^ (lhs: Math, rhs: Math) -> Math { return hyper(lhs, rhs, level: 5) }
    static func ^^^^^ (lhs: Math, rhs: Math) -> Math { return hyper(lhs, rhs, level: 6) }
    static func ^^^^^^ (lhs: Math, rhs: Math) -> Math { return hyper(lhs, rhs, level: 7) }
    static func ^^^^^^^ (lhs: Math, rhs: Math) -> Math { return hyper(lhs, rhs, level: 8) }
    static func ^^^^^^^^ (lhs: Math, rhs: Math) -> Math { return hyper(lhs, rhs, level: 9) }
}

// MARK: - Factorial Operator
postfix operator ~!
public extension Math {
    /// Factorial of non-negative integers. Returns 1 for negative numbers.
    static postfix func ~! (x: Math) -> Math {
        guard case let .int(n) = x.storage, n >= 0 else { return Math(integerLiteral: 1) }
        var result = 1
        for i in 1...n { result *= i }
        return Math(integerLiteral: result)
    }
}

// MARK: - Root Operator
infix operator |/: ExponentiationPrecedence
public extension Math {
    /// Computes n-th root using iterative approximation. Only positive values.
    static func |/ (lhs: Math, rhs: Math) -> Math {
        guard rhs > 0 else { fatalError("Root degree must be positive") }
        guard lhs >= 0 else { fatalError("Cannot compute real root of negative number") }
        
        guard let lhsDouble = lhs.asDouble, let nDouble = rhs.asDouble else { fatalError("Cannot convert Math to Double for root calculation") }
        
        var x = lhsDouble / nDouble
        let iterations = min(Int(MathSettings.shared.percision.asDouble ?? 100), 10_000)
        let tolerance = 1e-12
        
        for _ in 0..<iterations {
            let xPrev = x
            x = ((nDouble - 1) * x + lhsDouble / pow(x, nDouble - 1)) / nDouble
            if abs(x - xPrev) < tolerance { break }
        }
        
        return Math(floatLiteral: x)
    }
}

// MARK: - Numeric Conversions
public extension Int { init(_ value: Math) { self = value.asInt ?? 0 } }
public extension Double { init(_ value: Math) { self = value.asDouble ?? 0 } }
public extension Float { init(_ value: Math) { self = value.asDouble.map(Float.init) ?? 0 } }

