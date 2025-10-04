//
//  MatrixTests.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Testing
@testable import Math

// MARK: - Matrix Tests

@Suite("Matrix Operations")
struct MatrixTests {

    @Test("Matrix addition")
    func testAddition() async throws {
        let a = Matrix(rows: 2, columns: 2, initialValue: 2)
        let b = Matrix(rows: 2, columns: 2, initialValue: 3)
        let result = a + b

        #expect(result == Matrix(rows: 2, columns: 2, initialValue: 5))
    }

    @Test("Matrix subtraction")
    func testSubtraction() async throws {
        let a = Matrix(rows: 2, columns: 2, initialValue: 5)
        let b = Matrix(rows: 2, columns: 2, initialValue: 2)
        let result = a - b

        #expect(result == Matrix(rows: 2, columns: 2, initialValue: 3))
    }

    @Test("Matrix multiplication")
    func testMultiplication() async throws {
        let a = Matrix(rows: 2, columns: 2, initialValue: 2)
        let b = Matrix(rows: 2, columns: 2, initialValue: 2)
        let result = a * b

        #expect(result == Matrix(rows: 2, columns: 2, initialValue: 8))
    }

    @Test("Matrix element access")
    func testElementAccess() async throws {
        var matrix = Matrix(rows: 3, columns: 3, initialValue: 0)
        matrix[0, 0] = 1
        matrix[1, 1] = 5
        matrix[2, 2] = 9

        #expect(matrix[0, 0] == 1)
        #expect(matrix[1, 1] == 5)
        #expect(matrix[2, 2] == 9)
        #expect(matrix[0, 1] == 0)
    }

    @Test("Matrix equality")
    func testEquality() async throws {
        let a = Matrix(rows: 2, columns: 2, initialValue: 7)
        let b = Matrix(rows: 2, columns: 2, initialValue: 7)
        let c = Matrix(rows: 2, columns: 2, initialValue: 3)

        #expect(a == b)
        #expect(a != c)
    }
}
