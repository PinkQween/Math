//
//  UnitPrefix.swift
//  Math
//
//  Created by Hanna Skairipa on 2/4/26.
//

public enum UnitPrefixBase: Int, Sendable {
    case ten = 10
    case two = 2
}

public struct UnitPrefix: Hashable, Sendable {
    public let name: String
    public let symbol: String
    public let base: UnitPrefixBase
    public let exponent: Int
    public let scale: Math

    public init(name: String, symbol: String, base: UnitPrefixBase, exponent: Int) {
        self.name = name
        self.symbol = symbol
        self.base = base
        self.exponent = exponent
        self.scale = Unit.powMath(Math(integerLiteral: base.rawValue), exponent)
    }
}

// MARK: - SI prefixes
public extension UnitPrefix {
    static let quetta = UnitPrefix(name: "quetta", symbol: "Q", base: .ten, exponent: 30)
    static let ronna  = UnitPrefix(name: "ronna",  symbol: "R", base: .ten, exponent: 27)
    static let yotta  = UnitPrefix(name: "yotta",  symbol: "Y", base: .ten, exponent: 24)
    static let zetta  = UnitPrefix(name: "zetta",  symbol: "Z", base: .ten, exponent: 21)
    static let exa    = UnitPrefix(name: "exa",    symbol: "E", base: .ten, exponent: 18)
    static let peta   = UnitPrefix(name: "peta",   symbol: "P", base: .ten, exponent: 15)
    static let tera   = UnitPrefix(name: "tera",   symbol: "T", base: .ten, exponent: 12)
    static let giga   = UnitPrefix(name: "giga",   symbol: "G", base: .ten, exponent: 9)
    static let mega   = UnitPrefix(name: "mega",   symbol: "M", base: .ten, exponent: 6)
    static let kilo   = UnitPrefix(name: "kilo",   symbol: "k", base: .ten, exponent: 3)
    static let hecto  = UnitPrefix(name: "hecto",  symbol: "h", base: .ten, exponent: 2)
    static let deka   = UnitPrefix(name: "deka",   symbol: "da", base: .ten, exponent: 1)
    static let deci   = UnitPrefix(name: "deci",   symbol: "d", base: .ten, exponent: -1)
    static let centi  = UnitPrefix(name: "centi",  symbol: "c", base: .ten, exponent: -2)
    static let milli  = UnitPrefix(name: "milli",  symbol: "m", base: .ten, exponent: -3)
    static let micro  = UnitPrefix(name: "micro",  symbol: "µ", base: .ten, exponent: -6)
    static let microAscii  = UnitPrefix(name: "micro",  symbol: "u", base: .ten, exponent: -6)
    static let nano   = UnitPrefix(name: "nano",   symbol: "n", base: .ten, exponent: -9)
    static let pico   = UnitPrefix(name: "pico",   symbol: "p", base: .ten, exponent: -12)
    static let femto  = UnitPrefix(name: "femto",  symbol: "f", base: .ten, exponent: -15)
    static let atto   = UnitPrefix(name: "atto",   symbol: "a", base: .ten, exponent: -18)
    static let zepto  = UnitPrefix(name: "zepto",  symbol: "z", base: .ten, exponent: -21)
    static let yocto  = UnitPrefix(name: "yocto",  symbol: "y", base: .ten, exponent: -24)
    static let ronto  = UnitPrefix(name: "ronto",  symbol: "r", base: .ten, exponent: -27)
    static let quecto = UnitPrefix(name: "quecto", symbol: "q", base: .ten, exponent: -30)
}

// MARK: - Binary prefixes
public extension UnitPrefix {
    static let kibi = UnitPrefix(name: "kibi", symbol: "Ki", base: .two, exponent: 10)
    static let mebi = UnitPrefix(name: "mebi", symbol: "Mi", base: .two, exponent: 20)
    static let gibi = UnitPrefix(name: "gibi", symbol: "Gi", base: .two, exponent: 30)
    static let tebi = UnitPrefix(name: "tebi", symbol: "Ti", base: .two, exponent: 40)
    static let pebi = UnitPrefix(name: "pebi", symbol: "Pi", base: .two, exponent: 50)
    static let exbi = UnitPrefix(name: "exbi", symbol: "Ei", base: .two, exponent: 60)
    static let zebi = UnitPrefix(name: "zebi", symbol: "Zi", base: .two, exponent: 70)
    static let yobi = UnitPrefix(name: "yobi", symbol: "Yi", base: .two, exponent: 80)
}

// MARK: - Prefix collections
public enum UnitPrefixes {
    public static let siAll: [UnitPrefix] = [
        .quetta, .ronna, .yotta, .zetta, .exa, .peta, .tera, .giga, .mega, .kilo,
        .hecto, .deka, .deci, .centi, .milli, .micro, .nano, .pico, .femto, .atto,
        .zepto, .yocto, .ronto, .quecto
    ]

    public static let siAllAscii: [UnitPrefix] = [
        .quetta, .ronna, .yotta, .zetta, .exa, .peta, .tera, .giga, .mega, .kilo,
        .hecto, .deka, .deci, .centi, .milli, .microAscii, .nano, .pico, .femto, .atto,
        .zepto, .yocto, .ronto, .quecto
    ]

    public static let siCommon: [UnitPrefix] = [
        .quetta, .ronna, .yotta, .zetta, .exa, .peta, .tera, .giga, .mega, .kilo,
        .milli, .micro, .nano, .pico, .femto, .atto
    ]

    public static let siCommonAscii: [UnitPrefix] = [
        .quetta, .ronna, .yotta, .zetta, .exa, .peta, .tera, .giga, .mega, .kilo,
        .milli, .microAscii, .nano, .pico, .femto, .atto
    ]

    public static let binary: [UnitPrefix] = [
        .kibi, .mebi, .gibi, .tebi, .pebi, .exbi, .zebi, .yobi
    ]
}
