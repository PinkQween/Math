//
//  StandardUnits.swift
//  Math
//
//  Created by Hanna Skairipa on 2/4/26.
//

public enum StandardUnits {
    private static func normalized(_ exps: [MinimalDimension: Int]) -> [MinimalDimension: Int] {
        var out: [MinimalDimension: Int] = [:]
        for (k, v) in exps where v != 0 { out[k] = v }
        return out
    }

    private static func exponentsEqual(_ a: [MinimalDimension: Int], _ b: [MinimalDimension: Int]) -> Bool {
        normalized(a) == normalized(b)
    }

    public static func preferredUnit(for exponents: [MinimalDimension: Int]) -> Unit? {
        let exps = normalized(exponents)
        if exps.isEmpty { return unitless }

        if let s = StandardDimension.canonicalMinimalExponents(for: .length), exponentsEqual(exps, s) { return meter }
        if let s = StandardDimension.canonicalMinimalExponents(for: .mass), exponentsEqual(exps, s) { return kilogram }
        if let s = StandardDimension.canonicalMinimalExponents(for: .time), exponentsEqual(exps, s) { return second }
        if let s = StandardDimension.canonicalMinimalExponents(for: .area), exponentsEqual(exps, s) { return squareMeter }
        if let s = StandardDimension.canonicalMinimalExponents(for: .volume), exponentsEqual(exps, s) { return cubicMeter }
        if let s = StandardDimension.canonicalMinimalExponents(for: .density), exponentsEqual(exps, s) { return kilogramPerCubicMeter }
        if let s = StandardDimension.canonicalMinimalExponents(for: .speed), exponentsEqual(exps, s) { return meterPerSecond }
        if let s = StandardDimension.canonicalMinimalExponents(for: .acceleration), exponentsEqual(exps, s) { return meterPerSecondSquared }
        if let s = StandardDimension.canonicalMinimalExponents(for: .force), exponentsEqual(exps, s) { return newton }
        if let s = StandardDimension.canonicalMinimalExponents(for: .energy), exponentsEqual(exps, s) { return joule }
        if let s = StandardDimension.canonicalMinimalExponents(for: .power), exponentsEqual(exps, s) { return watt }
        if let s = StandardDimension.canonicalMinimalExponents(for: .frequency), exponentsEqual(exps, s) { return hertz }
        if let s = StandardDimension.canonicalMinimalExponents(for: .pressure), exponentsEqual(exps, s) { return pascal }

        return nil
    }
    // MARK: - SI base units
    public static let meter = Unit(
        name: "meter",
        symbol: "m",
        dimension: .standard(.length),
        toBaseScale: Math(1),
        system: .si
    )

    public static let kilogram = Unit(
        name: "kilogram",
        symbol: "kg",
        dimension: .standard(.mass),
        toBaseScale: Math(1),
        system: .si
    )

    public static let gram = Unit(
        name: "gram",
        symbol: "g",
        dimension: .standard(.mass),
        toBaseScale: Math(0.001),
        system: .si
    )

    public static let second = Unit(
        name: "second",
        symbol: "s",
        dimension: .standard(.time),
        toBaseScale: Math(1),
        system: .si
    )

    public static let ampere = Unit(
        name: "ampere",
        symbol: "A",
        dimension: .standard(.electricCurrent),
        toBaseScale: Math(1),
        system: .si
    )

    public static let kelvin = Unit(
        name: "kelvin",
        symbol: "K",
        dimension: .standard(.temperature),
        toBaseScale: Math(1),
        system: .si
    )

    public static let mole = Unit(
        name: "mole",
        symbol: "mol",
        dimension: .standard(.amountOfSubstance),
        toBaseScale: Math(1),
        system: .si
    )

    public static let candela = Unit(
        name: "candela",
        symbol: "cd",
        dimension: .standard(.luminousIntensity),
        toBaseScale: Math(1),
        system: .si
    )

    // MARK: - Common app/game units (ordered)
    public static let millisecond = second.prefixed(.milli)
    public static let microsecond = second.prefixed(.micro)
    public static let microsecondAscii = second.prefixed(.microAscii, symbolOverride: "us")
    public static let nanosecond = second.prefixed(.nano)

    public static let minute = Unit(
        name: "minute",
        symbol: "min",
        dimension: .standard(.time),
        toBaseScale: Math(60),
        system: .si
    )

    public static let hour = Unit(
        name: "hour",
        symbol: "h",
        dimension: .standard(.time),
        toBaseScale: Math(3600),
        system: .si
    )

    public static let day = Unit(
        name: "day",
        symbol: "d",
        dimension: .standard(.time),
        toBaseScale: Math(86400),
        system: .si
    )

    public static let kilometer = meter.prefixed(.kilo)
    public static let centimeter = meter.prefixed(.centi)
    public static let millimeter = meter.prefixed(.milli)
    public static let micrometer = meter.prefixed(.micro)
    public static let micrometerAscii = meter.prefixed(.microAscii, symbolOverride: "um")
    public static let nanometer = meter.prefixed(.nano)

