//
//  PhysicsUnits.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Physics & Scientific Units

/// Provides physics and scientific units including Planck units, electrical units, and more.
public struct PhysicsUnits {

    // MARK: - Planck Units (Natural Units)

    /// Planck length - smallest meaningful length in quantum mechanics
    public static let planckLength = Unit(
        name: "Planck length",
        symbol: "lₚ",
        dimension: .length,
        toBaseUnit: 1.616255e-35,
        notes: "≈ 1.616 × 10⁻³⁵ m (quantum foam scale)"
    )

    /// Planck mass - fundamental mass scale
    public static let planckMass = Unit(
        name: "Planck mass",
        symbol: "mₚ",
        dimension: .mass,
        toBaseUnit: 2.176434e-8,
        notes: "≈ 2.176 × 10⁻⁸ kg ≈ 21.76 μg"
    )

    /// Planck time - shortest meaningful time interval
    public static let planckTime = Unit(
        name: "Planck time",
        symbol: "tₚ",
        dimension: .time,
        toBaseUnit: 5.391247e-44,
        notes: "≈ 5.391 × 10⁻⁴⁴ s (time for light to cross Planck length)"
    )

    /// Planck temperature - highest meaningful temperature
    public static let planckTemperature = Unit(
        name: "Planck temperature",
        symbol: "Tₚ",
        dimension: .temperature,
        toBaseUnit: 1.416784e32,
        notes: "≈ 1.417 × 10³² K (universe's max temperature)"
    )

    // MARK: - Electrical Current

    /// Ampere - SI base unit of electric current
    public static let ampere = Unit(
        name: "ampere",
        symbol: "A",
        dimension: .electricCurrent,
        toBaseUnit: 1.0,
        notes: "SI base unit (1 C/s)"
    )

    /// Milliampere - 1/1000 ampere
    public static let milliampere = Unit(
        name: "milliampere",
        symbol: "mA",
        dimension: .electricCurrent,
        toBaseUnit: 0.001,
        notes: "= 0.001 A"
    )

    /// Microampere - 1/1,000,000 ampere
    public static let microampere = Unit(
        name: "microampere",
        symbol: "μA",
        dimension: .electricCurrent,
        toBaseUnit: 1e-6,
        notes: "= 0.000001 A"
    )

    /// Kiloampere - 1000 amperes
    public static let kiloampere = Unit(
        name: "kiloampere",
        symbol: "kA",
        dimension: .electricCurrent,
        toBaseUnit: 1000.0,
        notes: "= 1000 A (lightning ~20-30 kA)"
    )

    // MARK: - Electric Charge

    /// Coulomb - SI derived unit of electric charge
    public static let coulomb = Unit(
        name: "coulomb",
        symbol: "C",
        dimension: .electricCharge,
        toBaseUnit: 1.0,
        notes: "= 1 A·s"
    )

    /// Electron charge - fundamental charge unit
    public static let elementaryCharge = Unit(
        name: "elementary charge",
        symbol: "e",
        dimension: .electricCharge,
        toBaseUnit: 1.602176634e-19,
        notes: "≈ 1.602 × 10⁻¹⁹ C (charge of proton/electron)"
    )

    /// Ampere-hour - battery capacity unit
    public static let ampereHour = Unit(
        name: "ampere-hour",
        symbol: "Ah",
        dimension: .electricCharge,
        toBaseUnit: 3600.0,
        notes: "= 3600 C (battery capacity)"
    )

    /// Milliampere-hour - common battery capacity
    public static let milliampereHour = Unit(
        name: "milliampere-hour",
        symbol: "mAh",
        dimension: .electricCharge,
        toBaseUnit: 3.6,
        notes: "= 3.6 C (smartphone batteries ~3000-5000 mAh)"
    )

    // MARK: - Voltage

    /// Volt - SI derived unit of electric potential
    public static let volt = Unit(
        name: "volt",
        symbol: "V",
        dimension: .voltage,
        toBaseUnit: 1.0,
        notes: "= 1 W/A = 1 J/C"
    )

