//
//  AdvancedOperationsTests.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Testing
@testable import Math

// MARK: - Exponentiation & Hyperoperations

@Suite("Advanced Operations")
struct AdvancedOperationsTests {

    @Test("Exponentiation")
    func testExponentiation() async throws {
        #expect(Math(2) ** Math(3) == 8)
        #expect(Math(3) ** Math(4) == 81)
        #expect(Math(10) ** Math(2) == 100)
    }

    @Test("Tetration")
    func testTetration() async throws {
        #expect(Math(2) ^^ Math(3) == 16)  // 2^2^2 = 2^4 = 16
        #expect(Math(2) ^^ Math(2) == 4)   // 2^2 = 4
    }

    @Test("Square root")
    func testSquareRoot() async throws {
        let result = Calculate(settings: .init(angleMode: .degrees, precision: 1000)) {
            Math(4) |/ Math(2)
        }
        #expect(result == 2)
    }

    @Test("Cube root")
    func testCubeRoot() async throws {
        let result = Math(27) |/ Math(3)
        #expect(result == 3)
    }
}

// MARK: - Factorial Tests

@Suite("Factorials")
struct FactorialTests {

    @Test("Standard factorial")
    func testFactorial() async throws {
        #expect(Math(3)~! == 6)
        #expect(Math(5)~! == 120)
        #expect(Math(0)~! == 1)
    }

    @Test("Subfactorial")
    func testSubfactorial() async throws {
        #expect(~!Math(3) == 2)
        #expect(~!Math(4) == 9)
    }

    @Test("Double factorial")
    func testDoubleFactorial() async throws {
        #expect(Math(5)~!! == 15)  // 5*3*1
    }

    @Test("Triple factorial")
    func testTripleFactorial() async throws {
        #expect(Math(5)~!!! == 10)  // 5*2
    }
}
