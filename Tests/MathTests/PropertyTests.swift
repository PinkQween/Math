//
//  PropertyTests.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Testing
@testable import Math

// MARK: - Basic Property Tests

@Suite("Basic Properties")
struct BasicPropertyTests {

    @Test("Parity detection")
    func testParity() async throws {
        #expect(Math(0).getParity == .even)
        #expect(Math(1).getParity == .odd)
        #expect(Math(2).getParity == .even)
        #expect(Math(42).getParity == .even)
        #expect(Math(17).getParity == .odd)
    }

    @Test("Sign detection")
    func testSign() async throws {
        #expect(Math(-5).getSign == .negative)
        #expect(Math(0).getSign == .zero)
        #expect(Math(5).getSign == .positive)
    }

    @Test("Is even")
    func testIsEven() async throws {
        #expect(Math(2).isEven)
        #expect(Math(42).isEven)
        #expect(!Math(3).isEven)
    }

    @Test("Is odd")
    func testIsOdd() async throws {
        #expect(Math(3).isOdd)
        #expect(Math(17).isOdd)
        #expect(!Math(4).isOdd)
    }

    @Test("Is zero")
    func testIsZero() async throws {
        #expect(Math(0).isZero)
        #expect(!Math(1).isZero)
    }

    @Test("Is positive")
    func testIsPositive() async throws {
        #expect(Math(5).isPositive)
        #expect(!Math(0).isPositive)
        #expect(!Math(-5).isPositive)
    }

    @Test("Is negative")
    func testIsNegative() async throws {
        #expect(Math(-5).isNegative)
        #expect(!Math(0).isNegative)
        #expect(!Math(5).isNegative)
    }
}

// MARK: - Prime Number Tests

@Suite("Prime Properties")
struct PrimePropertyTests {

    @Test("Basic primes")
    func testBasicPrimes() async throws {
        #expect(Math(2).isPrime)
        #expect(Math(3).isPrime)
        #expect(Math(5).isPrime)
        #expect(Math(7).isPrime)
        #expect(Math(11).isPrime)
        #expect(Math(13).isPrime)
        #expect(Math(17).isPrime)
        #expect(Math(19).isPrime)
    }

    @Test("Non-primes")
    func testNonPrimes() async throws {
        #expect(!Math(0).isPrime)
        #expect(!Math(1).isPrime)
        #expect(!Math(4).isPrime)
        #expect(!Math(6).isPrime)
        #expect(!Math(8).isPrime)
        #expect(!Math(9).isPrime)
        #expect(!Math(10).isPrime)
    }

    @Test("Composite numbers")
    func testComposite() async throws {
        #expect(Math(4).isComposite)
        #expect(Math(6).isComposite)
        #expect(Math(8).isComposite)
        #expect(!Math(7).isComposite)
    }

    @Test("Sophie Germain primes")
    func testSophieGermainPrimes() async throws {
        #expect(Math(2).isSophieGermainPrime)   // 2*2+1=5 is prime
        #expect(Math(3).isSophieGermainPrime)   // 2*3+1=7 is prime
        #expect(Math(5).isSophieGermainPrime)   // 2*5+1=11 is prime
        #expect(Math(11).isSophieGermainPrime)  // 2*11+1=23 is prime
    }

    @Test("Safe primes")
    func testSafePrimes() async throws {
        #expect(Math(5).isSafePrime)    // (5-1)/2=2 is prime
        #expect(Math(7).isSafePrime)    // (7-1)/2=3 is prime
        #expect(Math(11).isSafePrime)   // (11-1)/2=5 is prime
    }

    @Test("Twin primes")
    func testTwinPrimes() async throws {
        #expect(Math(3).isTwinPrime)    // 3 and 5 are twins
        #expect(Math(5).isTwinPrime)    // 3 and 5, or 5 and 7
        #expect(Math(11).isTwinPrime)   // 11 and 13 are twins
        #expect(Math(13).isTwinPrime)   // 11 and 13 are twins
    }

