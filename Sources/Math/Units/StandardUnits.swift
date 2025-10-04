//
//  StandardUnits.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Standard Units

/// Provides standard SI and imperial units of measurement.
public struct StandardUnits {

    // MARK: - Length Units

    /// Meter - SI base unit of length
    public static let meter = Unit(
        name: "meter",
        symbol: "m",
        dimension: .standard(.length),
        toBaseScale: Math(1.0),
        notes: "SI base unit"
    )

    /// Kilometer - 1000 meters
    public static let kilometer = Unit(
        name: "kilometer",
        symbol: "km",
        dimension: .standard(.length),
        toBaseScale: Math(1000.0),
        notes: "= 1000 m"
    )

    /// Centimeter - 1/100 meter
    public static let centimeter = Unit(
        name: "centimeter",
        symbol: "cm",
        dimension: .standard(.length),
        toBaseScale: Math(0.01),
        notes: "= 0.01 m"
    )

    /// Millimeter - 1/1000 meter
    public static let millimeter = Unit(
        name: "millimeter",
        symbol: "mm",
        dimension: .standard(.length),
        toBaseScale: Math(0.001),
        notes: "= 0.001 m"
    )

    /// Micrometer - 1/1,000,000 meter
    public static let micrometer = Unit(
        name: "micrometer",
        symbol: "μm",
        dimension: .standard(.length),
        toBaseScale: Math(1e-6),
        notes: "= 0.000001 m"
    )

    /// Nanometer - 1/1,000,000,000 meter
    public static let nanometer = Unit(
        name: "nanometer",
        symbol: "nm",
        dimension: .standard(.length),
        toBaseScale: Math(1e-9),
        notes: "= 0.000000001 m"
    )

    /// Foot - Imperial unit
    public static let foot = Unit(
        name: "foot",
        symbol: "ft",
        dimension: .standard(.length),
        toBaseScale: Math(0.3048),
        notes: "= 0.3048 m"
    )

    /// Inch - 1/12 foot
    public static let inch = Unit(
        name: "inch",
        symbol: "in",
        dimension: .standard(.length),
        toBaseScale: Math(0.0254),
        notes: "= 2.54 cm"
    )

    /// Yard - 3 feet
    public static let yard = Unit(
        name: "yard",
        symbol: "yd",
        dimension: .standard(.length),
        toBaseScale: Math(0.9144),
        notes: "= 3 ft = 0.9144 m"
    )

    /// Mile - 5280 feet
    public static let mile = Unit(
        name: "mile",
        symbol: "mi",
        dimension: .standard(.length),
        toBaseScale: Math(1609.344),
        notes: "= 5280 ft = 1609.344 m"
    )

    /// Nautical mile - used in maritime and aviation
    public static let nauticalMile = Unit(
        name: "nautical mile",
        symbol: "nmi",
        dimension: .standard(.length),
        toBaseScale: Math(1852.0),
        notes: "= 1852 m (used in maritime/aviation)"
    )

    // MARK: - Mass Units

    /// Kilogram - SI base unit of mass
    public static let kilogram = Unit(
        name: "kilogram",
        symbol: "kg",
        dimension: .standard(.mass),
        toBaseScale: Math(1.0),
        notes: "SI base unit"
    )

    /// Gram - 1/1000 kilogram
    public static let gram = Unit(
        name: "gram",
        symbol: "g",
        dimension: .standard(.mass),
        toBaseScale: Math(0.001),
        notes: "= 0.001 kg"
    )

    /// Milligram - 1/1,000,000 kilogram
    public static let milligram = Unit(
        name: "milligram",
        symbol: "mg",
        dimension: .standard(.mass),
        toBaseScale: Math(1e-6),
        notes: "= 0.000001 kg"
    )

    /// Metric ton - 1000 kilograms
    public static let metricTon = Unit(
        name: "metric ton",
        symbol: "t",
        dimension: .standard(.mass),
        toBaseScale: Math(1000.0),
        notes: "= 1000 kg"
    )

    /// Pound - Imperial unit of mass
    public static let pound = Unit(
        name: "pound",
        symbol: "lb",
        dimension: .standard(.mass),
        toBaseScale: Math(0.45359237),
        notes: "= 0.45359237 kg"
    )

    /// Ounce - 1/16 pound
    public static let ounce = Unit(
        name: "ounce",
        symbol: "oz",
        dimension: .standard(.mass),
        toBaseScale: Math(0.028349523125),
        notes: "= 1/16 lb ≈ 28.35 g"
    )

    /// Stone - 14 pounds (British unit)
    public static let stone = Unit(
        name: "stone",
        symbol: "st",
        dimension: .standard(.mass),
        toBaseScale: Math(6.35029318),
        notes: "= 14 lb ≈ 6.35 kg (British)"
    )

    // MARK: - Time Units

    /// Second - SI base unit of time
    public static let second = Unit(
        name: "second",
        symbol: "s",
        dimension: .standard(.time),
        toBaseScale: Math(1.0),
        notes: "SI base unit"
    )

    /// Minute - 60 seconds
    public static let minute = Unit(
        name: "minute",
        symbol: "min",
        dimension: .standard(.time),
        toBaseScale: Math(60.0),
        notes: "= 60 s"
    )

    /// Hour - 60 minutes
    public static let hour = Unit(
        name: "hour",
        symbol: "h",
        dimension: .standard(.time),
        toBaseScale: Math(3600.0),
        notes: "= 60 min = 3600 s"
    )

    /// Day - 24 hours
    public static let day = Unit(
        name: "day",
        symbol: "d",
        dimension: .standard(.time),
        toBaseScale: Math(86400.0),
        notes: "= 24 h = 86,400 s"
    )

