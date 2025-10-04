//
//  BasicOperationsTests.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Testing
@testable import Math

// MARK: - Foundational Math Tests

@Suite("Basic Operations")
struct BasicOperationsTests {

    @Test("Equality check")
    func testEquality() async throws {
        let a: Math = 1
        let b: Math = 1

        #expect(a == b)
    }

    @Test("Inequality check")
    func testInequality() async throws {
        let a: Math = 1
        let b: Math = 2

        #expect(a != b)
    }

    @Test("Less than comparison")
    func testLessThan() async throws {
        let a: Math = 1
        let b: Math = 2

        #expect(a < b)
    }

    @Test("Less than or equal comparison")
    func testLessThanOrEqual() async throws {
        let a: Math = 1
        let b: Math = 2

        #expect(a <= b)
        #expect(a <= a)
    }

    @Test("Greater than comparison")
    func testGreaterThan() async throws {
        let a: Math = 2
        let b: Math = 1

        #expect(a > b)
    }

    @Test("Greater than or equal comparison")
    func testGreaterThanOrEqual() async throws {
        let a: Math = 2
        let b: Math = 1

        #expect(a >= b)
        #expect(a >= a)
    }

    @Test("Addition")
    func testAddition() async throws {
        #expect(Math(2) + Math(3) == 5)
        #expect(Math(100) + Math(200) == 300)
    }

    @Test("Subtraction")
    func testSubtraction() async throws {
        #expect(Math(5) - Math(3) == 2)
        #expect(Math(100) - Math(50) == 50)
    }

    @Test("Multiplication")
    func testMultiplication() async throws {
        #expect(Math(3) * Math(4) == 12)
        #expect(Math(7) * Math(8) == 56)
    }

    @Test("Division")
    func testDivision() async throws {
        #expect(Math(10) / Math(2) == 5)
        #expect(Math(100) / Math(4) == 25)
    }

    @Test("Modulo")
    func testModulo() async throws {
        #expect(Math(10) % Math(3) == 1)
        #expect(Math(17) % Math(5) == 2)
    }
}
