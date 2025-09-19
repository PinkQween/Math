import Testing
@testable import Math

@Suite("Foundational Math")
struct FondationalMathTests {
    @Test
    func equate() async throws {
        let a: Math = 1
        let b: Math = 1
        
        #expect(a == b)
    }
    
    @Test
    func notEquate() async throws {
        let a: Math = 1
        let b: Math = 2
        
        #expect(a != b)
    }
    
    @Test
    func lessThan() async throws {
        let a: Math = 1
        let b: Math = 2
        
        #expect(a < b)
    }
    
    @Test
    func lessThanOrEqualTo() async throws {
        let a: Math = 1
        let b: Math = 2
        
        #expect(a <= b)
    }
    
    @Test
    func greaterThan() async throws {
        let a: Math = 2
        let b: Math = 1
        
        #expect(a > b)
    }
    
    @Test
    func greaterThanOrEqualTo() async throws {
        let a: Math = 2
        let b: Math = 1
        
        #expect(a >= b)
    }
}

@Suite("Exponentialy Large Math")
struct ExponentialyLargeMathTests {
    @Test
    func exponentiation() async throws {
        let a: Math = 2
        let b: Math = 3
        
        #expect(a ** b ==  8)
    }
    
    @Test
    func tetration() async throws {
        let a: Math = 2
        let b: Math = 4
        
        #expect(a ^^ b == 65536)
    }
    
    // at this point it is too large to compute
}
