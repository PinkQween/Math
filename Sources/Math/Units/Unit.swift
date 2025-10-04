//
//  Unit.swift
//  Math
//
//  A comprehensive, extensible unit system supporting dimensional analysis,
//  unit conversions, and arbitrary-precision calculations.
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Minimal Basis

/// The minimal irreducible dimensional basis for physical quantities.
///
/// All physical dimensions can be expressed as combinations of these three fundamental dimensions.
/// This forms the basis for dimensional analysis and ensures type safety in calculations.
///
/// ## Example
/// ```swift
/// // Force has dimensions [mass * length / time^2]
/// let force: [MinimalDimension: Int] = [.mass: 1, .length: 1, .time: -2]
/// ```
///
/// - SeeAlso: `StandardDimension`, `DimensionID`
public enum MinimalDimension: String, CaseIterable, Sendable {
    /// Spatial extent (meter)
    case length

    /// Quantity of matter (kilogram)
    case mass

    /// Duration (second)
    case time
}

// MARK: - Standard Dimensions

/// Standard physical dimensions covering common measurement categories.
///
/// This enum provides an exhaustive list of commonly-used dimensions, including:
/// - SI base dimensions (length, mass, time, temperature, etc.)
/// - Derived dimensions (area, volume, speed, force, energy, etc.)
/// - Specialized dimensions (angle, dataStorage, fuelEconomy, etc.)
///
/// Each dimension can be decomposed into combinations of `MinimalDimension` values
/// for dimensional analysis and validation.
///
/// - SeeAlso: `MinimalDimension`, `CustomDimension`, `Unit`
public enum StandardDimension: String, CaseIterable, Sendable {
    case length, mass, time
    case electricCurrent, temperature, amountOfSubstance, luminousIntensity
    case area, volume, speed, acceleration, force, energy, power, electricCharge
    case voltage, electricalResistance, frequency, pressure, angle, informationStorage
    case dataStorage, fuelEconomy
}

// MARK: - Custom dimension metadata
public struct CustomDimension: Hashable, Sendable {
    public let id: String
    public let displayName: String?
    public let notes: String?

    public init(id: String, displayName: String? = nil, notes: String? = nil) {
        self.id = id
        self.displayName = displayName
        self.notes = notes
    }
}

// MARK: - Dimension wrapper
public struct DimensionID: Hashable, Sendable {
    public let standard: StandardDimension?
    public let custom: CustomDimension?

    public init(standard: StandardDimension) { self.standard = standard; self.custom = nil }
    public init(custom: CustomDimension) { self.standard = nil; self.custom = custom }

    public static func standard(_ s: StandardDimension) -> DimensionID { .init(standard: s) }
    public static func custom(_ c: CustomDimension) -> DimensionID { .init(custom: c) }
}

// MARK: - Numeric domain / unit type
public enum NumericKind: Hashable, Sendable {
    case real, imaginary, complex, abstract(String)
}

// MARK: - Dimension registry (actor)
public actor DimensionRegistry {
    public static let shared = DimensionRegistry()
    
    private var customMinimalExponents: [String: [MinimalDimension: Int]] = [:]

    public func registerCustomMinimalExponents(for custom: CustomDimension, exponents: [MinimalDimension: Int]?) {
        if let exps = exponents { customMinimalExponents[custom.id] = exps }
        else { customMinimalExponents.removeValue(forKey: custom.id) }
    }

    public func minimalExponents(for custom: CustomDimension) -> [MinimalDimension: Int]? {
        customMinimalExponents[custom.id]
    }

    public func minimalExponents(for id: DimensionID) -> [MinimalDimension: Int]? {
        if let s = id.standard { return StandardDimension.canonicalMinimalExponents(for: s) }
        else if let c = id.custom { return minimalExponents(for: c) }
        return nil
    }

    /// Synchronous snapshot for use in Unit.init / factories
    nonisolated public func minimalExponentsSync(for id: DimensionID) -> [MinimalDimension: Int]? {
        if let s = id.standard { return StandardDimension.canonicalMinimalExponents(for: s) }
        // Cannot access actor-isolated state from nonisolated context
        // Custom dimensions must register before Unit creation
        return nil
    }
}

// MARK: - Canonical minimal mapping
public extension StandardDimension {
    static func canonicalMinimalExponents(for s: StandardDimension) -> [MinimalDimension: Int]? {
        switch s {
        case .length: return [.length: 1]
        case .mass:   return [.mass: 1]
        case .time:   return [.time: 1]
        case .area:         return [.length: 2]
        case .volume:       return [.length: 3]
        case .speed:        return [.length: 1, .time: -1]
        case .acceleration: return [.length: 1, .time: -2]
        case .force:        return [.mass: 1, .length: 1, .time: -2]
        case .energy:       return [.mass: 1, .length: 2, .time: -2]
        case .power:        return [.mass: 1, .length: 2, .time: -3]
        case .frequency:    return [.time: -1]
        case .pressure:     return [.mass: 1, .length: -1, .time: -2]
        case .angle:        return [:]
        case .informationStorage: return [:]
        case .dataStorage:  return [:]
        case .fuelEconomy:  return [.length: -2]
        case .electricCharge, .electricCurrent, .voltage, .electricalResistance, .temperature, .amountOfSubstance, .luminousIntensity:
            return nil
        }
    }
}

