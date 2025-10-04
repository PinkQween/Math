//
//  ExoticUnits.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Exotic & Unusual Units

/// Provides unusual, historical, and whimsical units of measurement.
public struct ExoticUnits {

    // MARK: - Astronomical Units

    /// Astronomical unit - Earth-Sun distance
    public static let astronomicalUnit = Unit(
        name: "astronomical unit",
        symbol: "AU",
        dimension: .length,
        toBaseUnit: 1.495978707e11,
        notes: "≈ 149.6 million km (Earth-Sun distance)"
    )

    /// Light-year - distance light travels in one year
    public static let lightYear = Unit(
        name: "light-year",
        symbol: "ly",
        dimension: .length,
        toBaseUnit: 9.4607304725808e15,
        notes: "≈ 9.46 trillion km = 63,241 AU"
    )

    /// Parsec - parallax of one arcsecond
    public static let parsec = Unit(
        name: "parsec",
        symbol: "pc",
        dimension: .length,
        toBaseUnit: 3.0856775814913673e16,
        notes: "≈ 3.26 ly = 206,265 AU (stellar distances)"
    )

    /// Kiloparsec - 1000 parsecs
    public static let kiloparsec = Unit(
        name: "kiloparsec",
        symbol: "kpc",
        dimension: .length,
        toBaseUnit: 3.0856775814913673e19,
        notes: "= 1000 pc ≈ 3262 ly (galaxy scale)"
    )

    /// Megaparsec - 1,000,000 parsecs
    public static let megaparsec = Unit(
        name: "megaparsec",
        symbol: "Mpc",
        dimension: .length,
        toBaseUnit: 3.0856775814913673e22,
        notes: "= 1 million pc ≈ 3.26 million ly (cosmological distances)"
    )

    /// Hubble length - cosmic horizon distance
    public static let hubbleLength = Unit(
        name: "Hubble length",
        symbol: "c/H₀",
        dimension: .length,
        toBaseUnit: 1.4e26,
        notes: "≈ 14 billion ly (observable universe radius)"
    )

    // MARK: - Historical & Imperial Oddities

    /// Furlong - 1/8 mile
    public static let furlong = Unit(
        name: "furlong",
        symbol: "fur",
        dimension: .length,
        toBaseUnit: 201.168,
        notes: "= 660 ft = 1/8 mi (horse racing)"
    )

    /// Chain - surveyor's chain
    public static let chain = Unit(
        name: "chain",
        symbol: "ch",
        dimension: .length,
        toBaseUnit: 20.1168,
        notes: "= 66 ft = 1/10 furlong (surveying)"
    )

    /// Rod (perch) - surveying unit
    public static let rod = Unit(
        name: "rod",
        symbol: "rd",
        dimension: .length,
        toBaseUnit: 5.0292,
        notes: "= 16.5 ft = 1/4 chain"
    )

    /// Fathom - nautical depth measurement
    public static let fathom = Unit(
        name: "fathom",
        symbol: "ftm",
        dimension: .length,
        toBaseUnit: 1.8288,
        notes: "= 6 ft (maritime depth)"
    )

    /// Cable length - naval distance
    public static let cableLength = Unit(
        name: "cable length",
        symbol: "cable",
        dimension: .length,
        toBaseUnit: 185.2,
        notes: "= 1/10 nmi ≈ 608 ft (naval)"
    )

    /// League - historical distance
    public static let league = Unit(
        name: "league",
        symbol: "lea",
        dimension: .length,
        toBaseUnit: 4828.032,
        notes: "≈ 3 mi (varies by country)"
    )

    /// Hand - horse height measurement
    public static let hand = Unit(
        name: "hand",
        symbol: "h",
        dimension: .length,
        toBaseUnit: 0.1016,
        notes: "= 4 in (horse height)"
    )