    /// Millivolt - 1/1000 volt
    public static let millivolt = Unit(
        name: "millivolt",
        symbol: "mV",
        dimension: .voltage,
        toBaseUnit: 0.001,
        notes: "= 0.001 V (nerve signals ~70 mV)"
    )

    /// Kilovolt - 1000 volts
    public static let kilovolt = Unit(
        name: "kilovolt",
        symbol: "kV",
        dimension: .voltage,
        toBaseUnit: 1000.0,
        notes: "= 1000 V (power lines 10-765 kV)"
    )

    /// Megavolt - 1,000,000 volts
    public static let megavolt = Unit(
        name: "megavolt",
        symbol: "MV",
        dimension: .voltage,
        toBaseUnit: 1_000_000.0,
        notes: "= 1 million V (lightning ~100 MV)"
    )

    // MARK: - Electrical Resistance

    /// Ohm - SI derived unit of electrical resistance
    public static let ohm = Unit(
        name: "ohm",
        symbol: "Ω",
        dimension: .electricalResistance,
        toBaseUnit: 1.0,
        notes: "= 1 V/A"
    )

    /// Milliohm - 1/1000 ohm
    public static let milliohm = Unit(
        name: "milliohm",
        symbol: "mΩ",
        dimension: .electricalResistance,
        toBaseUnit: 0.001,
        notes: "= 0.001 Ω"
    )

    /// Kiloohm - 1000 ohms
    public static let kiloohm = Unit(
        name: "kiloohm",
        symbol: "kΩ",
        dimension: .electricalResistance,
        toBaseUnit: 1000.0,
        notes: "= 1000 Ω"
    )

    /// Megaohm - 1,000,000 ohms
    public static let megaohm = Unit(
        name: "megaohm",
        symbol: "MΩ",
        dimension: .electricalResistance,
        toBaseUnit: 1_000_000.0,
        notes: "= 1 million Ω"
    )

    // MARK: - Power

    /// Watt - SI derived unit of power
    public static let watt = Unit(
        name: "watt",
        symbol: "W",
        dimension: .power,
        toBaseUnit: 1.0,
        notes: "= 1 J/s = 1 V·A"
    )

    /// Milliwatt - 1/1000 watt
    public static let milliwatt = Unit(
        name: "milliwatt",
        symbol: "mW",
        dimension: .power,
        toBaseUnit: 0.001,
        notes: "= 0.001 W (laser pointer ~1-5 mW)"
    )

    /// Kilowatt - 1000 watts
    public static let kilowatt = Unit(
        name: "kilowatt",
        symbol: "kW",
        dimension: .power,
        toBaseUnit: 1000.0,
        notes: "= 1000 W (home appliances)"
    )

    /// Megawatt - 1,000,000 watts
    public static let megawatt = Unit(
        name: "megawatt",
        symbol: "MW",
        dimension: .power,
        toBaseUnit: 1_000_000.0,
        notes: "= 1 million W (small power plant)"
    )

    /// Gigawatt - 1,000,000,000 watts
    public static let gigawatt = Unit(
        name: "gigawatt",
        symbol: "GW",
        dimension: .power,
        toBaseUnit: 1_000_000_000.0,
        notes: "= 1 billion W (large power plant)"
    )

    /// Horsepower (mechanical) - imperial power unit
    public static let horsepower = Unit(
        name: "horsepower",
        symbol: "hp",
        dimension: .power,
        toBaseUnit: 745.69987158227022,
        notes: "≈ 745.7 W (mechanical horsepower)"
    )

    /// Metric horsepower (PS)
    public static let horsepowerMetric = Unit(
        name: "metric horsepower",
        symbol: "PS",
        dimension: .power,
        toBaseUnit: 735.49875,
        notes: "≈ 735.5 W (European automotive)"
    )

    // MARK: - Energy

    /// Joule - SI derived unit of energy
    public static let joule = Unit(
        name: "joule",
        symbol: "J",
        dimension: .energy,
        toBaseUnit: 1.0,
        notes: "= 1 N·m = 1 W·s"
    )

    /// Kilojoule - 1000 joules
    public static let kilojoule = Unit(
        name: "kilojoule",
        symbol: "kJ",
        dimension: .energy,
        toBaseUnit: 1000.0,
        notes: "= 1000 J (food energy)"
    )

