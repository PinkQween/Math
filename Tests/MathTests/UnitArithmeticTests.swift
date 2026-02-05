//
//  UnitArithmeticTests.swift
//  Math
//
//  Created by Hanna Skairipa on 2/4/26.
//

import Testing
@testable import Math

@Suite("Unit Arithmetic")
struct UnitArithmeticTests {

    @Test("Area times length simplifies to volume")
    func testAreaTimesLengthSimplifiesToVolume() async throws {
        let area = MathUnit(Math(2), StandardUnits.squareMeter)
        let length = MathUnit(Math(3), StandardUnits.meter)
        let volume = area * length

        #expect(volume != nil)
        #expect(volume!.unit == StandardUnits.cubicMeter)
        #expect(volume!.value == Math(6))
    }

    @Test("Length times length simplifies to area with base units")
    func testLengthTimesLengthSimplifiesToArea() async throws {
        let a = MathUnit(Math(200), StandardUnits.centimeter)
        let b = MathUnit(Math(300), StandardUnits.centimeter)
        let area = a * b

        #expect(area != nil)
        #expect(area!.unit == StandardUnits.squareMeter)
        #expect(area!.value == Math(6))
    }

    @Test("Length divided by time simplifies to speed")
    func testLengthDividedByTimeSimplifiesToSpeed() async throws {
        let distance = MathUnit(Math(10), StandardUnits.meter)
        let time = MathUnit(Math(2), StandardUnits.second)
        let speed = distance / time

        #expect(speed != nil)
        #expect(speed!.unit == StandardUnits.meterPerSecond)
        #expect(speed!.value == Math(5))
    }

    @Test("Power from base units simplifies to watt")
    func testPowerSimplifiesToWatt() async throws {
        let energy = MathUnit(Math(10), StandardUnits.joule)
        let time = MathUnit(Math(2), StandardUnits.second)
        let power = energy / time

        #expect(power != nil)
        #expect(power!.unit == StandardUnits.watt)
        #expect(power!.value == Math(5))
    }

    @Test("Force equals mass times acceleration")
    func testForceFromMassAndAcceleration() async throws {
        let mass = MathUnit(Math(10), StandardUnits.kilogram)
        let accel = MathUnit(Math(2), StandardUnits.meterPerSecondSquared)
        let force = mass * accel

        #expect(force != nil)
        #expect(force!.unit == StandardUnits.newton)
        #expect(force!.value == Math(20))
    }

    @Test("Weight equals mass times standard gravity")
    func testWeightFromMassAndGravity() async throws {
        let mass = MathUnit(Math(1), StandardUnits.kilogram)
        let g = MathUnit(Math(9.80665), StandardUnits.meterPerSecondSquared)
        let weight = mass * g

        #expect(weight != nil)
        #expect(weight!.unit == StandardUnits.newton)
        #expect(weight!.value == Math(9.80665))
    }

    @Test("Pressure equals force divided by area")
    func testPressureFromForceAndArea() async throws {
        let force = MathUnit(Math(10), StandardUnits.newton)
        let area = MathUnit(Math(2), StandardUnits.squareMeter)
        let pressure = force / area

        #expect(pressure != nil)
        #expect(pressure!.unit == StandardUnits.pascal)
        #expect(pressure!.value == Math(5))
    }

    @Test("Energy equals power times time")
    func testEnergyFromPowerAndTime() async throws {
        let power = MathUnit(Math(3), StandardUnits.watt)
        let time = MathUnit(Math(4), StandardUnits.second)
        let energy = power * time

        #expect(energy != nil)
        #expect(energy!.unit == StandardUnits.joule)
        #expect(energy!.value == Math(12))
    }

    @Test("Density equals mass divided by volume")
    func testDensityFromMassAndVolume() async throws {
        let mass = MathUnit(Math(1), StandardUnits.kilogram)
        let volume = MathUnit(Math(2), StandardUnits.cubicMeter)
        let density = mass / volume

        #expect(density != nil)
        #expect(density!.unit == StandardUnits.kilogramPerCubicMeter)
        #expect(density!.value == Math(0.5))
    }

    @Test("Temperature arithmetic is rejected for offset units")
    func testOffsetUnitMultiplicationRejected() async throws {
        let t = MathUnit(Math(20), StandardUnits.celsius)
        let length = MathUnit(Math(2), StandardUnits.meter)
        let result = t * length

        #expect(result == nil)
    }

    @Test("Pow simplifies to area")
    func testPowSimplifiesToArea() async throws {
        let length = MathUnit(Math(2), StandardUnits.meter)
        let area = length.pow(2)

        #expect(area != nil)
        #expect(area!.unit == StandardUnits.squareMeter)
        #expect(area!.value == Math(4))
    }
}