    /// Cubit - ancient length (elbow to fingertip)
    public static let cubit = Unit(
        name: "cubit",
        symbol: "cbt",
        dimension: .length,
        toBaseUnit: 0.4572,
        notes: "≈ 18 in (ancient Egyptian/Biblical)"
    )

    // MARK: - Whimsical Modern Units

    /// Smoot - MIT prank unit
    public static let smoot = Unit(
        name: "smoot",
        symbol: "sm",
        dimension: .length,
        toBaseUnit: 1.7018,
        notes: "≈ 5'7\" (Harvard Bridge = 364.4 smoots)"
    )

    /// Beard-second - unit of length
    public static let beardSecond = Unit(
        name: "beard-second",
        symbol: "beard-s",
        dimension: .length,
        toBaseUnit: 5e-9,
        notes: "= 5 nm (beard growth in 1 second)"
    )

    /// Mickey - smallest mouse movement
    public static let mickey = Unit(
        name: "mickey",
        symbol: "mickey",
        dimension: .length,
        toBaseUnit: 0.000127,
        notes: "= 1/200 in (computer mouse movement)"
    )

    /// Sheppey - unit of distance
    public static let sheppey = Unit(
        name: "sheppey",
        symbol: "shpy",
        dimension: .length,
        toBaseUnit: 1400.0,
        notes: "≈ 7/8 mi (closest sheep appears spherical)"
    )

    /// Potrzebie - MAD magazine unit
    public static let potrzebie = Unit(
        name: "potrzebie",
        symbol: "pz",
        dimension: .length,
        toBaseUnit: 2.263348517438173e-3,
        notes: "≈ 2.26 mm (thickness of MAD #26)"
    )

    // MARK: - Atomic & Microscopic

    /// Ångström - atomic scale length
    public static let angstrom = Unit(
        name: "ångström",
        symbol: "Å",
        dimension: .length,
        toBaseUnit: 1e-10,
        notes: "= 0.1 nm (atomic radii ~1-3 Å)"
    )

    /// Fermi - nuclear scale length
    public static let fermi = Unit(
        name: "fermi",
        symbol: "fm",
        dimension: .length,
        toBaseUnit: 1e-15,
        notes: "= 1 femtometer (nuclear radii ~1-10 fm)"
    )

    /// Atomic mass unit - molecular mass
    public static let atomicMassUnit = Unit(
        name: "atomic mass unit",
        symbol: "u",
        dimension: .mass,
        toBaseUnit: 1.66053906660e-27,
        notes: "≈ 1.661 × 10⁻²⁷ kg ≈ mass of proton"
    )

    /// Dalton - same as atomic mass unit
    public static let dalton = Unit(
        name: "dalton",
        symbol: "Da",
        dimension: .mass,
        toBaseUnit: 1.66053906660e-27,
        notes: "= 1 u (protein masses in kDa)"
    )

    // MARK: - Computing & Information

    /// Bit - fundamental information unit
    public static let bit = Unit(
        name: "bit",
        symbol: "b",
        dimension: .informationStorage,
        toBaseUnit: 1.0,
        notes: "binary digit (0 or 1)"
    )

    /// Byte - 8 bits
    public static let byte = Unit(
        name: "byte",
        symbol: "B",
        dimension: .informationStorage,
        toBaseUnit: 8.0,
        notes: "= 8 bits"
    )

    /// Kilobyte - 1000 bytes (decimal) or 1024 bytes (binary)
    public static let kilobyte = Unit(
        name: "kilobyte",
        symbol: "KB",
        dimension: .informationStorage,
        toBaseUnit: 8000.0,
        notes: "= 1000 B (decimal) or 1024 B (binary KiB)"
    )

    /// Megabyte - 1,000,000 bytes
    public static let megabyte = Unit(
        name: "megabyte",
        symbol: "MB",
        dimension: .informationStorage,
        toBaseUnit: 8_000_000.0,
        notes: "= 1 million B (floppy disk ~1.44 MB)"
    )

