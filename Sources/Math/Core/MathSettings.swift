//
//  MathSettings.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

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