// MARK: - Kind compatibility
public enum KindCompatibility {
    case strict, allowPromotion, allowAll
}

// MARK: - Unit definition
public struct Unit: Hashable, Sendable {
    public let name: String
    public let symbol: String
    public let dimension: DimensionID
    public let kind: NumericKind
    public let toBaseScale: Math
    public let toBaseOffset: Math
    public let minimalExponents: [MinimalDimension: Int]?
    public let notes: String?

    public init(
        name: String,
        symbol: String,
        dimension: DimensionID,
        kind: NumericKind = .real,
        toBaseScale: Math,
        toBaseOffset: Math = Math(0),
        minimalExponents: [MinimalDimension: Int]? = nil,
        notes: String? = nil
    ) {
        self.name = name
        self.symbol = symbol
        self.dimension = dimension
        self.kind = kind
        self.toBaseScale = toBaseScale
        self.toBaseOffset = toBaseOffset
        self.minimalExponents = minimalExponents ?? DimensionRegistry.shared.minimalExponentsSync(for: dimension)
        self.notes = notes
    }

    // MARK: - Conversion within dimension
    public func convertWithinDimension(_ value: MathUnit, to target: Unit, policy: KindCompatibility = .strict) -> MathUnit? {
        guard self.dimension == target.dimension else { return nil }
        switch policy {
        case .strict: guard self.kind == target.kind else { return nil }
        case .allowPromotion:
            if !(self.kind == .real && target.kind == .complex) && self.kind != target.kind { return nil }
        case .allowAll: break
        }
        let si = (value.value * self.toBaseScale) + self.toBaseOffset
        let targetValue = (si - target.toBaseOffset) / target.toBaseScale
        return MathUnit(targetValue, target)
    }

    // MARK: - Planck helpers
    public static let planckLength = Math("1.616255e-35")
    public static let planckMass   = Math("2.176434e-8")
    public static let planckTime   = Math("5.391247e-44")

    fileprivate static func planckScalar(for d: MinimalDimension) -> Math {
        switch d {
        case .length: return planckLength
        case .mass:   return planckMass
        case .time:   return planckTime
        }
    }

    private static func powMath(_ base: Math, _ exp: Int) -> Math {
        guard exp != 0 else { return Math(1) }
        var result = Math(1)
        for _ in 0..<abs(exp) { result *= base }
        return exp < 0 ? (Math(1) / result) : result
    }

    public func planckScalarForUnit() -> Math? {
        guard let exps = self.minimalExponents, !exps.isEmpty else { return nil }
        var combined = Math(1)
        for (dim, e) in exps {
            combined *= Unit.powMath(Unit.planckScalar(for: dim), e)
        }
        return combined
    }

    public func toPlanckCount(_ value: MathUnit) -> Math? {
        guard let scalar = planckScalarForUnit() else { return nil }
        let si = (value.value * toBaseScale) + toBaseOffset
        return si / scalar
    }

    public func convertViaPlanck(_ value: MathUnit, to target: Unit) -> MathUnit? {
        guard let pSource = planckScalarForUnit(), let pTarget = target.planckScalarForUnit() else { return nil }
        let siSource = (value.value * self.toBaseScale) + self.toBaseOffset
        let planckCount = siSource / pSource
        let siTarget = planckCount * pTarget
        let outVal = (siTarget - target.toBaseOffset) / target.toBaseScale
        return MathUnit(outVal, target)
    }

    // MARK: - Compound unit factory
    public static func compound(
        name: String,
        symbol: String,
        components: [(unit: Unit, exponent: Int)],
        kind: NumericKind = .real,
        notes: String? = nil
    ) -> Unit {
        var combinedScale = Math(1)
        var exponents: [MinimalDimension: Int] = [:]

        for (u, e) in components {
            precondition(u.toBaseOffset == Math(0), "Compound units cannot include offset units")
            combinedScale *= Unit.powMath(u.toBaseScale, e)
            if let compExps = u.minimalExponents {
                for (d, p) in compExps { exponents[d] = (exponents[d] ?? 0) + p * e }
            } else { return Unit(name: name, symbol: symbol, dimension: .custom(.init(id: name)), kind: kind, toBaseScale: combinedScale, toBaseOffset: Math(0), minimalExponents: nil, notes: notes) }
        }

        return Unit(name: name, symbol: symbol, dimension: .custom(.init(id: name, displayName: name)), kind: kind, toBaseScale: combinedScale, toBaseOffset: Math(0), minimalExponents: exponents, notes: notes)
    }
}

// MARK: - Example usage
/*
let myDim = CustomDimension(id: "ferehnite", displayName: "Ferehnite")
await DimensionRegistry.shared.registerCustomMinimalExponents(for: myDim, exponents: [.length: 2, .time: -1])
let fUnit = Unit(name: "fer", symbol: "Fh", dimension: .custom(myDim), toBaseScale: Math("12.34"))
*/
