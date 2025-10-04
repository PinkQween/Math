//
//  UnitConversionTests.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Testing
@testable import Math

// MARK: - Basic Unit Conversion Tests

@Suite("Unit Conversion")
struct UnitConversionTests {

    // MARK: - Length Conversions

    @Test("Convert meters to kilometers")
    func testMetersToKilometers() async throws {
        let meters = MathUnit(Math(1000), StandardUnits.meter)
        let kilometers = StandardUnits.meter.convertWithinDimension(meters, to: StandardUnits.kilometer)

        #expect(kilometers != nil)
        #expect(kilometers!.value == Math(1))
    }

    @Test("Convert feet to meters")
    func testFeetToMeters() async throws {
        let feet = MathUnit(Math(10), StandardUnits.foot)
        let meters = StandardUnits.foot.convertWithinDimension(feet, to: StandardUnits.meter)

        #expect(meters != nil)
        #expect(meters!.value == Math(3.048))
    }

    @Test("Convert inches to centimeters")
    func testInchesToCentimeters() async throws {
        let inches = MathUnit(Math(1), StandardUnits.inch)
        let centimeters = StandardUnits.inch.convertWithinDimension(inches, to: StandardUnits.centimeter)

        #expect(centimeters != nil)
        #expect(centimeters!.value == Math(2.54))
    }

    // MARK: - Mass Conversions

    @Test("Convert kilograms to grams")
    func testKilogramsToGrams() async throws {
        let kilograms = MathUnit(Math(1), StandardUnits.kilogram)
        let grams = StandardUnits.kilogram.convertWithinDimension(kilograms, to: StandardUnits.gram)

        #expect(grams != nil)
        #expect(grams!.value == Math(1000))
    }

    // MARK: - Time Conversions

    @Test("Convert hours to seconds")
    func testHoursToSeconds() async throws {
        let hours = MathUnit(Math(1), StandardUnits.hour)
        let seconds = StandardUnits.hour.convertWithinDimension(hours, to: StandardUnits.second)

        #expect(seconds != nil)
        #expect(seconds!.value == Math(3600))
    }

    @Test("Convert days to hours")
    func testDaysToHours() async throws {
        let days = MathUnit(Math(1), StandardUnits.day)
        let hours = StandardUnits.day.convertWithinDimension(days, to: StandardUnits.hour)

        #expect(hours != nil)
        #expect(hours!.value == Math(24))
    }

    @Test("Convert milliseconds to seconds")
    func testMillisecondsToSeconds() async throws {
        let milliseconds = MathUnit(Math(1000), StandardUnits.millisecond)
        let seconds = StandardUnits.millisecond.convertWithinDimension(milliseconds, to: StandardUnits.second)

        #expect(seconds != nil)
        #expect(seconds!.value == Math(1))
    }

    // MARK: - Area Conversions

    @Test("Convert square meters to square kilometers")
    func testSquareMetersToSquareKilometers() async throws {
        let squareMeters = MathUnit(Math(1_000_000), StandardUnits.squareMeter)
        let squareKilometers = StandardUnits.squareMeter.convertWithinDimension(squareMeters, to: StandardUnits.squareKilometer)

        #expect(squareKilometers != nil)
        #expect(squareKilometers!.value == Math(1))
    }

    // MARK: - Volume Conversions

    @Test("Convert liters to milliliters")
    func testLitersToMilliliters() async throws {
        let liters = MathUnit(Math(1), StandardUnits.liter)
        let milliliters = StandardUnits.liter.convertWithinDimension(liters, to: StandardUnits.milliliter)

        #expect(milliliters != nil)
        #expect(milliliters!.value == Math(1000))
    }

    // MARK: - Cross-dimension Rejection

    @Test("Reject conversion between incompatible dimensions")
    func testIncompatibleDimensions() async throws {
        let meters = MathUnit(Math(100), StandardUnits.meter)
        let kilograms = StandardUnits.meter.convertWithinDimension(meters, to: StandardUnits.kilogram)

        #expect(kilograms == nil)
    }

    // MARK: - Temperature Conversions

    @Test("Convert Celsius to Fahrenheit")
    func testCelsiusToFahrenheit() async throws {
        let celsius = MathUnit(Math(0), StandardUnits.celsius)
        let fahrenheit = StandardUnits.celsius.convertWithinDimension(celsius, to: StandardUnits.fahrenheit)

        #expect(fahrenheit != nil)
        // 0°C = 32°F
        let diff = abs(Double(fahrenheit!.value - Math(32)))
        #expect(diff < 0.001)
    }