    /// Calorie (thermochemical)
    public static let calorie = Unit(
        name: "calorie",
        symbol: "cal",
        dimension: .energy,
        toBaseUnit: 4.184,
        notes: "≈ 4.184 J (small calorie)"
    )

    /// Kilocalorie - 1000 calories (food Calorie)
    public static let kilocalorie = Unit(
        name: "kilocalorie",
        symbol: "kcal",
        dimension: .energy,
        toBaseUnit: 4184.0,
        notes: "= 4184 J = 1 food Calorie"
    )

    /// Kilowatt-hour - electrical energy unit
    public static let kilowattHour = Unit(
        name: "kilowatt-hour",
        symbol: "kWh",
        dimension: .energy,
        toBaseUnit: 3_600_000.0,
        notes: "= 3.6 MJ (household electricity billing)"
    )

    /// Electron volt - atomic/particle energy unit
    public static let electronVolt = Unit(
        name: "electron volt",
        symbol: "eV",
        dimension: .energy,
        toBaseUnit: 1.602176634e-19,
        notes: "≈ 1.602 × 10⁻¹⁹ J (atomic scale)"
    )

    /// Megaelectron volt - nuclear energy scale
    public static let megaelectronVolt = Unit(
        name: "megaelectron volt",
        symbol: "MeV",
        dimension: .energy,
        toBaseUnit: 1.602176634e-13,
        notes: "≈ 1.602 × 10⁻¹³ J (nuclear scale)"
    )

    /// Gigaelectron volt - particle accelerator energy
    public static let gigaelectronVolt = Unit(
        name: "gigaelectron volt",
        symbol: "GeV",
        dimension: .energy,
        toBaseUnit: 1.602176634e-10,
        notes: "≈ 1.602 × 10⁻¹⁰ J (LHC ~14 TeV)"
    )

    /// British thermal unit
    public static let btu = Unit(
        name: "British thermal unit",
        symbol: "BTU",
        dimension: .energy,
        toBaseUnit: 1055.05585262,
        notes: "≈ 1055 J (HVAC systems)"
    )

    /// Ton of TNT equivalent - explosive energy
    public static let tonTNT = Unit(
        name: "ton of TNT",
        symbol: "tTNT",
        dimension: .energy,
        toBaseUnit: 4.184e9,
        notes: "= 4.184 GJ (nuclear yields measured in kT/MT)"
    )

    // MARK: - Frequency

    /// Hertz - SI derived unit of frequency
    public static let hertz = Unit(
        name: "hertz",
        symbol: "Hz",
        dimension: .frequency,
        toBaseUnit: 1.0,
        notes: "= 1/s (cycles per second)"
    )

    /// Kilohertz - 1000 hertz
    public static let kilohertz = Unit(
        name: "kilohertz",
        symbol: "kHz",
        dimension: .frequency,
        toBaseUnit: 1000.0,
        notes: "= 1000 Hz (AM radio)"
    )

    /// Megahertz - 1,000,000 hertz
    public static let megahertz = Unit(
        name: "megahertz",
        symbol: "MHz",
        dimension: .frequency,
        toBaseUnit: 1_000_000.0,
        notes: "= 1 million Hz (FM radio 88-108 MHz)"
    )

    /// Gigahertz - 1,000,000,000 hertz
    public static let gigahertz = Unit(
        name: "gigahertz",
        symbol: "GHz",
        dimension: .frequency,
        toBaseUnit: 1_000_000_000.0,
        notes: "= 1 billion Hz (CPU speeds 2-5 GHz)"
    )

    /// Terahertz - 1,000,000,000,000 hertz
    public static let terahertz = Unit(
        name: "terahertz",
        symbol: "THz",
        dimension: .frequency,
        toBaseUnit: 1_000_000_000_000.0,
        notes: "= 1 trillion Hz (infrared light ~100 THz)"
    )