    /// Week - 7 days
    public static let week = Unit(
        name: "week",
        symbol: "wk",
        dimension: .standard(.time),
        toBaseScale: Math(604800.0),
        notes: "= 7 d = 604,800 s"
    )

    /// Year - 365.25 days (accounting for leap years)
    public static let year = Unit(
        name: "year",
        symbol: "yr",
        dimension: .standard(.time),
        toBaseScale: Math(31557600.0),
        notes: "= 365.25 d ≈ 31.56 million s"
    )

    /// Millisecond - 1/1000 second
    public static let millisecond = Unit(
        name: "millisecond",
        symbol: "ms",
        dimension: .standard(.time),
        toBaseScale: Math(0.001),
        notes: "= 0.001 s"
    )

    /// Microsecond - 1/1,000,000 second
    public static let microsecond = Unit(
        name: "microsecond",
        symbol: "μs",
        dimension: .standard(.time),
        toBaseScale: Math(1e-6),
        notes: "= 0.000001 s"
    )

    /// Nanosecond - 1/1,000,000,000 second
    public static let nanosecond = Unit(
        name: "nanosecond",
        symbol: "ns",
        dimension: .standard(.time),
        toBaseScale: Math(1e-9),
        notes: "= 0.000000001 s"
    )

    // MARK: - Area Units

    /// Square meter - SI derived unit of area
    public static let squareMeter = Unit(
        name: "square meter",
        symbol: "m²",
        dimension: .standard(.area),
        toBaseScale: Math(1.0),
        notes: "SI derived unit"
    )

    /// Square kilometer
    public static let squareKilometer = Unit(
        name: "square kilometer",
        symbol: "km²",
        dimension: .standard(.area),
        toBaseScale: Math(1_000_000.0),
        notes: "= 1,000,000 m²"
    )

    /// Square foot
    public static let squareFoot = Unit(
        name: "square foot",
        symbol: "ft²",
        dimension: .standard(.area),
        toBaseScale: Math(0.09290304),
        notes: "≈ 0.0929 m²"
    )

    /// Square mile
    public static let squareMile = Unit(
        name: "square mile",
        symbol: "mi²",
        dimension: .standard(.area),
        toBaseScale: Math(2_589_988.110336),
        notes: "≈ 2.59 million m²"
    )

    /// Acre - common land measurement
    public static let acre = Unit(
        name: "acre",
        symbol: "ac",
        dimension: .standard(.area),
        toBaseScale: Math(4046.8564224),
        notes: "= 43,560 ft² ≈ 4047 m²"
    )

    /// Hectare - metric land measurement
    public static let hectare = Unit(
        name: "hectare",
        symbol: "ha",
        dimension: .standard(.area),
        toBaseScale: Math(10_000.0),
        notes: "= 10,000 m² = 2.471 acres"
    )

    // MARK: - Volume Units

    /// Cubic meter - SI derived unit of volume
    public static let cubicMeter = Unit(
        name: "cubic meter",
        symbol: "m³",
        dimension: .standard(.volume),
        toBaseScale: Math(1.0),
        notes: "SI derived unit"
    )

    /// Liter - common volume unit
    public static let liter = Unit(
        name: "liter",
        symbol: "L",
        dimension: .standard(.volume),
        toBaseScale: Math(0.001),
        notes: "= 0.001 m³ = 1 dm³"
    )

    /// Milliliter - 1/1000 liter
    public static let milliliter = Unit(
        name: "milliliter",
        symbol: "mL",
        dimension: .standard(.volume),
        toBaseScale: Math(1e-6),
        notes: "= 0.001 L = 1 cm³"
    )

    /// Gallon (US) - US liquid volume
    public static let gallonUS = Unit(
        name: "gallon (US)",
        symbol: "gal",
        dimension: .standard(.volume),
        toBaseScale: Math(0.003785411784),
        notes: "= 3.785 L (US liquid gallon)"
    )

    /// Gallon (Imperial) - UK liquid volume
    public static let gallonImperial = Unit(
        name: "gallon (UK)",
        symbol: "gal",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00454609),
        notes: "= 4.546 L (Imperial gallon)"
    )

    /// Quart (US)
    public static let quartUS = Unit(
        name: "quart (US)",
        symbol: "qt",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000946352946),
        notes: "= 1/4 US gal ≈ 0.946 L"
    )

    /// Pint (US)
    public static let pintUS = Unit(
        name: "pint (US)",
        symbol: "pt",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000473176473),
        notes: "= 1/8 US gal ≈ 473 mL"
    )

    /// Cup (US) - cooking measurement
    public static let cupUS = Unit(
        name: "cup (US)",
        symbol: "cup",
        dimension: .standard(.volume),
        toBaseScale: Math(0.0002365882365),
        notes: "= 8 fl oz ≈ 237 mL"
    )

    /// Fluid ounce (US)
    public static let fluidOunceUS = Unit(
        name: "fluid ounce (US)",
        symbol: "fl oz",
        dimension: .standard(.volume),
        toBaseScale: Math(2.95735295625e-5),
        notes: "≈ 29.57 mL"
    )

    /// Tablespoon (US) - cooking measurement
    public static let tablespoon = Unit(
        name: "tablespoon",
        symbol: "tbsp",
        dimension: .standard(.volume),
        toBaseScale: Math(1.478676478125e-5),
        notes: "= 1/2 fl oz ≈ 14.79 mL"
    )

    /// Teaspoon (US) - cooking measurement
    public static let teaspoon = Unit(
        name: "teaspoon",
        symbol: "tsp",
        dimension: .standard(.volume),
        toBaseScale: Math(4.92892159375e-6),
        notes: "= 1/3 tbsp ≈ 4.93 mL"
    )
}
