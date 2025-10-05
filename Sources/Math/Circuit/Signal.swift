//
//  Signal.swift
//  Math
//
//  Digital signal representation for circuit simulation
//

/// Represents a digital signal state in a circuit.
///
/// A signal can be in one of several states, including logical high/low,
/// high-impedance (floating), and undefined states.
public enum Signal: Equatable, CustomStringConvertible, Sendable {
    /// Logical low (0, ground, false)
    case low

    /// Logical high (1, VDD, true)
    case high

    /// High impedance (floating, disconnected)
    case highZ

    /// Undefined or unknown state
    case undefined

    // MARK: - Convenience Initializers

    /// Creates a signal from a Boolean value.
    ///
    /// - Parameter value: The Boolean value (true = high, false = low).
    public init(_ value: Bool) {
        self = value ? .high : .low
    }

    /// Creates a signal from an optional Boolean.
    ///
    /// - Parameter value: The optional Boolean (nil = undefined).
    public init?(_ value: Bool?) {
        guard let value = value else {
            self = .undefined
            return
        }
        self = value ? .high : .low
    }

    // MARK: - Conversions

    /// Converts the signal to a Boolean value.
    ///
    /// - Returns: true for high, false for low, nil for highZ or undefined.
    public var boolValue: Bool? {
        switch self {
        case .low: return false
        case .high: return true
        case .highZ, .undefined: return nil
        }
    }

    /// Converts the signal to a binary integer.
    ///
    /// - Returns: 1 for high, 0 for low, nil for highZ or undefined.
    public var intValue: Int? {
        boolValue.map { $0 ? 1 : 0 }
    }

    // MARK: - Logic Operations

    /// Logical NOT operation.
    public var inverted: Signal {
        switch self {
        case .low: return .high
        case .high: return .low
        case .highZ: return .highZ
        case .undefined: return .undefined
        }
    }

    /// Logical AND operation.
    public func and(_ other: Signal) -> Signal {
        switch (self, other) {
        case (.high, .high): return .high
        case (.low, _), (_, .low): return .low
        case (.undefined, _), (_, .undefined): return .undefined
        case (.highZ, _), (_, .highZ): return .undefined
        }
    }

    /// Logical OR operation.
    public func or(_ other: Signal) -> Signal {
        switch (self, other) {
        case (.high, _), (_, .high): return .high
        case (.low, .low): return .low
        case (.undefined, _), (_, .undefined): return .undefined
        case (.highZ, _), (_, .highZ): return .undefined
        }
    }

    /// Logical XOR operation.
    public func xor(_ other: Signal) -> Signal {
        guard let a = self.boolValue, let b = other.boolValue else {
            return .undefined
        }
        return Signal(a != b)
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        switch self {
        case .low: return "0"
        case .high: return "1"
        case .highZ: return "Z"
        case .undefined: return "X"
        }
    }
}

/// A wire carries a signal between circuit components.
///
/// Wires can be connected to multiple sources and destinations,
/// and handle signal propagation with proper high-impedance handling.
public class Wire: Equatable, CustomStringConvertible {
    /// The current signal on this wire.
    public private(set) var signal: Signal

    /// The name of this wire (for debugging).
    public let name: String

    /// Connected output drivers (sources that can set the signal).
    private var drivers: [() -> Signal] = []

    /// Connected input observers (for propagation notifications).
    private var observers: [(Signal) -> Void] = []

    // MARK: - Initialization

    /// Creates a new wire with an initial signal.
    ///
    /// - Parameters:
    ///   - name: A name for debugging.
    ///   - initialSignal: The initial signal state (default: .highZ).
    public init(name: String = "wire", initialSignal: Signal = .highZ) {
        self.name = name
        self.signal = initialSignal
    }

    // MARK: - Signal Management

    /// Sets the signal on this wire.
    ///
    /// - Parameter signal: The new signal value.
    public func setSignal(_ signal: Signal) {
        guard self.signal != signal else { return }
        self.signal = signal
        notifyObservers()
    }

