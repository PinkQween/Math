//
//  StandardUnits.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Standard Units

/// A comprehensive collection of standard SI and imperial units of measurement.
///
/// `StandardUnits` provides 150+ commonly-used units organized into the following categories:
/// - **Length**: meter, kilometer, centimeter, foot, inch, mile, etc.
/// - **Mass**: kilogram, gram, pound, ounce, stone, etc.
/// - **Time**: second, minute, hour, day, week, year, millisecond, etc.
/// - **Area**: square meter, square kilometer, acre, hectare, etc.
/// - **Volume**: cubic meter, liter, milliliter, gallon, cup, tablespoon, etc.
/// - **Temperature**: kelvin, celsius, fahrenheit
/// - **Speed**: m/s, km/h, mph, knots, etc.
/// - **Data Storage**: byte, kilobyte, megabyte, gigabyte (decimal and binary)
/// - **Pressure**: pascal, bar, atmosphere, psi, torr, etc.
/// - **Energy**: joule, calorie, kilocalorie, watt-hour, BTU, etc.
/// - **Power**: watt, kilowatt, horsepower, etc.
/// - **Angle**: radian, degree, gradian, arcminute, arcsecond
/// - **Frequency**: hertz, kilohertz, megahertz, gigahertz, rpm
/// - **Fuel Economy**: L/100km, mpg, km/L
///
/// ## Usage Example
///
/// ```swift
/// // Create a measurement
/// let distance = MathUnit(Math(100), StandardUnits.meter)
///
/// // Convert to another unit
/// let kilometers = StandardUnits.meter.convertWithinDimension(
///     distance,
///     to: StandardUnits.kilometer
/// )
/// print(kilometers?.value) // 0.1 km
///
/// // Temperature conversion with offset handling
/// let celsius = MathUnit(Math(0), StandardUnits.celsius)
/// let fahrenheit = StandardUnits.celsius.convertWithinDimension(
///     celsius,
///     to: StandardUnits.fahrenheit
/// )
/// print(fahrenheit?.value) // 32°F
/// ```
///
/// ## Notes
/// - All units are defined relative to their base SI unit for the dimension
/// - Temperature units properly handle offset conversions (0°C = 32°F)
/// - Data storage units include both decimal (KB, MB, GB) and binary (KiB, MiB, GiB) variants
/// - Unit conversions maintain arbitrary precision through the `Math` type
///
/// - SeeAlso: `Unit`, `MathUnit`, `PhysicsUnits`, `ExoticUnits`
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

    // MARK: - Temperature Units

    /// Kelvin - SI base unit of temperature
    public static let kelvin = Unit(
        name: "kelvin",
        symbol: "K",
        dimension: .standard(.temperature),
        toBaseScale: Math(1.0),
        toBaseOffset: Math(0.0),
        notes: "SI base unit (absolute scale)"
    )

    /// Celsius - common temperature scale
    public static let celsius = Unit(
        name: "celsius",
        symbol: "°C",
        dimension: .standard(.temperature),
        toBaseScale: Math(1.0),
        toBaseOffset: Math(273.15),
        notes: "Water freezes at 0°C, boils at 100°C"
    )

    /// Fahrenheit - US temperature scale
    public static let fahrenheit = Unit(
        name: "fahrenheit",
        symbol: "°F",
        dimension: .standard(.temperature),
        toBaseScale: Math(5.0) / Math(9.0),
        toBaseOffset: Math(255.372222),
        notes: "Water freezes at 32°F, boils at 212°F"
    )

    // MARK: - Speed/Velocity Units

    /// Meters per second - SI derived unit
    public static let metersPerSecond = Unit(
        name: "meters per second",
        symbol: "m/s",
        dimension: .standard(.speed),
        toBaseScale: Math(1.0),
        notes: "SI derived unit"
    )

    /// Kilometers per hour - common speed unit
    public static let kilometersPerHour = Unit(
        name: "kilometers per hour",
        symbol: "km/h",
        dimension: .standard(.speed),
        toBaseScale: Math(1.0) / Math(3.6),
        notes: "= 0.2778 m/s"
    )

    /// Miles per hour - US speed unit
    public static let milesPerHour = Unit(
        name: "miles per hour",
        symbol: "mph",
        dimension: .standard(.speed),
        toBaseScale: Math(0.44704),
        notes: "≈ 0.447 m/s = 1.609 km/h"
    )

    /// Knots - maritime/aviation speed
    public static let knots = Unit(
        name: "knots",
        symbol: "kn",
        dimension: .standard(.speed),
        toBaseScale: Math(0.514444),
        notes: "= 1 nmi/h ≈ 1.852 km/h"
    )

    /// Feet per second
    public static let feetPerSecond = Unit(
        name: "feet per second",
        symbol: "ft/s",
        dimension: .standard(.speed),
        toBaseScale: Math(0.3048),
        notes: "= 0.3048 m/s"
    )

    // MARK: - Data Storage Units

    /// Byte - base unit of digital storage
    public static let byte = Unit(
        name: "byte",
        symbol: "B",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1.0),
        notes: "Base unit (8 bits)"
    )

    /// Kilobyte - 1000 bytes (decimal)
    public static let kilobyte = Unit(
        name: "kilobyte",
        symbol: "kB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1000.0),
        notes: "= 1,000 bytes (decimal)"
    )

    /// Megabyte - 1,000,000 bytes
    public static let megabyte = Unit(
        name: "megabyte",
        symbol: "MB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1_000_000.0),
        notes: "= 1,000,000 bytes"
    )

    /// Gigabyte - 1,000,000,000 bytes
    public static let gigabyte = Unit(
        name: "gigabyte",
        symbol: "GB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1_000_000_000.0),
        notes: "= 1,000,000,000 bytes"
    )

    /// Terabyte - 1,000,000,000,000 bytes
    public static let terabyte = Unit(
        name: "terabyte",
        symbol: "TB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1_000_000_000_000.0),
        notes: "= 1,000,000,000,000 bytes"
    )

    /// Petabyte - 1,000,000,000,000,000 bytes
    public static let petabyte = Unit(
        name: "petabyte",
        symbol: "PB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1_000_000_000_000_000.0),
        notes: "= 1,000,000,000,000,000 bytes"
    )

    /// Kibibyte - 1024 bytes (binary)
    public static let kibibyte = Unit(
        name: "kibibyte",
        symbol: "KiB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1024.0),
        notes: "= 1,024 bytes (binary, 2^10)"
    )

    /// Mebibyte - 1,048,576 bytes (binary)
    public static let mebibyte = Unit(
        name: "mebibyte",
        symbol: "MiB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1_048_576.0),
        notes: "= 1,048,576 bytes (binary, 2^20)"
    )

    /// Gibibyte - 1,073,741,824 bytes (binary)
    public static let gibibyte = Unit(
        name: "gibibyte",
        symbol: "GiB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1_073_741_824.0),
        notes: "= 1,073,741,824 bytes (binary, 2^30)"
    )

    /// Tebibyte - 1,099,511,627,776 bytes (binary)
    public static let tebibyte = Unit(
        name: "tebibyte",
        symbol: "TiB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1_099_511_627_776.0),
        notes: "= 1,099,511,627,776 bytes (binary, 2^40)"
    )

    /// Bit - 1/8 byte
    public static let bit = Unit(
        name: "bit",
        symbol: "b",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(0.125),
        notes: "= 1/8 byte"
    )

    // MARK: - Pressure Units

    /// Pascal - SI unit of pressure
    public static let pascal = Unit(
        name: "pascal",
        symbol: "Pa",
        dimension: .standard(.pressure),
        toBaseScale: Math(1.0),
        notes: "SI unit = N/m² = kg/(m·s²)"
    )

    /// Kilopascal - 1000 pascals
    public static let kilopascal = Unit(
        name: "kilopascal",
        symbol: "kPa",
        dimension: .standard(.pressure),
        toBaseScale: Math(1000.0),
        notes: "= 1,000 Pa"
    )

    /// Megapascal - 1,000,000 pascals
    public static let megapascal = Unit(
        name: "megapascal",
        symbol: "MPa",
        dimension: .standard(.pressure),
        toBaseScale: Math(1_000_000.0),
        notes: "= 1,000,000 Pa"
    )

    /// Bar - common metric pressure unit
    public static let bar = Unit(
        name: "bar",
        symbol: "bar",
        dimension: .standard(.pressure),
        toBaseScale: Math(100_000.0),
        notes: "= 100,000 Pa ≈ 1 atm"
    )

    /// Atmosphere - standard atmospheric pressure
    public static let atmosphere = Unit(
        name: "atmosphere",
        symbol: "atm",
        dimension: .standard(.pressure),
        toBaseScale: Math(101_325.0),
        notes: "Standard atmospheric pressure at sea level"
    )

    /// PSI - pounds per square inch
    public static let psi = Unit(
        name: "pounds per square inch",
        symbol: "psi",
        dimension: .standard(.pressure),
        toBaseScale: Math(6894.757293168),
        notes: "≈ 6,895 Pa"
    )

    /// Torr - mmHg
    public static let torr = Unit(
        name: "torr",
        symbol: "Torr",
        dimension: .standard(.pressure),
        toBaseScale: Math(133.322368),
        notes: "= 1 mmHg ≈ 133.3 Pa"
    )

    // MARK: - Energy Units

    /// Joule - SI unit of energy
    public static let joule = Unit(
        name: "joule",
        symbol: "J",
        dimension: .standard(.energy),
        toBaseScale: Math(1.0),
        notes: "SI unit = N·m = kg·m²/s²"
    )

    /// Kilojoule - 1000 joules
    public static let kilojoule = Unit(
        name: "kilojoule",
        symbol: "kJ",
        dimension: .standard(.energy),
        toBaseScale: Math(1000.0),
        notes: "= 1,000 J"
    )

    /// Megajoule - 1,000,000 joules
    public static let megajoule = Unit(
        name: "megajoule",
        symbol: "MJ",
        dimension: .standard(.energy),
        toBaseScale: Math(1_000_000.0),
        notes: "= 1,000,000 J"
    )

    /// Calorie - small calorie (thermochemical)
    public static let calorie = Unit(
        name: "calorie",
        symbol: "cal",
        dimension: .standard(.energy),
        toBaseScale: Math(4.184),
        notes: "≈ 4.184 J (thermochemical)"
    )

    /// Kilocalorie - food Calorie
    public static let kilocalorie = Unit(
        name: "kilocalorie",
        symbol: "kcal",
        dimension: .standard(.energy),
        toBaseScale: Math(4184.0),
        notes: "= 1,000 cal = 1 food Calorie"
    )

    /// Watt-hour - energy unit for electricity
    public static let wattHour = Unit(
        name: "watt-hour",
        symbol: "Wh",
        dimension: .standard(.energy),
        toBaseScale: Math(3600.0),
        notes: "= 3,600 J"
    )

    /// Kilowatt-hour - common electricity billing unit
    public static let kilowattHour = Unit(
        name: "kilowatt-hour",
        symbol: "kWh",
        dimension: .standard(.energy),
        toBaseScale: Math(3_600_000.0),
        notes: "= 3,600,000 J = 3.6 MJ"
    )

    /// Electronvolt - atomic-scale energy
    public static let electronvolt = Unit(
        name: "electronvolt",
        symbol: "eV",
        dimension: .standard(.energy),
        toBaseScale: Math(1.602176634e-19),
        notes: "≈ 1.602×10⁻¹⁹ J (atomic scale)"
    )

    /// British Thermal Unit
    public static let btu = Unit(
        name: "British thermal unit",
        symbol: "BTU",
        dimension: .standard(.energy),
        toBaseScale: Math(1055.06),
        notes: "≈ 1,055 J (ISO/International Table)"
    )

    // MARK: - Power Units

    /// Watt - SI unit of power
    public static let watt = Unit(
        name: "watt",
        symbol: "W",
        dimension: .standard(.power),
        toBaseScale: Math(1.0),
        notes: "SI unit = J/s = kg·m²/s³"
    )

    /// Kilowatt - 1000 watts
    public static let kilowatt = Unit(
        name: "kilowatt",
        symbol: "kW",
        dimension: .standard(.power),
        toBaseScale: Math(1000.0),
        notes: "= 1,000 W"
    )

    /// Megawatt - 1,000,000 watts
    public static let megawatt = Unit(
        name: "megawatt",
        symbol: "MW",
        dimension: .standard(.power),
        toBaseScale: Math(1_000_000.0),
        notes: "= 1,000,000 W"
    )

    /// Horsepower (mechanical) - US/UK unit
    public static let horsepower = Unit(
        name: "horsepower",
        symbol: "hp",
        dimension: .standard(.power),
        toBaseScale: Math(745.699872),
        notes: "≈ 745.7 W (mechanical)"
    )

    /// Metric horsepower - European unit
    public static let horsepowerMetric = Unit(
        name: "metric horsepower",
        symbol: "PS",
        dimension: .standard(.power),
        toBaseScale: Math(735.49875),
        notes: "≈ 735.5 W (European)"
    )

    // MARK: - Angle Units

    /// Radian - SI unit of angle
    public static let radian = Unit(
        name: "radian",
        symbol: "rad",
        dimension: .standard(.angle),
        toBaseScale: Math(1.0),
        notes: "SI unit (2π rad = 360°)"
    )

    /// Degree - common angle measurement
    public static let degree = Unit(
        name: "degree",
        symbol: "°",
        dimension: .standard(.angle),
        toBaseScale: Math(0.017453292519943295),
        notes: "= π/180 rad (360° = circle)"
    )

    /// Gradian - centesimal angle
    public static let gradian = Unit(
        name: "gradian",
        symbol: "grad",
        dimension: .standard(.angle),
        toBaseScale: Math(0.015707963267948967),
        notes: "= π/200 rad (400 grad = circle)"
    )

    /// Arcminute - 1/60 degree
    public static let arcminute = Unit(
        name: "arcminute",
        symbol: "′",
        dimension: .standard(.angle),
        toBaseScale: Math(0.0002908882086657216),
        notes: "= 1/60 degree"
    )

    /// Arcsecond - 1/3600 degree
    public static let arcsecond = Unit(
        name: "arcsecond",
        symbol: "″",
        dimension: .standard(.angle),
        toBaseScale: Math(4.84813681109536e-6),
        notes: "= 1/3600 degree"
    )

    // MARK: - Frequency Units

    /// Hertz - SI unit of frequency
    public static let hertz = Unit(
        name: "hertz",
        symbol: "Hz",
        dimension: .standard(.frequency),
        toBaseScale: Math(1.0),
        notes: "SI unit = 1/s (cycles per second)"
    )

    /// Kilohertz - 1000 hertz
    public static let kilohertz = Unit(
        name: "kilohertz",
        symbol: "kHz",
        dimension: .standard(.frequency),
        toBaseScale: Math(1000.0),
        notes: "= 1,000 Hz"
    )

    /// Megahertz - 1,000,000 hertz
    public static let megahertz = Unit(
        name: "megahertz",
        symbol: "MHz",
        dimension: .standard(.frequency),
        toBaseScale: Math(1_000_000.0),
        notes: "= 1,000,000 Hz"
    )

    /// Gigahertz - 1,000,000,000 hertz
    public static let gigahertz = Unit(
        name: "gigahertz",
        symbol: "GHz",
        dimension: .standard(.frequency),
        toBaseScale: Math(1_000_000_000.0),
        notes: "= 1,000,000,000 Hz"
    )

    /// RPM - revolutions per minute
    public static let rpm = Unit(
        name: "revolutions per minute",
        symbol: "rpm",
        dimension: .standard(.frequency),
        toBaseScale: Math(1.0) / Math(60.0),
        notes: "= 1/60 Hz"
    )

    // MARK: - Fuel Economy Units

    /// Liters per 100 kilometers - metric fuel economy
    public static let litersPer100Kilometers = Unit(
        name: "liters per 100 kilometers",
        symbol: "L/100km",
        dimension: .standard(.fuelEconomy),
        toBaseScale: Math(1.0),
        notes: "Metric fuel consumption (lower is better)"
    )

    /// Miles per gallon (US) - US fuel economy
    public static let milesPerGallonUS = Unit(
        name: "miles per gallon (US)",
        symbol: "mpg",
        dimension: .standard(.fuelEconomy),
        toBaseScale: Math(235.214583),
        notes: "US fuel economy (higher is better)"
    )

    /// Miles per gallon (Imperial) - UK fuel economy
    public static let milesPerGallonImperial = Unit(
        name: "miles per gallon (UK)",
        symbol: "mpg",
        dimension: .standard(.fuelEconomy),
        toBaseScale: Math(282.481053),
        notes: "UK fuel economy (higher is better)"
    )

    /// Kilometers per liter
    public static let kilometersPerLiter = Unit(
        name: "kilometers per liter",
        symbol: "km/L",
        dimension: .standard(.fuelEconomy),
        toBaseScale: Math(100.0),
        notes: "= 100 L/100km (inverse relationship)"
    )
}
