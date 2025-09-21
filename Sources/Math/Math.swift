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
/// Represents the configuration for performing math operations.
///
/// A `MathState` defines how calculations are carried out globally
/// or within a scoped calculation. You can adjust properties such as
/// angle measurement (degrees vs. radians) and precision settings.
/// In the future, this type may be expanded to include rounding modes
/// or other options that influence numerical results.
public struct MathState: Sendable {
    
    /// The mode in which angles are interpreted (e.g. degrees or radians).
    public var angleMode: AngleMode
    
    /// The numeric precision used for calculations.
    ///
    /// For example, this can determine the number of digits preserved
    /// in results or the size of intermediate values in arbitrary-precision math.
    public var precision: Math
}

// MARK: - Global Math Settings
/// Thread-safe singleton storing global settings for Math calculations.
public final class MathSettings: @unchecked Sendable {
    public static let shared = MathSettings()
    private init() {}
    
    private let lock = NSLock()
    
    private var _angleMode: AngleMode = .degrees
    private var _precision: Math = 28174
    
    // Thread-safe accessors
    public var angleMode: AngleMode {
        get { lock.withLock { _angleMode } }
        set { lock.withLock { _angleMode = newValue } }
    }
    
    public var precision: Math {
        get { lock.withLock { _precision } }
        set { lock.withLock { _precision = newValue } }
    }
    
    /// Get or set the full state atomically.
    public var state: MathState {
        get { lock.withLock { MathState(angleMode: _angleMode, precision: _precision) } }
        set { lock.withLock {
            _angleMode = newValue.angleMode
            _precision = newValue.precision
        }}
    }
}

// MARK: - Lock Convenience
extension NSLock {
    /// Executes a closure while holding the lock for thread safety.
    ///
    /// This method locks the receiver before invoking the closure and
    /// guarantees that the lock is released afterward, even if the closure
    /// throws an error. It provides a safe and concise way to perform
    /// synchronized work without having to manually call `lock()` and `unlock()`.
    ///
    /// - Parameter body: A closure containing the critical section of code
    ///   that must be executed while the lock is held.
    /// - Returns: The value returned by the closure.
    /// - Throws: Rethrows any error that the closure throws.
    func withLock<T>(_ body: () throws -> T) rethrows -> T {
        lock(); defer { unlock() }
        return try body()
    }
}


// MARK: - Scoped Calculation
/// Executes a block of work under a temporary ``MathState``.
///
/// This function replaces the current global math settings with a new state
/// for the duration of the provided closure, ensuring the previous state
/// is restored afterward (even if the closure throws).
///
/// Use this when you want to perform calculations with specific precision,
/// angle mode, or other math settings without permanently changing
/// the global environment.
///
/// - Parameters:
///   - newState: The temporary math state to use while executing `work`.
///   - work: A closure containing the calculations to perform under the
///           temporary state.
/// - Returns: The result of the closure.
/// - Throws: Rethrows any error thrown by `work`.
///
/// - Note: The global ``MathSettings`` is always restored after `work` completes,
///         regardless of whether it returns normally or throws.
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
public enum MathStorage: Sendable, Hashable {
    case int(Int)
    case double(Double)
    case bigInt(BigInt)
    case bigDecimal(BigInt, scale: Int)
}

