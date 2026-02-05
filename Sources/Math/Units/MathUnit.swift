//
//  MathUnit.swift
//  Math
//
//  Created by Hanna Skairipa on 2/4/26.
//

public struct MathUnit: Hashable, Sendable {
    public let value: Math
    public let unit: Unit

    public init(_ value: Math, _ unit: Unit) {
        self.value = value
        self.unit = unit
    }

    public func converted(to target: Unit, policy: KindCompatibility = .strict) -> MathUnit? {
        unit.convertWithinDimension(self, to: target, policy: policy)
    }

    public var baseValue: Math {
        (value * unit.toBaseScale) + unit.toBaseOffset
    }
}

// MARK: - MathUnit arithmetic
public extension MathUnit {
    private static func combinedExponents(_ lhs: Unit, _ rhs: Unit, exponent: Int = 1) -> [MinimalDimension: Int]? {
        guard let l = lhs.minimalExponents, let r = rhs.minimalExponents else { return nil }
        var out = l
        for (k, v) in r { out[k] = (out[k] ?? 0) + (v * exponent) }
        return out
    }

    private static func simplifiedUnit(for exponents: [MinimalDimension: Int]) -> Unit? {
        StandardUnits.preferredUnit(for: exponents)
    }

    static func + (lhs: MathUnit, rhs: MathUnit) -> MathUnit? {
        guard let rhsConverted = rhs.converted(to: lhs.unit, policy: .allowPromotion) else { return nil }
        return MathUnit(lhs.value + rhsConverted.value, lhs.unit)
    }

    static func - (lhs: MathUnit, rhs: MathUnit) -> MathUnit? {
        guard let rhsConverted = rhs.converted(to: lhs.unit, policy: .allowPromotion) else { return nil }
        return MathUnit(lhs.value - rhsConverted.value, lhs.unit)
    }

    static func * (lhs: MathUnit, rhs: MathUnit) -> MathUnit? {
        guard lhs.unit.toBaseOffset == Math(0), rhs.unit.toBaseOffset == Math(0) else { return nil }
        let combinedValueBase = lhs.baseValue * rhs.baseValue
        if let exps = combinedExponents(lhs.unit, rhs.unit),
           let preferred = simplifiedUnit(for: exps) {
            return MathUnit(combinedValueBase, preferred)
        }

        let combinedUnit = Unit.compound(
            name: "\(lhs.unit.name)·\(rhs.unit.name)",
            symbol: "\(lhs.unit.symbol)·\(rhs.unit.symbol)",
            components: [(lhs.unit, 1), (rhs.unit, 1)]
        )
        return MathUnit(lhs.value * rhs.value, combinedUnit)
    }

    static func / (lhs: MathUnit, rhs: MathUnit) -> MathUnit? {
        guard lhs.unit.toBaseOffset == Math(0), rhs.unit.toBaseOffset == Math(0) else { return nil }
        let combinedValueBase = lhs.baseValue / rhs.baseValue
        if let exps = combinedExponents(lhs.unit, rhs.unit, exponent: -1),
           let preferred = simplifiedUnit(for: exps) {
            return MathUnit(combinedValueBase, preferred)
        }

        let combinedUnit = Unit.compound(
            name: "\(lhs.unit.name)/\(rhs.unit.name)",
            symbol: "\(lhs.unit.symbol)/\(rhs.unit.symbol)",
            components: [(lhs.unit, 1), (rhs.unit, -1)]
        )
        return MathUnit(lhs.value / rhs.value, combinedUnit)
    }

    static func * (lhs: MathUnit, rhs: Math) -> MathUnit {
        MathUnit(lhs.value * rhs, lhs.unit)
    }

    static func * (lhs: Math, rhs: MathUnit) -> MathUnit {
        MathUnit(lhs * rhs.value, rhs.unit)
    }

    static func / (lhs: MathUnit, rhs: Math) -> MathUnit {
        MathUnit(lhs.value / rhs, lhs.unit)
    }

    func pow(_ exponent: Int) -> MathUnit? {
        guard unit.toBaseOffset == Math(0) else { return nil }
        let baseValue = self.baseValue
        let poweredValue = Unit.powMath(baseValue, exponent)
        if let exps = unit.minimalExponents {
            var out: [MinimalDimension: Int] = [:]
            for (k, v) in exps { out[k] = v * exponent }
            if let preferred = MathUnit.simplifiedUnit(for: out) {
                return MathUnit(poweredValue, preferred)
            }
        }

        let combinedUnit = Unit.compound(
            name: "\(unit.name)^\(exponent)",
            symbol: "\(unit.symbol)^\(exponent)",
            components: [(unit, exponent)]
        )
        return MathUnit(Unit.powMath(value, exponent), combinedUnit)
    }
}