    /// Gigabyte - 1,000,000,000 bytes
    public static let gigabyte = Unit(
        name: "gigabyte",
        symbol: "GB",
        dimension: .informationStorage,
        toBaseUnit: 8_000_000_000.0,
        notes: "= 1 billion B (RAM/storage)"
    )

    /// Terabyte - 1,000,000,000,000 bytes
    public static let terabyte = Unit(
        name: "terabyte",
        symbol: "TB",
        dimension: .informationStorage,
        toBaseUnit: 8_000_000_000_000.0,
        notes: "= 1 trillion B (hard drives)"
    )

    /// Petabyte - 1,000,000,000,000,000 bytes
    public static let petabyte = Unit(
        name: "petabyte",
        symbol: "PB",
        dimension: .informationStorage,
        toBaseUnit: 8_000_000_000_000_000.0,
        notes: "= 1 quadrillion B (data centers)"
    )

    /// Nibble - 4 bits (half byte)
    public static let nibble = Unit(
        name: "nibble",
        symbol: "nibble",
        dimension: .informationStorage,
        toBaseUnit: 4.0,
        notes: "= 4 bits = 1 hex digit"
    )

    // MARK: - Time Oddities

    /// Fortnight - two weeks
    public static let fortnight = Unit(
        name: "fortnight",
        symbol: "fn",
        dimension: .time,
        toBaseUnit: 1_209_600.0,
        notes: "= 14 days = 2 weeks"
    )

    /// Jiffy - informal time unit
    public static let jiffy = Unit(
        name: "jiffy",
        symbol: "jiffy",
        dimension: .time,
        toBaseUnit: 1.0 / 60.0,
        notes: "≈ 16.7 ms (1/60 s, AC cycle)"
    )

    /// Shake - nuclear physics time
    public static let shake = Unit(
        name: "shake",
        symbol: "shake",
        dimension: .time,
        toBaseUnit: 1e-8,
        notes: "= 10 ns (shake of a lamb's tail)"
    )

    /// Svedberg - sedimentation coefficient
    public static let svedberg = Unit(
        name: "svedberg",
        symbol: "S",
        dimension: .time,
        toBaseUnit: 1e-13,
        notes: "= 10⁻¹³ s (molecular sedimentation)"
    )

    /// Microfortnight - humorous small time
    public static let microfortnight = Unit(
        name: "microfortnight",
        symbol: "μfn",
        dimension: .time,
        toBaseUnit: 1.2096,
        notes: "≈ 1.21 s (geek humor unit)"
    )

    /// Sol - Martian day
    public static let sol = Unit(
        name: "sol",
        symbol: "sol",
        dimension: .time,
        toBaseUnit: 88_775.244,
        notes: "≈ 24h 39m 35s (Martian solar day)"
    )

    // MARK: - Angle Units

    /// Radian - SI unit of angle
    public static let radian = Unit(
        name: "radian",
        symbol: "rad",
        dimension: .angle,
        toBaseUnit: 1.0,
        notes: "SI unit (2π rad = 360°)"
    )

    /// Degree - common angle unit
    public static let degree = Unit(
        name: "degree",
        symbol: "°",
        dimension: .angle,
        toBaseUnit: 0.017453292519943295,
        notes: "= π/180 rad (360° = circle)"
    )

    /// Arcminute - 1/60 degree
    public static let arcminute = Unit(
        name: "arcminute",
        symbol: "′",
        dimension: .angle,
        toBaseUnit: 2.908882086657216e-4,
        notes: "= 1/60° (celestial coordinates)"
    )

    /// Arcsecond - 1/60 arcminute
    public static let arcsecond = Unit(
        name: "arcsecond",
        symbol: "″",
        dimension: .angle,
        toBaseUnit: 4.84813681109536e-6,
        notes: "= 1/60′ = 1/3600° (parallax)"
    )

    /// Gradian - 1/400 of circle
    public static let gradian = Unit(
        name: "gradian",
        symbol: "grad",
        dimension: .angle,
        toBaseUnit: 0.015707963267948967,
        notes: "= π/200 rad (400 grad = circle)"
    )