    /// Revolutions per minute - rotational frequency
    public static let rpm = Unit(
        name: "revolutions per minute",
        symbol: "rpm",
        dimension: .frequency,
        toBaseUnit: 1.0 / 60.0,
        notes: "≈ 0.0167 Hz (engine speeds)"
    )

    // MARK: - Pressure

    /// Pascal - SI derived unit of pressure
    public static let pascal = Unit(
        name: "pascal",
        symbol: "Pa",
        dimension: .pressure,
        toBaseUnit: 1.0,
        notes: "= 1 N/m²"
    )

    /// Kilopascal - 1000 pascals
    public static let kilopascal = Unit(
        name: "kilopascal",
        symbol: "kPa",
        dimension: .pressure,
        toBaseUnit: 1000.0,
        notes: "= 1000 Pa (tire pressure ~200-300 kPa)"
    )

    /// Bar - common pressure unit
    public static let bar = Unit(
        name: "bar",
        symbol: "bar",
        dimension: .pressure,
        toBaseUnit: 100_000.0,
        notes: "= 100 kPa ≈ 1 atm"
    )

    /// Atmosphere - standard atmospheric pressure
    public static let atmosphere = Unit(
        name: "atmosphere",
        symbol: "atm",
        dimension: .pressure,
        toBaseUnit: 101_325.0,
        notes: "= 101.325 kPa (sea level pressure)"
    )

    /// Pounds per square inch
    public static let psi = Unit(
        name: "pounds per square inch",
        symbol: "psi",
        dimension: .pressure,
        toBaseUnit: 6894.757293168,
        notes: "≈ 6895 Pa (US tire pressure ~32-35 psi)"
    )

    /// Millimeter of mercury - medical pressure
    public static let mmHg = Unit(
        name: "millimeter of mercury",
        symbol: "mmHg",
        dimension: .pressure,
        toBaseUnit: 133.322387415,
        notes: "≈ 133.3 Pa (blood pressure 120/80 mmHg)"
    )

    /// Torr - vacuum pressure unit
    public static let torr = Unit(
        name: "torr",
        symbol: "Torr",
        dimension: .pressure,
        toBaseUnit: 133.322368421,
        notes: "≈ 133.3 Pa ≈ 1 mmHg (vacuum systems)"
    )

    // MARK: - Speed

    /// Meters per second - SI derived unit
    public static let metersPerSecond = Unit(
        name: "meters per second",
        symbol: "m/s",
        dimension: .speed,
        toBaseUnit: 1.0,
        notes: "SI derived unit"
    )

    /// Kilometers per hour
    public static let kilometersPerHour = Unit(
        name: "kilometers per hour",
        symbol: "km/h",
        dimension: .speed,
        toBaseUnit: 1.0 / 3.6,
        notes: "≈ 0.278 m/s"
    )

    /// Miles per hour
    public static let milesPerHour = Unit(
        name: "miles per hour",
        symbol: "mph",
        dimension: .speed,
        toBaseUnit: 0.44704,
        notes: "= 0.44704 m/s"
    )

    /// Knot - maritime and aviation speed
    public static let knot = Unit(
        name: "knot",
        symbol: "kn",
        dimension: .speed,
        toBaseUnit: 0.514444444,
        notes: "≈ 0.514 m/s = 1 nmi/h"
    )

    /// Speed of light in vacuum
    public static let speedOfLight = Unit(
        name: "speed of light",
        symbol: "c",
        dimension: .speed,
        toBaseUnit: 299_792_458.0,
        notes: "= 299,792,458 m/s (exact)"
    )

    /// Mach - speed relative to speed of sound
    public static let mach = Unit(
        name: "Mach",
        symbol: "Ma",
        dimension: .speed,
        toBaseUnit: 343.0,
        notes: "≈ 343 m/s at sea level (speed of sound)"
    )

    // MARK: - Temperature

    /// Kelvin - SI base unit of temperature
    public static let kelvin = Unit(
        name: "kelvin",
        symbol: "K",
        dimension: .temperature,
        toBaseUnit: 1.0,
        notes: "SI base unit (absolute scale)"
    )

    // Note: Celsius and Fahrenheit require offset conversions, not just multiplication
    // These are simplified - proper temperature conversion needs special handling
}