    public static let inch = Unit(
        name: "inch",
        symbol: "in",
        dimension: .standard(.length),
        toBaseScale: Math(0.0254),
        system: .usCustomary
    )

    public static let foot = Unit(
        name: "foot",
        symbol: "ft",
        dimension: .standard(.length),
        toBaseScale: Math(0.3048),
        system: .usCustomary
    )

    public static let yard = Unit(
        name: "yard",
        symbol: "yd",
        dimension: .standard(.length),
        toBaseScale: Math(0.9144),
        system: .usCustomary
    )

    public static let mile = Unit(
        name: "mile",
        symbol: "mi",
        dimension: .standard(.length),
        toBaseScale: Math(1609.344),
        system: .usCustomary
    )

    public static let nauticalMile = Unit(
        name: "nautical mile",
        symbol: "nmi",
        dimension: .standard(.length),
        toBaseScale: Math(1852),
        system: .imperial
    )

    public static let kilometerPerHour = Unit(
        name: "kilometer per hour",
        symbol: "km/h",
        dimension: .standard(.speed),
        toBaseScale: Math(1000) / Math(3600),
        system: .si
    )

    public static let milePerHour = Unit(
        name: "mile per hour",
        symbol: "mph",
        dimension: .standard(.speed),
        toBaseScale: Math(1609.344) / Math(3600),
        system: .usCustomary
    )

    public static let footPerSecond = Unit(
        name: "foot per second",
        symbol: "ft/s",
        dimension: .standard(.speed),
        toBaseScale: Math(0.3048),
        system: .usCustomary
    )

    public static let gramPerCubicCentimeter = Unit(
        name: "gram per cubic centimeter",
        symbol: "g/cm³",
        dimension: .standard(.density),
        toBaseScale: Math(1000),
        system: .si
    )

    public static let gramPerCubicCentimeterAscii = Unit(
        name: "gram per cubic centimeter",
        symbol: "g/cm^3",
        dimension: .standard(.density),
        toBaseScale: Math(1000),
        system: .si
    )

    public static let kilogramPerCubicMeter = Unit(
        name: "kilogram per cubic meter",
        symbol: "kg/m³",
        dimension: .standard(.density),
        toBaseScale: Math(1),
        system: .si
    )

    public static let kilogramPerCubicMeterAscii = Unit(
        name: "kilogram per cubic meter",
        symbol: "kg/m^3",
        dimension: .standard(.density),
        toBaseScale: Math(1),
        system: .si
    )

    public static let milligram = gram.prefixed(.milli)
    public static let microgram = gram.prefixed(.micro)
    public static let microgramAscii = gram.prefixed(.microAscii, symbolOverride: "ug")

    public static let ounce = Unit(
        name: "ounce",
        symbol: "oz",
        dimension: .standard(.mass),
        toBaseScale: Math(0.028349523125),
        system: .usCustomary
    )

    public static let ounceMass = ounce

    public static let pound = Unit(
        name: "pound",
        symbol: "lb",
        dimension: .standard(.mass),
        toBaseScale: Math(0.45359237),
        system: .usCustomary
    )

    public static let poundMass = pound

    public static let stone = Unit(
        name: "stone",
        symbol: "st",
        dimension: .standard(.mass),
        toBaseScale: Math(6.35029318),
        system: .imperial
    )

    public static let shortTon = Unit(
        name: "short ton",
        symbol: "ton (US)",
        dimension: .standard(.mass),
        toBaseScale: Math(907.18474),
        system: .usCustomary
    )

    public static let longTon = Unit(
        name: "long ton",
        symbol: "ton (UK)",
        dimension: .standard(.mass),
        toBaseScale: Math(1016.0469088),
        system: .imperial
    )

    public static let celsius = Unit(
        name: "celsius",
        symbol: "°C",
        dimension: .standard(.temperature),
        toBaseScale: Math(1),
        toBaseOffset: Math(273.15),
        system: .si
    )

    public static let celsiusAscii = Unit(
        name: "celsius",
        symbol: "degC",
        dimension: .standard(.temperature),
        toBaseScale: Math(1),
        toBaseOffset: Math(273.15),
        system: .si
    )

    public static let fahrenheit = Unit(
        name: "fahrenheit",
        symbol: "°F",
        dimension: .standard(.temperature),
        toBaseScale: Math(5) / Math(9),
        toBaseOffset: Math(255.3722222222222),
        system: .usCustomary
    )

    public static let fahrenheitAscii = Unit(
        name: "fahrenheit",
        symbol: "degF",
        dimension: .standard(.temperature),
        toBaseScale: Math(5) / Math(9),
        toBaseOffset: Math(255.3722222222222),
        system: .usCustomary
    )

    public static let rankine = Unit(
        name: "rankine",
        symbol: "°R",
        dimension: .standard(.temperature),
        toBaseScale: Math(5) / Math(9),
        toBaseOffset: Math(0),
        system: .usCustomary
    )