    /// Turn - full rotation
    public static let turn = Unit(
        name: "turn",
        symbol: "tr",
        dimension: .angle,
        toBaseUnit: 6.283185307179586,
        notes: "= 2π rad = 360° (full circle)"
    )

    // MARK: - Unusual Mass Units

    /// Slug - imperial mass unit
    public static let slug = Unit(
        name: "slug",
        symbol: "slug",
        dimension: .mass,
        toBaseUnit: 14.593902937,
        notes: "≈ 14.59 kg (1 lbf·s²/ft)"
    )

    /// Carat - gemstone mass
    public static let carat = Unit(
        name: "carat",
        symbol: "ct",
        dimension: .mass,
        toBaseUnit: 0.0002,
        notes: "= 200 mg (diamond/gem weight)"
    )

    /// Grain - ammunition and precious metals
    public static let grain = Unit(
        name: "grain",
        symbol: "gr",
        dimension: .mass,
        toBaseUnit: 6.479891e-5,
        notes: "≈ 64.8 mg (bullets/gold)"
    )

    /// Troy ounce - precious metals
    public static let troyOunce = Unit(
        name: "troy ounce",
        symbol: "oz t",
        dimension: .mass,
        toBaseUnit: 0.0311034768,
        notes: "≈ 31.1 g (gold/silver)"
    )

    /// Hundredweight (US) - shipping weight
    public static let hundredweightUS = Unit(
        name: "hundredweight (US)",
        symbol: "cwt",
        dimension: .mass,
        toBaseUnit: 45.359237,
        notes: "= 100 lb (US shipping)"
    )

    // MARK: - Obscure Volume Units

    /// Hogshead - large barrel
    public static let hogshead = Unit(
        name: "hogshead",
        symbol: "hhd",
        dimension: .volume,
        toBaseUnit: 0.238480942392,
        notes: "≈ 63 US gal (wine/beer barrel)"
    )

    /// Firkin - small barrel
    public static let firkin = Unit(
        name: "firkin",
        symbol: "fir",
        dimension: .volume,
        toBaseUnit: 0.04091481,
        notes: "≈ 9 UK gal (beer cask)"
    )

    /// Peck - dry volume
    public static let peck = Unit(
        name: "peck",
        symbol: "pk",
        dimension: .volume,
        toBaseUnit: 0.00880976754172,
        notes: "= 1/4 bushel ≈ 8.81 L"
    )

    /// Bushel - agricultural volume
    public static let bushel = Unit(
        name: "bushel",
        symbol: "bu",
        dimension: .volume,
        toBaseUnit: 0.03523907016688,
        notes: "≈ 35.24 L (grain/produce)"
    )

    /// Jigger - bartending measure
    public static let jigger = Unit(
        name: "jigger",
        symbol: "jig",
        dimension: .volume,
        toBaseUnit: 4.436029434375e-5,
        notes: "= 1.5 US fl oz ≈ 44.4 mL"
    )

    /// Dram - small volume
    public static let dram = Unit(
        name: "dram",
        symbol: "dr",
        dimension: .volume,
        toBaseUnit: 3.6966911953125e-6,
        notes: "= 1/8 fl oz ≈ 3.7 mL"
    )

    // MARK: - Obscure Speed Units

    /// Furlong per fortnight - geek humor
    public static let furlongPerFortnight = Unit(
        name: "furlong per fortnight",
        symbol: "fur/fn",
        dimension: .speed,
        toBaseUnit: 1.663095e-4,
        notes: "≈ 0.166 mm/s (geek unit)"
    )

    /// Parsec per megayear - galactic motion
    public static let parsecPerMegayear = Unit(
        name: "parsec per megayear",
        symbol: "pc/Myr",
        dimension: .speed,
        toBaseUnit: 0.9777922216,
        notes: "≈ 0.978 m/s (galactic velocities)"
    )
}
