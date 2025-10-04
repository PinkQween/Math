//
//  Unit.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Unit System

/// Represents a dimension for physical quantities (length, mass, time, etc.).
public enum Dimension: String, CaseIterable, Sendable {
    case length
    case mass
    case time
    case electricCurrent
    case temperature
    case amountOfSubstance
    case luminousIntensity
    case area
    case volume
    case speed
    case acceleration
    case force
    case energy
    case power
    case electricCharge
    case voltage
    case electricalResistance
    case frequency
    case pressure
    case angle
    case informationStorage
}

/// Represents a unit of measurement with conversion to base SI unit.
public struct Unit: Sendable, Hashable {
    /// The name of the unit (e.g., "meter", "foot").
    public let name: String

    /// The symbol for the unit (e.g., "m", "ft").
    public let symbol: String

    /// The dimension this unit measures.
    public let dimension: Dimension

    /// Conversion factor to the base SI unit for this dimension.
    /// Example: 1 foot = 0.3048 meters, so factor = 0.3048
    public let toBaseUnit: Double

    /// Optional description or equivalent value in comments.
    public let notes: String?

    public init(
        name: String,
        symbol: String,
        dimension: Dimension,
        toBaseUnit: Double,
        notes: String? = nil
    ) {
        self.name = name
        self.symbol = symbol
        self.dimension = dimension
        self.toBaseUnit = toBaseUnit
        self.notes = notes
    }

    /// Converts a value from this unit to another unit of the same dimension.
    ///
    /// - Parameters:
    ///   - value: The value in this unit.
    ///   - target: The target unit to convert to.
    /// - Returns: The value in the target unit.
    public func convert(_ value: Double, to target: Unit) -> Double? {
        guard dimension == target.dimension else { return nil }
        return (value * toBaseUnit) / target.toBaseUnit
    }
}

extension Unit: CustomStringConvertible {
    public var description: String {
        if let notes = notes {
            return "\(name) (\(symbol)) - \(notes)"
        }
        return "\(name) (\(symbol))"
    }
}
