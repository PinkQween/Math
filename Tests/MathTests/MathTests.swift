import Testing
@testable import Math

// MARK: - Foundational Math Tests
@Suite("Foundational Math")
struct FoundationalMathTests {
    
    @Test
    func equate() async throws {
        // Test basic equality between two identical Math values
        let a: Math = 1
        let b: Math = 1
        
        #expect(a == b)
    }
    
    @Test
    func notEquate() async throws {
        // Test inequality between two different Math values
        let a: Math = 1
        let b: Math = 2
        
        #expect(a != b)
    }
    
    @Test
    func lessThan() async throws {
        // Test less-than comparison
        let a: Math = 1
        let b: Math = 2
        
        #expect(a < b)
    }
    
    @Test
    func lessThanOrEqualTo() async throws {
        // Test less-than-or-equal-to comparison
        let a: Math = 1
        let b: Math = 2
        
        #expect(a <= b)
    }
    
    @Test
    func greaterThan() async throws {
        // Test greater-than comparison
        let a: Math = 2
        let b: Math = 1
        
        #expect(a > b)
    }
    
    @Test
    func greaterThanOrEqualTo() async throws {
        // Test greater-than-or-equal-to comparison
        let a: Math = 2
        let b: Math = 1
        
        #expect(a >= b)
    }
}

// MARK: - Tests for Very Large Exponentiation
@Suite("Exponentially Large Math")
struct ExponentiallyLargeMathTests {
    
    @Test
    func exponentiation() async throws {
        // Test standard exponentiation (2^3 == 8)
        let a: Math = 2
        let b: Math = 3
        
        #expect(a ** b == 8)
    }
    
    @Test
    func tetration() async throws {
        // Test tetration (2^^4 == 65536)
        let a: Math = 2
        let b: Math = 4
        
        #expect(a ^^ b == 65536)
    }
    
    // Future note: Higher tetration results may exceed current computational limits
}

// MARK: - Root Calculations
@Suite("Roots")
struct RootTests {
    
    @Test
    func SquareRoot() async throws {
        // Test square root calculation
        // Note: Using high precision settings to avoid floating-point inaccuracies
        #expect(Calculate(settings: .init(angleMode: .degrees, precision: 1000)) { 2 |/ 2 } == 1.414213562373095)
    }
}

// MARK: - Geometry Tests (Commented Out)
/*
@Suite("Geometry")
struct GeometryTests {
    
    @Test func sin() async throws {
        // Test sine function for 45 degrees
        // Expected result: 1 / sqrt(2)
        print(Double(1 / (2 |/ 2)))
        print(1 / 2 |/ 2 == 0.7071067812)
        
        #expect(Calculate(settings: .init(angleMode: .degrees, precision: 1000)) {
            Math.sin(45)
        } == (1 / 2 |/ 2))
    }
    
    @Test func asin() async throws {
        // Test arcsine function for value 1 / sqrt(2)
        // Expected result: 45 degrees
        #expect(Calculate(settings: .init(angleMode: .degrees, precision: 1000)) {
            Math.asin(1 / 2 |/ 2)
        } == 45 as Math)
    }
}
*/