    /// Adds a driver to this wire.
    ///
    /// - Parameter driver: A closure that returns the current output signal.
    public func addDriver(_ driver: @escaping () -> Signal) {
        drivers.append(driver)
    }

    /// Adds an observer that will be notified when the signal changes.
    ///
    /// - Parameter observer: A closure called with the new signal.
    public func addObserver(_ observer: @escaping (Signal) -> Void) {
        observers.append(observer)
    }

    /// Updates the wire's signal by evaluating all drivers.
    ///
    /// Handles multiple drivers using wired-OR logic with high-impedance.
    public func update() {
        guard !drivers.isEmpty else { return }

        var newSignal: Signal = .highZ
        var hasHigh = false
        var hasLow = false
        var hasUndefined = false

        for driver in drivers {
            let driverSignal = driver()

            switch driverSignal {
            case .high:
                hasHigh = true
            case .low:
                hasLow = true
            case .undefined:
                hasUndefined = true
            case .highZ:
                continue // High-Z doesn't affect the result
            }
        }

        // Determine final signal
        if hasUndefined || (hasHigh && hasLow) {
            newSignal = .undefined // Conflict or undefined
        } else if hasHigh {
            newSignal = .high
        } else if hasLow {
            newSignal = .low
        } else {
            newSignal = .highZ
        }

        setSignal(newSignal)
    }

    private func notifyObservers() {
        for observer in observers {
            observer(signal)
        }
    }

    // MARK: - Equatable

    public static func == (lhs: Wire, rhs: Wire) -> Bool {
        lhs === rhs
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        "\(name): \(signal)"
    }
}

/// A bus is a collection of wires representing a multi-bit value.
public struct Bus: CustomStringConvertible {
    /// The wires in this bus, from LSB (index 0) to MSB.
    public let wires: [Wire]

    /// The width of the bus in bits.
    public var width: Int { wires.count }

    /// The name of this bus.
    public let name: String

    // MARK: - Initialization

    /// Creates a bus with the specified number of wires.
    ///
    /// - Parameters:
    ///   - width: The number of bits.
    ///   - name: The base name for the wires.
    public init(width: Int, name: String = "bus") {
        self.name = name
        self.wires = (0..<width).map { Wire(name: "\(name)[\($0)]") }
    }

    /// Creates a bus from existing wires.
    ///
    /// - Parameters:
    ///   - wires: The wires to use (LSB first).
    ///   - name: The name of the bus.
    public init(wires: [Wire], name: String = "bus") {
        self.wires = wires
        self.name = name
    }

    // MARK: - Value Access

    /// Gets the current value of the bus as an integer.
    ///
    /// - Returns: The integer value, or nil if any wire is undefined or high-Z.
    public var intValue: Int? {
        var value = 0
        for (index, wire) in wires.enumerated() {
            guard let bit = wire.signal.intValue else { return nil }
            value |= (bit << index)
        }
        return value
    }

    /// Gets the current value of the bus as a Boolean array (LSB first).
    public var boolValue: [Bool?] {
        wires.map { $0.signal.boolValue }
    }

    /// Sets the bus to a specific integer value.
    ///
    /// - Parameter value: The integer value to set.
    public func setValue(_ value: Int) {
        for (index, wire) in wires.enumerated() {
            let bit = (value >> index) & 1
            wire.setSignal(bit == 1 ? .high : .low)
        }
    }

    /// Sets the bus to a Boolean array value (LSB first).
    ///
    /// - Parameter value: The Boolean array.
    public func setValue(_ value: [Bool]) {
        for (index, wire) in wires.enumerated() {
            guard index < value.count else { break }
            wire.setSignal(Signal(value[index]))
        }
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        let bits = wires.reversed().map { $0.signal.description }.joined()
        return "\(name): \(bits) (\(intValue.map(String.init) ?? "X"))"
    }
}