    public static let rankineAscii = Unit(
        name: "rankine",
        symbol: "degR",
        dimension: .standard(.temperature),
        toBaseScale: Math(5) / Math(9),
        toBaseOffset: Math(0),
        system: .usCustomary
    )

    public static let degree = Unit(
        name: "degree",
        symbol: "°",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi / Math(180),
        system: .si
    )

    public static let degreeAscii = Unit(
        name: "degree",
        symbol: "deg",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi / Math(180),
        system: .si
    )

    public static let turn = Unit(
        name: "turn",
        symbol: "rev",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi * Math(2),
        system: .si
    )

    public static let gradian = Unit(
        name: "gradian",
        symbol: "gon",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi / Math(200),
        system: .si
    )

    public static let hertz = Unit(
        name: "hertz",
        symbol: "Hz",
        dimension: .standard(.frequency),
        toBaseScale: Math(1),
        system: .si
    )

    public static let kilohertz = hertz.prefixed(.kilo)
    public static let megahertz = hertz.prefixed(.mega)
    public static let gigahertz = hertz.prefixed(.giga)

    public static let middleC = Unit(
        name: "middle C (C4)",
        symbol: "C4",
        dimension: .standard(.frequency),
        toBaseScale: Math(261.6255653005986),
        notes: "Specific pitch reference; defined as 261.625565... Hz with A4 = 440 Hz.",
        system: .si
    )

    public static let rpm = Unit(
        name: "revolutions per minute",
        symbol: "rpm",
        dimension: .standard(.frequency),
        toBaseScale: Math(1) / Math(60),
        system: .si
    )

    public static let newton = Unit(
        name: "newton",
        symbol: "N",
        dimension: .standard(.force),
        toBaseScale: Math(1),
        system: .si
    )

    public static let poundForce = Unit(
        name: "pound-force",
        symbol: "lbf",
        dimension: .standard(.force),
        toBaseScale: Math(4.4482216152605),
        system: .usCustomary
    )

    public static let poundWeight = poundForce

    public static let kilogramForce = Unit(
        name: "kilogram-force",
        symbol: "kgf",
        dimension: .standard(.force),
        toBaseScale: Math(9.80665),
        system: .si
    )

    public static let kilogramWeight = kilogramForce

    public static let pascal = Unit(
        name: "pascal",
        symbol: "Pa",
        dimension: .standard(.pressure),
        toBaseScale: Math(1),
        system: .si
    )

    public static let bar = Unit(
        name: "bar",
        symbol: "bar",
        dimension: .standard(.pressure),
        toBaseScale: Math(100000),
        system: .si
    )

    public static let atmosphere = Unit(
        name: "standard atmosphere",
        symbol: "atm",
        dimension: .standard(.pressure),
        toBaseScale: Math(101325),
        system: .si
    )

    public static let psi = Unit(
        name: "pound per square inch",
        symbol: "psi",
        dimension: .standard(.pressure),
        toBaseScale: Math(6894.757293168),
        system: .usCustomary
    )

    public static let torr = Unit(
        name: "torr",
        symbol: "Torr",
        dimension: .standard(.pressure),
        toBaseScale: Math(133.32236842105263),
        system: .si
    )

    public static let millimeterOfMercury = Unit(
        name: "millimeter of mercury",
        symbol: "mmHg",
        dimension: .standard(.pressure),
        toBaseScale: Math(133.32236842105263),
        system: .si
    )

    public static let joule = Unit(
        name: "joule",
        symbol: "J",
        dimension: .standard(.energy),
        toBaseScale: Math(1),
        system: .si
    )

    public static let kilojoule = joule.prefixed(.kilo)

    public static let calorie = Unit(
        name: "calorie",
        symbol: "cal",
        dimension: .standard(.energy),
        toBaseScale: Math(4.184),
        system: .si
    )

    public static let kilocalorie = Unit(
        name: "kilocalorie",
        symbol: "kcal",
        dimension: .standard(.energy),
        toBaseScale: Math(4184),
        system: .si
    )

    public static let wattHour = Unit(
        name: "watt-hour",
        symbol: "Wh",
        dimension: .standard(.energy),
        toBaseScale: Math(3600),
        system: .si
    )

    public static let kilowattHour = Unit(
        name: "kilowatt-hour",
        symbol: "kWh",
        dimension: .standard(.energy),
        toBaseScale: Math(3600000),
        system: .si
    )

    public static let watt = Unit(
        name: "watt",
        symbol: "W",
        dimension: .standard(.power),
        toBaseScale: Math(1),
        system: .si
    )

    public static let kilowatt = watt.prefixed(.kilo)

    public static let horsepower = Unit(
        name: "horsepower",
        symbol: "hp",
        dimension: .standard(.power),
        toBaseScale: Math(745.6998715822702),
        system: .usCustomary
    )

    public static let liter = Unit(
        name: "liter",
        symbol: "L",
        dimension: .standard(.volume),
        toBaseScale: Math(0.001),
        system: .si
    )

    public static let milliliter = liter.prefixed(.milli, symbolOverride: "mL")

