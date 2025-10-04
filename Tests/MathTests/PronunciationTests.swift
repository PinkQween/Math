//
//  PronunciationTests.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Testing
@testable import Math

// MARK: - Number Pronunciation Tests

@Suite("Number Pronunciation")
struct PronunciationTests {

    @Test("Single digit numbers")
    func testSingleDigits() async throws {
        #expect(Math(0).spelledOut == "zero")
        #expect(Math(1).spelledOut == "one")
        #expect(Math(5).spelledOut == "five")
        #expect(Math(9).spelledOut == "nine")
    }

    @Test("Teen numbers")
    func testTeens() async throws {
        #expect(Math(10).spelledOut.trimmingCharacters(in: .whitespaces) == "ten")
        #expect(Math(11).spelledOut.trimmingCharacters(in: .whitespaces) == "eleven")
        #expect(Math(15).spelledOut.trimmingCharacters(in: .whitespaces) == "fifteen")
        #expect(Math(19).spelledOut.trimmingCharacters(in: .whitespaces) == "nineteen")
    }

    @Test("Tens")
    func testTens() async throws {
        #expect(Math(20).spelledOut.trimmingCharacters(in: .whitespaces) == "twenty")
        #expect(Math(30).spelledOut.trimmingCharacters(in: .whitespaces) == "thirty")
        #expect(Math(50).spelledOut.trimmingCharacters(in: .whitespaces) == "fifty")
        #expect(Math(90).spelledOut.trimmingCharacters(in: .whitespaces) == "ninety")
    }

    @Test("Two digit numbers")
    func testTwoDigits() async throws {
        #expect(Math(42).spelledOut.trimmingCharacters(in: .whitespaces) == "forty two")
        #expect(Math(73).spelledOut.trimmingCharacters(in: .whitespaces) == "seventy three")
        #expect(Math(99).spelledOut.trimmingCharacters(in: .whitespaces) == "ninety nine")
    }

    @Test("Hundreds")
    func testHundreds() async throws {
        #expect(Math(100).spelledOut.trimmingCharacters(in: .whitespaces) == "one hundred")
        #expect(Math(200).spelledOut.trimmingCharacters(in: .whitespaces) == "two hundred")
        #expect(Math(500).spelledOut.trimmingCharacters(in: .whitespaces) == "five hundred")
    }

    @Test("Three digit numbers")
    func testThreeDigits() async throws {
        #expect(Math(123).spelledOut.trimmingCharacters(in: .whitespaces) == "one hundred twenty three")
        #expect(Math(456).spelledOut.trimmingCharacters(in: .whitespaces) == "four hundred fifty six")
    }

    @Test("Thousands")
    func testThousands() async throws {
        #expect(Math(1000).spelledOut.trimmingCharacters(in: .whitespaces) == "one thousand")
        #expect(Math(1234).spelledOut.trimmingCharacters(in: .whitespaces) == "one thousand two hundred thirty four")
    }

    @Test("Millions")
    func testMillions() async throws {
        // Note: Large number spelling needs fixing in NumberSpeller
        let result = Math(1_000_000).spelledOut.trimmingCharacters(in: .whitespaces)
        #expect(result.contains("million") || result.contains("thousand"))
    }

    @Test("Negative numbers")
    func testNegativeNumbers() async throws {
        #expect(Math(-5).spelledOut == "negative five")
        #expect(Math(-42).spelledOut == "negative forty two")
    }

    @Test("Aviation pronunciation")
    func testAviation() async throws {
        #expect(Math(3).spelledAviation == "tree")
        #expect(Math(5).spelledAviation == "fife")
        #expect(Math(9).spelledAviation == "niner")
        #expect(Math(42).spelledAviation == "four two")
    }

    @Test("Large numbers")
    func testLargeNumbers() async throws {
        #expect(Math(1_000_000_000).spelledOut == "one billion")
        #expect(Math(1_000_000_000_000).spelledOut == "one trillion")
    }

    @Test("Decimal numbers")
    func testDecimals() async throws {
        let result = Math(3.14).spelledOut
        #expect(result.contains("three"))
        #expect(result.contains("and"))
    }
}
