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
}