    public static let teaspoonUS = Unit(
        name: "teaspoon (US)",
        symbol: "tsp",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00000492892159375),
        system: .usCustomary
    )

    public static let tablespoonUS = Unit(
        name: "tablespoon (US)",
        symbol: "tbsp",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00001478676478125),
        system: .usCustomary
    )

    public static let fluidOunceUS = Unit(
        name: "fluid ounce (US)",
        symbol: "fl oz",
        dimension: .standard(.volume),
        toBaseScale: Math(0.0000295735295625),
        system: .usCustomary
    )

    public static let cupUS = Unit(
        name: "cup (US)",
        symbol: "cup",
        dimension: .standard(.volume),
        toBaseScale: Math(0.0002365882365),
        system: .usCustomary
    )

    public static let coffeeCupUS = Unit(
        name: "coffee cup (US)",
        symbol: "coffee cup",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000177441177),
        notes: "Common US coffee cup defined as 6 US fl oz.",
        system: .usCustomary
    )

    public static let pintUS = Unit(
        name: "pint (US)",
        symbol: "pt",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000473176473),
        system: .usCustomary
    )

    public static let quartUS = Unit(
        name: "quart (US)",
        symbol: "qt",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000946352946),
        system: .usCustomary
    )

    public static let gallonUS = Unit(
        name: "gallon (US)",
        symbol: "gal",
        dimension: .standard(.volume),
        toBaseScale: Math(0.003785411784),
        system: .usCustomary
    )

    public static let fluidOunceUK = Unit(
        name: "fluid ounce (UK)",
        symbol: "fl oz (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.0000284130625),
        system: .imperial
    )

    public static let cupUK = Unit(
        name: "cup (UK)",
        symbol: "cup (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000284130625),
        system: .imperial
    )

    public static let pintUK = Unit(
        name: "pint (UK)",
        symbol: "pt (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00056826125),
        system: .imperial
    )

    public static let gallonUK = Unit(
        name: "gallon (UK)",
        symbol: "gal (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00454609),
        system: .imperial
    )

    public static let cupMetric = Unit(
        name: "cup (metric)",
        symbol: "cup (metric)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00025),
        system: .si
    )

    public static let cubicInch = Unit(
        name: "cubic inch",
        symbol: "in³",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000016387064),
        system: .usCustomary
    )

    public static let cubicInchAscii = Unit(
        name: "cubic inch",
        symbol: "in^3",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000016387064),
        system: .usCustomary
    )

    public static let cubicFoot = Unit(
        name: "cubic foot",
        symbol: "ft³",
        dimension: .standard(.volume),
        toBaseScale: Math(0.028316846592),
        system: .usCustomary
    )

    public static let cubicFootAscii = Unit(
        name: "cubic foot",
        symbol: "ft^3",
        dimension: .standard(.volume),
        toBaseScale: Math(0.028316846592),
        system: .usCustomary
    )

    public static let cubicYard = Unit(
        name: "cubic yard",
        symbol: "yd³",
        dimension: .standard(.volume),
        toBaseScale: Math(0.764554857984),
        system: .usCustomary
    )

    public static let cubicYardAscii = Unit(
        name: "cubic yard",
        symbol: "yd^3",
        dimension: .standard(.volume),
        toBaseScale: Math(0.764554857984),
        system: .usCustomary
    )

    public static let bit = Unit(
        name: "bit",
        symbol: "b",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1) / Math(8),
        system: .si
    )

    public static let byte = Unit(
        name: "byte",
        symbol: "B",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1),
        system: .si
    )

    public static let kilobyte = byte.prefixed(.kilo)
    public static let megabyte = byte.prefixed(.mega)
    public static let gigabyte = byte.prefixed(.giga)

    public static let kibibyte = Unit(
        name: "kibibyte",
        symbol: "KiB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1024),
        system: .si
    )

    public static let mebibyte = Unit(
        name: "mebibyte",
        symbol: "MiB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1048576),
        system: .si
    )

    public static let gibibyte = Unit(
        name: "gibibyte",
        symbol: "GiB",
        dimension: .standard(.dataStorage),
        toBaseScale: Math(1073741824),
        system: .si
    )

    public static let bitPerSecond = Unit(
        name: "bit per second",
        symbol: "b/s",
        dimension: .standard(.dataRate),
        toBaseScale: Math(1),
        system: .si
    )

    public static let bytePerSecond = Unit(
        name: "byte per second",
        symbol: "B/s",
        dimension: .standard(.dataRate),
        toBaseScale: Math(8),
        system: .si
    )

    // MARK: - SI-accepted non-SI units
    public static let litre = Unit(
        name: "litre",
        symbol: "l",
        dimension: .standard(.volume),
        toBaseScale: Math(0.001),
        system: .si
    )

    public static let hectare = Unit(
        name: "hectare",
        symbol: "ha",
        dimension: .standard(.area),
        toBaseScale: Math(10000),
        system: .si
    )

    public static let are = Unit(
        name: "are",
        symbol: "a",
        dimension: .standard(.area),
        toBaseScale: Math(100),
        system: .si
    )

    public static let angstrom = Unit(
        name: "angstrom",
        symbol: "Å",
        dimension: .standard(.length),
        toBaseScale: Math(1e-10),
        system: .si
    )

    public static let angstromAscii = Unit(
        name: "angstrom",
        symbol: "angstrom",
        dimension: .standard(.length),
        toBaseScale: Math(1e-10),
        system: .si
    )

    public static let electronVolt = Unit(
        name: "electronvolt",
        symbol: "eV",
        dimension: .standard(.energy),
        toBaseScale: Math(1.602176634e-19),
        system: .si
    )

    public static let knot = Unit(
        name: "knot",
        symbol: "kn",
        dimension: .standard(.speed),
        toBaseScale: Math(1852) / Math(3600),
        system: .imperial
    )

    public static let astronomicalUnit = Unit(
        name: "astronomical unit",
        symbol: "au",
        dimension: .standard(.length),
        toBaseScale: Math(149597870700),
        system: .astronomical
    )

    public static let lightYear = Unit(
        name: "light-year",
        symbol: "ly",
        dimension: .standard(.length),
        toBaseScale: Math(9.4607304725808e15),
        system: .astronomical
    )

    public static let parsec = Unit(
        name: "parsec",
        symbol: "pc",
        dimension: .standard(.length),
        toBaseScale: Math(3.0856775814913673e16),
        system: .astronomical
    )

    public static let kiloparsec = Unit(
        name: "kiloparsec",
        symbol: "kpc",
        dimension: .standard(.length),
        toBaseScale: Math(3.0856775814913673e19),
        system: .astronomical
    )

    public static let megaparsec = Unit(
        name: "megaparsec",
        symbol: "Mpc",
        dimension: .standard(.length),
        toBaseScale: Math(3.0856775814913673e22),
        system: .astronomical
    )

    public static let dalton = Unit(
        name: "dalton",
        symbol: "Da",
        dimension: .standard(.mass),
        toBaseScale: Math(1.66053906660e-27),
        system: .si
    )

    // MARK: - US/Imperial (expanded)
    public static let teaspoonUK = Unit(
        name: "teaspoon (UK)",
        symbol: "tsp (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000005919388020833333),
        system: .imperial
    )

    public static let tablespoonUK = Unit(
        name: "tablespoon (UK)",
        symbol: "tbsp (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.0000177581640625),
        system: .imperial
    )

    public static let gillUS = Unit(
        name: "gill (US)",
        symbol: "gi",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00011829411825),
        system: .usCustomary
    )

    public static let gillUK = Unit(
        name: "gill (UK)",
        symbol: "gi (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.0001420653125),
        system: .imperial
    )

    public static let quartUK = Unit(
        name: "quart (UK)",
        symbol: "qt (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.0011365225),
        system: .imperial
    )

    public static let cupUSLegal = Unit(
        name: "cup (US legal)",
        symbol: "cup (US legal)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.00024),
        system: .usCustomary
    )

    public static let coffeeCupUK = Unit(
        name: "coffee cup (UK)",
        symbol: "coffee cup (imp)",
        dimension: .standard(.volume),
        toBaseScale: Math(0.000170478375),
        notes: "Common UK coffee cup defined as 6 imperial fl oz.",
        system: .imperial
    )

    public static let barrelOilUS = Unit(
        name: "barrel (oil, US)",
        symbol: "bbl",
        dimension: .standard(.volume),
        toBaseScale: Math(0.158987294928),
        system: .usCustomary
    )

    public static let acre = Unit(
        name: "acre",
        symbol: "ac",
        dimension: .standard(.area),
        toBaseScale: Math(4046.8564224),
        system: .usCustomary
    )

    public static let squareInch = Unit(
        name: "square inch",
        symbol: "in²",
        dimension: .standard(.area),
        toBaseScale: Math(0.00064516),
        system: .usCustomary
    )

    public static let squareInchAscii = Unit(
        name: "square inch",
        symbol: "in^2",
        dimension: .standard(.area),
        toBaseScale: Math(0.00064516),
        system: .usCustomary
    )

    public static let squareFoot = Unit(
        name: "square foot",
        symbol: "ft²",
        dimension: .standard(.area),
        toBaseScale: Math(0.09290304),
        system: .usCustomary
    )

    public static let squareFootAscii = Unit(
        name: "square foot",
        symbol: "ft^2",
        dimension: .standard(.area),
        toBaseScale: Math(0.09290304),
        system: .usCustomary
    )

    public static let squareYard = Unit(
        name: "square yard",
        symbol: "yd²",
        dimension: .standard(.area),
        toBaseScale: Math(0.83612736),
        system: .usCustomary
    )

    public static let squareYardAscii = Unit(
        name: "square yard",
        symbol: "yd^2",
        dimension: .standard(.area),
        toBaseScale: Math(0.83612736),
        system: .usCustomary
    )

    public static let squareMile = Unit(
        name: "square mile",
        symbol: "mi²",
        dimension: .standard(.area),
        toBaseScale: Math(2589988.110336),
        system: .usCustomary
    )

    public static let squareMileAscii = Unit(
        name: "square mile",
        symbol: "mi^2",
        dimension: .standard(.area),
        toBaseScale: Math(2589988.110336),
        system: .usCustomary
    )

    public static let troyOunce = Unit(
        name: "troy ounce",
        symbol: "oz t",
        dimension: .standard(.mass),
        toBaseScale: Math(0.0311034768),
        system: .imperial
    )

    public static let troyPound = Unit(
        name: "troy pound",
        symbol: "lb t",
        dimension: .standard(.mass),
        toBaseScale: Math(0.3732417216),
        system: .imperial
    )

    public static let grain = Unit(
        name: "grain",
        symbol: "gr",
        dimension: .standard(.mass),
        toBaseScale: Math(0.00006479891),
        system: .imperial
    )

    public static let slug = Unit(
        name: "slug",
        symbol: "slug",
        dimension: .standard(.mass),
        toBaseScale: Math(14.59390294),
        system: .usCustomary
    )

    // MARK: - CGS (legacy scientific)
    public static let dyne = Unit(
        name: "dyne",
        symbol: "dyn",
        dimension: .standard(.force),
        toBaseScale: Math(1e-5),
        system: .cgs
    )

    public static let erg = Unit(
        name: "erg",
        symbol: "erg",
        dimension: .standard(.energy),
        toBaseScale: Math(1e-7),
        system: .cgs
    )

    public static let barye = Unit(
        name: "barye",
        symbol: "Ba",
        dimension: .standard(.pressure),
        toBaseScale: Math(0.1),
        system: .cgs
    )

    public static let galileo = Unit(
        name: "gal",
        symbol: "Gal",
        dimension: .standard(.acceleration),
        toBaseScale: Math(0.01),
        system: .cgs
    )

    public static let poise = Unit(
        name: "poise",
        symbol: "P",
        dimension: .standard(.dynamicViscosity),
        toBaseScale: Math(0.1),
        system: .cgs
    )

    public static let stokes = Unit(
        name: "stokes",
        symbol: "St",
        dimension: .standard(.kinematicViscosity),
        toBaseScale: Math(1e-4),
        system: .cgs
    )

    public static let gauss = Unit(
        name: "gauss",
        symbol: "G",
        dimension: .standard(.magneticFluxDensity),
        toBaseScale: Math(1e-4),
        system: .cgs
    )

    public static let maxwell = Unit(
        name: "maxwell",
        symbol: "Mx",
        dimension: .standard(.magneticFlux),
        toBaseScale: Math(1e-8),
        system: .cgs
    )

    public static let amperePerMeter = Unit(
        name: "ampere per meter",
        symbol: "A/m",
        dimension: .standard(.magneticFieldStrength),
        toBaseScale: Math(1),
        system: .si
    )

    public static let oersted = Unit(
        name: "oersted",
        symbol: "Oe",
        dimension: .standard(.magneticFieldStrength),
        toBaseScale: Math(79.57747154594767),
        system: .cgs
    )

    public static let voltPerMeter = Unit(
        name: "volt per meter",
        symbol: "V/m",
        dimension: .standard(.electricFieldStrength),
        toBaseScale: Math(1),
        system: .si
    )

    public static let statvoltPerCentimeter = Unit(
        name: "statvolt per centimeter",
        symbol: "statV/cm",
        dimension: .standard(.electricFieldStrength),
        toBaseScale: Math(29979.2458),
        system: .cgs
    )

    // MARK: - SI derived units
    public static let squareMeter = Unit(
        name: "square meter",
        symbol: "m²",
        dimension: .standard(.area),
        toBaseScale: Math(1),
        system: .si
    )

    public static let squareMeterAscii = Unit(
        name: "square meter",
        symbol: "m^2",
        dimension: .standard(.area),
        toBaseScale: Math(1),
        system: .si
    )

    public static let squareKilometer = Unit(
        name: "square kilometer",
        symbol: "km²",
        dimension: .standard(.area),
        toBaseScale: Math(1_000_000),
        system: .si
    )

    public static let squareKilometerAscii = Unit(
        name: "square kilometer",
        symbol: "km^2",
        dimension: .standard(.area),
        toBaseScale: Math(1_000_000),
        system: .si
    )

    public static let cubicMeter = Unit(
        name: "cubic meter",
        symbol: "m³",
        dimension: .standard(.volume),
        toBaseScale: Math(1),
        system: .si
    )

    public static let cubicMeterAscii = Unit(
        name: "cubic meter",
        symbol: "m^3",
        dimension: .standard(.volume),
        toBaseScale: Math(1),
        system: .si
    )

    public static let coulomb = Unit(
        name: "coulomb",
        symbol: "C",
        dimension: .standard(.electricCharge),
        toBaseScale: Math(1),
        system: .si
    )

    public static let volt = Unit(
        name: "volt",
        symbol: "V",
        dimension: .standard(.voltage),
        toBaseScale: Math(1),
        system: .si
    )

    public static let ohm = Unit(
        name: "ohm",
        symbol: "Ω",
        dimension: .standard(.electricalResistance),
        toBaseScale: Math(1),
        system: .si
    )

    public static let ohmAscii = Unit(
        name: "ohm",
        symbol: "ohm",
        dimension: .standard(.electricalResistance),
        toBaseScale: Math(1),
        system: .si
    )

    public static let siemens = Unit(
        name: "siemens",
        symbol: "S",
        dimension: .standard(.electricConductance),
        toBaseScale: Math(1),
        system: .si
    )

    public static let farad = Unit(
        name: "farad",
        symbol: "F",
        dimension: .standard(.electricCapacitance),
        toBaseScale: Math(1),
        system: .si
    )

    public static let henry = Unit(
        name: "henry",
        symbol: "H",
        dimension: .standard(.inductance),
        toBaseScale: Math(1),
        system: .si
    )

    public static let weber = Unit(
        name: "weber",
        symbol: "Wb",
        dimension: .standard(.magneticFlux),
        toBaseScale: Math(1),
        system: .si
    )

    public static let tesla = Unit(
        name: "tesla",
        symbol: "T",
        dimension: .standard(.magneticFluxDensity),
        toBaseScale: Math(1),
        system: .si
    )

    public static let lumen = Unit(
        name: "lumen",
        symbol: "lm",
        dimension: .standard(.luminousFlux),
        toBaseScale: Math(1),
        system: .si
    )

    public static let lux = Unit(
        name: "lux",
        symbol: "lx",
        dimension: .standard(.illuminance),
        toBaseScale: Math(1),
        system: .si
    )

    public static let becquerel = Unit(
        name: "becquerel",
        symbol: "Bq",
        dimension: .standard(.radioactivity),
        toBaseScale: Math(1),
        system: .si
    )

    public static let gray = Unit(
        name: "gray",
        symbol: "Gy",
        dimension: .standard(.absorbedDose),
        toBaseScale: Math(1),
        system: .si
    )

    public static let sievert = Unit(
        name: "sievert",
        symbol: "Sv",
        dimension: .standard(.doseEquivalent),
        toBaseScale: Math(1),
        system: .si
    )

    public static let katal = Unit(
        name: "katal",
        symbol: "kat",
        dimension: .standard(.catalyticActivity),
        toBaseScale: Math(1),
        system: .si
    )

    public static let radian = Unit(
        name: "radian",
        symbol: "rad",
        dimension: .standard(.angle),
        toBaseScale: Math(1),
        system: .si
    )

    public static let arcminute = Unit(
        name: "arcminute",
        symbol: "′",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi / Math(10800),
        system: .si
    )

    public static let arcminuteAscii = Unit(
        name: "arcminute",
        symbol: "arcmin",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi / Math(10800),
        system: .si
    )

    public static let arcsecond = Unit(
        name: "arcsecond",
        symbol: "″",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi / Math(648000),
        system: .si
    )

    public static let arcsecondAscii = Unit(
        name: "arcsecond",
        symbol: "arcsec",
        dimension: .standard(.angle),
        toBaseScale: MathConstants.pi / Math(648000),
        system: .si
    )

    public static let steradian = Unit(
        name: "steradian",
        symbol: "sr",
        dimension: .standard(.solidAngle),
        toBaseScale: Math(1),
        system: .si
    )

    public static let meterPerSecond = Unit(
        name: "meter per second",
        symbol: "m/s",
        dimension: .standard(.speed),
        toBaseScale: Math(1),
        system: .si
    )

    public static let meterPerSecondSquared = Unit(
        name: "meter per second squared",
        symbol: "m/s²",
        dimension: .standard(.acceleration),
        toBaseScale: Math(1),
        system: .si
    )

    public static let meterPerSecondSquaredAscii = Unit(
        name: "meter per second squared",
        symbol: "m/s^2",
        dimension: .standard(.acceleration),
        toBaseScale: Math(1),
        system: .si
    )

    // MARK: - SI mass helpers
    public static let tonne = Unit(
        name: "tonne",
        symbol: "t",
        dimension: .standard(.mass),
        toBaseScale: Math(1000),
        system: .si
    )

    public static let atomicMassUnit = Unit(
        name: "atomic mass unit",
        symbol: "u",
        dimension: .standard(.mass),
        toBaseScale: Math(1.66053906660e-27),
        system: .si
    )

    // MARK: - Dimensionless units
    public static let unitless = Unit(
        name: "unitless",
        symbol: "1",
        dimension: .standard(.dimensionless),
        toBaseScale: Math(1),
        system: .si
    )

    public static let percent = Unit(
        name: "percent",
        symbol: "%",
        dimension: .standard(.dimensionless),
        toBaseScale: Math(0.01),
        system: .si
    )

    public static let permille = Unit(
        name: "permille",
        symbol: "‰",
        dimension: .standard(.dimensionless),
        toBaseScale: Math(0.001),
        system: .si
    )

    public static let permilleAscii = Unit(
        name: "permille",
        symbol: "permille",
        dimension: .standard(.dimensionless),
        toBaseScale: Math(0.001),
        system: .si
    )

    public static let albedo = Unit(
        name: "albedo",
        symbol: "α",
        dimension: .standard(.dimensionless),
        toBaseScale: Math(1),
        system: .si
    )

    public static let albedoAscii = Unit(
        name: "albedo",
        symbol: "alb",
        dimension: .standard(.dimensionless),
        toBaseScale: Math(1),
        system: .si
    )

    // MARK: - Prefixed collections
    public static let meterSI = Unit.prefixedUnits(for: meter, prefixes: UnitPrefixes.siAll)
    public static let gramSI = Unit.prefixedUnits(for: gram, prefixes: UnitPrefixes.siAll)
    public static let secondSI = Unit.prefixedUnits(for: second, prefixes: UnitPrefixes.siAll)
    public static let ampereSI = Unit.prefixedUnits(for: ampere, prefixes: UnitPrefixes.siAll)
    public static let kelvinSI = Unit.prefixedUnits(for: kelvin, prefixes: UnitPrefixes.siAll)
    public static let moleSI = Unit.prefixedUnits(for: mole, prefixes: UnitPrefixes.siAll)
    public static let candelaSI = Unit.prefixedUnits(for: candela, prefixes: UnitPrefixes.siAll)
    public static let hertzSI = Unit.prefixedUnits(for: hertz, prefixes: UnitPrefixes.siAll)
    public static let newtonSI = Unit.prefixedUnits(for: newton, prefixes: UnitPrefixes.siAll)
    public static let pascalSI = Unit.prefixedUnits(for: pascal, prefixes: UnitPrefixes.siAll)
    public static let jouleSI = Unit.prefixedUnits(for: joule, prefixes: UnitPrefixes.siAll)
    public static let wattSI = Unit.prefixedUnits(for: watt, prefixes: UnitPrefixes.siAll)
    public static let coulombSI = Unit.prefixedUnits(for: coulomb, prefixes: UnitPrefixes.siAll)
    public static let voltSI = Unit.prefixedUnits(for: volt, prefixes: UnitPrefixes.siAll)
    public static let ohmSI = Unit.prefixedUnits(for: ohm, prefixes: UnitPrefixes.siAll)
    public static let siemensSI = Unit.prefixedUnits(for: siemens, prefixes: UnitPrefixes.siAll)
    public static let faradSI = Unit.prefixedUnits(for: farad, prefixes: UnitPrefixes.siAll)
    public static let henrySI = Unit.prefixedUnits(for: henry, prefixes: UnitPrefixes.siAll)
    public static let weberSI = Unit.prefixedUnits(for: weber, prefixes: UnitPrefixes.siAll)
    public static let teslaSI = Unit.prefixedUnits(for: tesla, prefixes: UnitPrefixes.siAll)
    public static let lumenSI = Unit.prefixedUnits(for: lumen, prefixes: UnitPrefixes.siAll)
    public static let luxSI = Unit.prefixedUnits(for: lux, prefixes: UnitPrefixes.siAll)
    public static let becquerelSI = Unit.prefixedUnits(for: becquerel, prefixes: UnitPrefixes.siAll)
    public static let graySI = Unit.prefixedUnits(for: gray, prefixes: UnitPrefixes.siAll)
    public static let sievertSI = Unit.prefixedUnits(for: sievert, prefixes: UnitPrefixes.siAll)
    public static let katalSI = Unit.prefixedUnits(for: katal, prefixes: UnitPrefixes.siAll)

    public static let byteSI = Unit.prefixedUnits(for: byte, prefixes: UnitPrefixes.siAll)
    public static let byteSIAscii = Unit.prefixedUnits(for: byte, prefixes: UnitPrefixes.siAllAscii)
    public static let byteBinary = Unit.prefixedUnits(for: byte, prefixes: UnitPrefixes.binary)
    public static let bitSI = Unit.prefixedUnits(for: bit, prefixes: UnitPrefixes.siAll)
    public static let bitSIAscii = Unit.prefixedUnits(for: bit, prefixes: UnitPrefixes.siAllAscii)
    public static let bitBinary = Unit.prefixedUnits(for: bit, prefixes: UnitPrefixes.binary)

    public static let bitPerSecondSI = Unit.prefixedUnits(for: bitPerSecond, prefixes: UnitPrefixes.siAll)
    public static let bitPerSecondSIAscii = Unit.prefixedUnits(for: bitPerSecond, prefixes: UnitPrefixes.siAllAscii)
    public static let bitPerSecondBinary = Unit.prefixedUnits(for: bitPerSecond, prefixes: UnitPrefixes.binary)
    public static let bytePerSecondSI = Unit.prefixedUnits(for: bytePerSecond, prefixes: UnitPrefixes.siAll)
    public static let bytePerSecondSIAscii = Unit.prefixedUnits(for: bytePerSecond, prefixes: UnitPrefixes.siAllAscii)
    public static let bytePerSecondBinary = Unit.prefixedUnits(for: bytePerSecond, prefixes: UnitPrefixes.binary)
}