// MARK: - Number Protocol
/// Protocol conformance for numeric behaviors Math supports.
public protocol NumberProtocol: Equatable, Comparable, ExpressibleByIntegerLiteral,
                                ExpressibleByFloatLiteral, ExpressibleByStringLiteral, Sendable, Strideable, Hashable {}

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
            guard let base = Double(String(v)) else { return nil }
            return base / pow(10.0, Double(scale))
        }
    }
    
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
    public init(floatLiteral value: Double) { self.storage = .double(value.isFinite ? value : 0) }
    
    public init(stringLiteral value: String) {
        if let intVal = Int(value) { self.storage = .int(intVal) }
        else if let dblVal = Double(value) { self.storage = .double(dblVal) }
        else if value.contains(".") {
            let parts = value.split(separator: ".")
            let scale = parts[1].count
            let combined = parts.joined()
            self.storage = .bigDecimal(BigInt(combined) ?? .zero, scale: scale)
        } else {
            self.storage = .bigInt(BigInt(value) ?? .zero)
        }
    }
    
    public init(_ value: Math) { self = value }
    
    // BigDecimal initializer
    init(bigDecimal value: BigInt, scale: Int) {
        self.storage = (scale == 0) ? .bigInt(value) : .bigDecimal(value, scale: scale)
    }
    
    // MARK: - BigDecimal Helpers
    public func asBigDecimal() -> (BigInt, Int) {
        switch storage {
        case .int(let v): return (BigInt(v), 0)
        case .double(let v):
            let str = String(v)
            if let dot = str.firstIndex(of: ".") {
                let decimals = str.distance(from: dot, to: str.endIndex) - 1
                let cleaned = str.replacingOccurrences(of: ".", with: "")
                return (BigInt(cleaned) ?? .zero, decimals)
            }
            return (BigInt(Int(v)), 0)
        case .bigInt(let v): return (v, 0)
        case .bigDecimal(let v, let scale): return (v, scale)
        }
    }
    
    private func align(_ other: Math) -> (BigInt, BigInt, Int) {
        let (lv, ls) = self.asBigDecimal()
        let (rv, rs) = other.asBigDecimal()
        if ls == rs { return (lv, rv, ls) }
        if ls > rs { return (lv, rv * BigInt(10).power(ls - rs), ls) }
        return (lv * BigInt(10).power(rs - ls), rv, rs)
    }
    
    public static func == (lhs: Math, rhs: Math) -> Bool {
        // Convert both to BigDecimal form (BigInt + scale)
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()
        
        // Adjust scales to match
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
        // Convert both to BigDecimal form (BigInt + scale)
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()
        
        // Adjust scales to match
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
    
    /// Determines whether the current value is a prime number.
    ///
    /// A *prime number* is a positive integer greater than `1` whose only divisors
    /// are `1` and itself. Equivalently, `n` is prime if there does **not** exist
    /// any integer `d` with `2 ≤ d ≤ √n` such that `n % d == 0`.
    ///
    /// - Returns: `true` if the number is prime; otherwise, `false`.
    ///
    /// - Complexity:
    ///   Runs in **O(√n)** time, since divisibility is only checked up to the
    ///   square root of the value.
    ///
    /// - Important:
    ///   Values less than `2` are **not prime** by definition.
    ///
    /// # Examples
    ///
    /// ```swift
    /// Math(int: 2).isPrime()   // true
    /// Math(int: 17).isPrime()  // true
    /// Math(int: 18).isPrime()  // false
    /// Math(int: -7).isPrime()  // false
    /// Math(int: 0).isPrime()   // false
    /// ```
    public func isPrime() -> Bool {
        guard let n = self.asInt else { return false }
        if n < 2 { return false }
        if n == 2 { return true }
        if n % 2 == 0 { return false }
        
        let limit = Int(Double(n).squareRoot())
        if limit < 3 { return true } // no need to check further
        
        for i in stride(from: 3, through: limit, by: 2) {
            if n % i == 0 { return false }
        }
        return true
    }
    
    public func getParity() -> Parity {
        return self % 2 == 0 ? .even : .odd
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
            return String(v) // Uses Swift’s default formatting
        case .bigInt(let v):
            return v.description
        case .bigDecimal(let v, let scale):
            // Convert BigInt + scale → string with decimal point
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

#if canImport(SwiftUI)
import SwiftUI

// MARK: - Text Interpolation for Math
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension LocalizedStringKey.StringInterpolation {
    
    /// Interpolates `Math` safely in SwiftUI `Text`.
    /// Works on all OS versions.
    public mutating func appendInterpolation(_ value: Math) {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            // Use LocalizedStringResource for new OSes
            appendInterpolation(value.localizedStringResource)
        } else {
            // Fallback for older OSes
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
    
    static func ** (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv.power(Int(rv)), scale: scale)
    }
    static func ^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 3) }
    static func ^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 4) }
    static func ^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 5) }
    static func ^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 6) }
    static func ^^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 7) }
    static func ^^^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 8) }
    static func ^^^^^^^^ (lhs: Math, rhs: Math) -> Math { hyper(lhs, rhs, level: 9) }
}