    @Test("Next and previous prime")
    func testPrimeNavigation() async throws {
        #expect(Math(7).nextPrime() == 11)
        #expect(Math(11).nextPrime() == 13)
        #expect(Math(13).previousPrime() == 11)
        #expect(Math(11).previousPrime() == 7)
    }
}

// MARK: - Special Number Tests

@Suite("Special Numbers")
struct SpecialNumberTests {

    @Test("Perfect numbers")
    func testPerfectNumbers() async throws {
        #expect(Math(6).isPerfect)      // 1+2+3=6
        #expect(Math(28).isPerfect)     // 1+2+4+7+14=28
        #expect(!Math(10).isPerfect)
    }

    @Test("Triangular numbers")
    func testTriangularNumbers() async throws {
        #expect(Math(1).isTriangular)   // 1
        #expect(Math(3).isTriangular)   // 1+2
        #expect(Math(6).isTriangular)   // 1+2+3
        #expect(Math(10).isTriangular)  // 1+2+3+4
        #expect(!Math(5).isTriangular)
    }

    @Test("Square numbers")
    func testSquareNumbers() async throws {
        #expect(Math(1).isSquare)
        #expect(Math(4).isSquare)
        #expect(Math(9).isSquare)
        #expect(Math(16).isSquare)
        #expect(!Math(5).isSquare)
    }

    @Test("Cube numbers")
    func testCubeNumbers() async throws {
        #expect(Math(1).isCube)
        #expect(Math(8).isCube)
        #expect(Math(27).isCube)
        #expect(!Math(10).isCube)
    }

    @Test("Fibonacci numbers")
    func testFibonacciNumbers() async throws {
        #expect(Math(0).isFibonacci)
        #expect(Math(1).isFibonacci)
        #expect(Math(2).isFibonacci)
        #expect(Math(3).isFibonacci)
        #expect(Math(5).isFibonacci)
        #expect(Math(8).isFibonacci)
        #expect(Math(13).isFibonacci)
        #expect(!Math(4).isFibonacci)
    }

    @Test("Palindrome numbers")
    func testPalindromeNumbers() async throws {
        #expect(Math(0).isPalindrome)
        #expect(Math(11).isPalindrome)
        #expect(Math(121).isPalindrome)
        #expect(Math(1331).isPalindrome)
        #expect(!Math(12).isPalindrome)
    }

    @Test("Happy numbers")
    func testHappyNumbers() async throws {
        #expect(Math(1).isHappy)
        #expect(Math(7).isHappy)
        #expect(Math(10).isHappy)
        #expect(!Math(2).isHappy)
    }

    @Test("Narcissistic numbers")
    func testNarcissisticNumbers() async throws {
        #expect(Math(0).isNarcissistic)
        #expect(Math(1).isNarcissistic)
        #expect(Math(153).isNarcissistic)  // 1³+5³+3³=153
        #expect(Math(370).isNarcissistic)  // 3³+7³+0³=370
        #expect(!Math(10).isNarcissistic)
    }

    @Test("Harshad numbers")
    func testHarshadNumbers() async throws {
        #expect(Math(1).isHarshad)
        #expect(Math(18).isHarshad)    // 18/(1+8)=2
        #expect(Math(21).isHarshad)    // 21/(2+1)=7
        #expect(!Math(11).isHarshad)
    }

    @Test("Powers of two")
    func testPowersOfTwo() async throws {
        #expect(Math(1).isPowerOfTwo)
        #expect(Math(2).isPowerOfTwo)
        #expect(Math(4).isPowerOfTwo)
        #expect(Math(8).isPowerOfTwo)
        #expect(Math(256).isPowerOfTwo)
        #expect(!Math(3).isPowerOfTwo)
    }

    @Test("Powers of ten")
    func testPowersOfTen() async throws {
        #expect(Math(1).isPowerOfTen)
        #expect(Math(10).isPowerOfTen)
        #expect(Math(100).isPowerOfTen)
        #expect(Math(1000).isPowerOfTen)
        #expect(!Math(20).isPowerOfTen)
    }
}