    @Test("Convert Fahrenheit to Celsius")
    func testFahrenheitToCelsius() async throws {
        let fahrenheit = MathUnit(Math(212), StandardUnits.fahrenheit)
        let celsius = StandardUnits.fahrenheit.convertWithinDimension(fahrenheit, to: StandardUnits.celsius)

        #expect(celsius != nil)
        // 212°F = 100°C
        let diff = abs(Double(celsius!.value - Math(100)))
        #expect(diff < 0.001)
    }

    // MARK: - Speed Conversions

    @Test("Convert km/h to mph")
    func testKilometersPerHourToMilesPerHour() async throws {
        let kmh = MathUnit(Math(100), StandardUnits.kilometersPerHour)
        let mph = StandardUnits.kilometersPerHour.convertWithinDimension(kmh, to: StandardUnits.milesPerHour)

        #expect(mph != nil)
        // 100 km/h ≈ 62.137 mph
        let diff = abs(Double(mph!.value - Math(62.137)))
        #expect(diff < 0.01)
    }

    // MARK: - Data Storage Conversions

    @Test("Convert MB to GB")
    func testMegabytesToGigabytes() async throws {
        let megabytes = MathUnit(Math(1000), StandardUnits.megabyte)
        let gigabytes = StandardUnits.megabyte.convertWithinDimension(megabytes, to: StandardUnits.gigabyte)

        #expect(gigabytes != nil)
        #expect(gigabytes!.value == Math(1))
    }

    @Test("Convert GiB to bytes")
    func testGibibytesToBytes() async throws {
        let gibibytes = MathUnit(Math(1), StandardUnits.gibibyte)
        let bytes = StandardUnits.gibibyte.convertWithinDimension(gibibytes, to: StandardUnits.byte)

        #expect(bytes != nil)
        #expect(bytes!.value == Math(1_073_741_824))
    }

    // MARK: - Pressure Conversions

    @Test("Convert atmospheres to PSI")
    func testAtmospheresToPSI() async throws {
        let atm = MathUnit(Math(1), StandardUnits.atmosphere)
        let psi = StandardUnits.atmosphere.convertWithinDimension(atm, to: StandardUnits.psi)

        #expect(psi != nil)
        // 1 atm = 101325 Pa / 6894.757 Pa/psi ≈ 14.696 psi
        let expected = Math(101325.0) / Math(6894.757293168)
        let diff = abs(Double(psi!.value - expected))
        #expect(diff < 0.1)
    }

    // MARK: - Energy Conversions

    @Test("Convert kWh to joules")
    func testKilowattHoursToJoules() async throws {
        let kwh = MathUnit(Math(1), StandardUnits.kilowattHour)
        let joules = StandardUnits.kilowattHour.convertWithinDimension(kwh, to: StandardUnits.joule)

        #expect(joules != nil)
        #expect(joules!.value == Math(3_600_000))
    }

    @Test("Convert calories to joules")
    func testCaloriesToJoules() async throws {
        let calories = MathUnit(Math(1), StandardUnits.calorie)
        let joules = StandardUnits.calorie.convertWithinDimension(calories, to: StandardUnits.joule)

        #expect(joules != nil)
        // 1 cal = 4.184 J
        #expect(joules!.value == Math(4.184))
    }

    // MARK: - Power Conversions

    @Test("Convert horsepower to watts")
    func testHorsepowerToWatts() async throws {
        let hp = MathUnit(Math(1), StandardUnits.horsepower)
        let watts = StandardUnits.horsepower.convertWithinDimension(hp, to: StandardUnits.watt)

        #expect(watts != nil)
        // 1 hp ≈ 745.7 W
        let diff = abs(Double(watts!.value - Math(745.7)))
        #expect(diff < 0.1)
    }

    // MARK: - Angle Conversions

    @Test("Convert degrees to radians")
    func testDegreesToRadians() async throws {
        let degrees = MathUnit(Math(180), StandardUnits.degree)
        let radians = StandardUnits.degree.convertWithinDimension(degrees, to: StandardUnits.radian)

        #expect(radians != nil)
        // 180° = π rad ≈ 3.14159
        let diff = abs(Double(radians!.value - Math(3.14159)))
        #expect(diff < 0.001)
    }
}