// MARK: - Factorial & Factorial Derivatives

import BigInt

// -------------------------------
// Standard Factorial (!)
// -------------------------------

postfix operator ~!
public extension Math {
    /// Factorial of a non-negative integer `n`.
    ///
    /// - Parameter x: The number to compute the factorial of.
    /// - Returns: `n! = 1 × 2 × ... × n`
    /// - Note: Returns `1` if the value is not a non-negative integer.
    static postfix func ~! (x: Math) -> Math {
        guard let n = x.asInt, n >= 0 else { return 1 }
        var result = BigInt(1)
        for i in 1...n {
            result *= BigInt(i)
        }
        return Math(bigDecimal: result, scale: 0)
    }
}

// -------------------------------
// Subfactorial (!n, derangements)
// -------------------------------

prefix operator ~!
public extension Math {
    /// Subfactorial (derangements) of a non-negative integer `n`.
    ///
    /// - Parameter x: The number to compute the subfactorial of.
    /// - Returns: `!n`, the number of permutations of `n` elements with no fixed points.
    /// - Definition: `!0 = 1`, `!1 = 0`, and
    ///   `!n = (n-1)(!(n-1) + !(n-2))` for `n > 1`.
    /// - Note: Returns `1` if the value is not a non-negative integer.
    static prefix func ~! (x: Math) -> Math {
        guard let n = x.asInt, n >= 0 else { return 1 }
        if n == 0 { return 1 }
        if n == 1 { return 0 }
        
        var dp: [BigInt] = [1, 0] // !0=1, !1=0
        for i in 2...n {
            let value = BigInt(i - 1) * (dp[i - 1] + dp[i - 2])
            dp.append(value)
        }
        
        return Math(bigDecimal: dp[n], scale: 0)
    }
}

// -------------------------------
// Step Factorials (Double, Triple, Quadruple, etc.)
// -------------------------------

postfix operator ~!!
postfix operator ~!!!
postfix operator ~!!!!
public extension Math {
    /// General step factorial.
    ///
    /// - Parameters:
    ///   - n: The number to compute the factorial of.
    ///   - step: Step size for the factorial (2 for double factorial, 3 for triple, etc.).
    /// - Returns: Product of numbers from `n` down to `1` in steps of `step`.
    static func Gfactorial(_ n: Math, step: Math = 1) -> Math {
        guard n > 1 else { return 1 }
        var result: Math = 1
        var current = n
        while current > 1 {
            result *= current
            current -= step
        }
        return result
    }
    
    /// Double factorial: `n!! = n × (n-2) × (n-4) ...`
    static postfix func ~!! (x: Math) -> Math {
        return Gfactorial(x, step: 2)
    }
    
    /// Triple factorial: `n!!! = n × (n-3) × (n-6) ...`
    static postfix func ~!!! (x: Math) -> Math {
        return Gfactorial(x, step: 3)
    }
    
    /// Quadruple factorial: `n!!!! = n × (n-4) × (n-8) ...`
    static postfix func ~!!!! (x: Math) -> Math {
        return Gfactorial(x, step: 4)
    }
}

//// -------------------------------
//// Primorial Factorial n#
//// -------------------------------
//
//postfix operator
//
//public extension Math {
//
//}

// -------------------------------
// Super Factorial n$
// -------------------------------

// MARK: - Roots
infix operator |/: ExponentiationPrecedence
infix operator √: ExponentiationPrecedence

public extension Math {
    /// Computes n-th root using Newton’s method. Only positive values.
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
    
    static func √ (lhs: Math, rhs: Math) -> Math { lhs |/ rhs }
}

// MARK: - Numeric Conversions
public extension Int    { init(_ value: Math) { self = value.asInt ?? 0 } }
public extension Double { init(_ value: Math) { self = value.asDouble ?? 0 } }
public extension Float  { init(_ value: Math) { self = value.asDouble.map(Float.init) ?? 0 } }

