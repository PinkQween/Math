//
//  MathUnit.swift
//  Math
//
//  Created by Hanna Skairipa on 10/4/25.
//

import Foundation

/// A type that represents a mathematical value paired with a specific unit,
/// similar to `Measurement` in Foundation.
///
/// Example:
/// ```swift
/// let length = MathUnit(5, .meters)
/// print(length) // "5 meters"
/// ```
public struct MathUnit {
    /// The numeric value of this unit.
    let value: Math
    
    /// The associated unit type.
    let unit: Unit
    
    // MARK: - Initialization
    
    /// Creates a new `MathUnit` with the given value and unit.
    ///
    /// - Parameters:
    ///   - value: The numeric value of the measurement.
    ///   - unit: The unit associated with the value.
    init(value: Math, unit: Unit) {
        self.value = value
        self.unit = unit
    }
    
    /// A convenience initializer that omits parameter labels
    /// for a cleaner, Apple-like API.
    ///
    /// - Parameters:
    ///   - value: The numeric value of the measurement.
    ///   - unit: The unit associated with the value.
    init(_ value: Math, _ unit: Unit) {
        self.value = value
        self.unit = unit
    }
}

// MARK: - Conformances

extension MathUnit: Equatable {}

extension MathUnit: CustomStringConvertible {
    public var description: String {
        "\(value) \(unit.symbol)"
    }
}
