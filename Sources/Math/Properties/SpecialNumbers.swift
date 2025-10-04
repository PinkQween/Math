//
//  SpecialNumbers.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Special Number Classifications

public extension Math {
    /// Returns `true` if this number is a perfect number.
    ///
    /// A perfect number equals the sum of its proper divisors (divisors excluding itself).
    /// Examples: 6 = 1+2+3, 28 = 1+2+4+7+14, 496, 8128.
    var isPerfect: Bool {
        guard let n = self.asInt, n > 1 else { return false }

        var sum = 1
        let limit = Int(Double(n).squareRoot())

        for i in 2...limit {
            if n % i == 0 {
                sum += i
                if i != n / i {
                    sum += n / i
                }
            }
        }

        return sum == n
    }

    /// Returns `true` if this number is an abundant number.
    ///
    /// An abundant number is less than the sum of its proper divisors.
    /// Example: 12 < 1+2+3+4+6 = 16
    var isAbundant: Bool {
        guard let n = self.asInt, n > 1 else { return false }

        var sum = 1
        let limit = Int(Double(n).squareRoot())

        for i in 2...limit {
            if n % i == 0 {
                sum += i
                if i != n / i {
                    sum += n / i
                }
            }
        }

        return sum > n
    }

    /// Returns `true` if this number is a deficient number.
    ///
    /// A deficient number is greater than the sum of its proper divisors.
    /// Most numbers are deficient. Examples: 1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17...
    var isDeficient: Bool {
        guard let n = self.asInt, n > 1 else { return false }

        var sum = 1
        let limit = Int(Double(n).squareRoot())

        for i in 2...limit {
            if n % i == 0 {
                sum += i
                if i != n / i {
                    sum += n / i
                }
            }
        }

        return sum < n
    }

    /// Returns `true` if this number is a triangular number.
    ///
    /// Triangular numbers are the sum of first n natural numbers: 1, 3, 6, 10, 15, 21, 28, 36, 45...
    /// Formula: T(n) = n(n+1)/2
    var isTriangular: Bool {
        guard let n = self.asInt, n >= 0 else { return false }

        // A number is triangular if 8n+1 is a perfect square
        let candidate = 8 * n + 1
        let root = Int(Double(candidate).squareRoot())
        return root * root == candidate
    }

    /// Returns `true` if this number is a square number (perfect square).
    ///
    /// Square numbers are integers that are the square of an integer: 1, 4, 9, 16, 25, 36, 49, 64...
    var isSquare: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let root = Int(Double(n).squareRoot())
        return root * root == n
    }

    /// Returns `true` if this number is a cube number (perfect cube).
    ///
    /// Cube numbers are integers that are the cube of an integer: 1, 8, 27, 64, 125, 216...
    var isCube: Bool {
        guard let n = self.asInt else { return false }
        let absN = abs(n)
        let root = Int(round(pow(Double(absN), 1.0/3.0)))
        return root * root * root == absN
    }

    /// Returns `true` if this number is a Fibonacci number.
    ///
    /// Fibonacci sequence: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144...
    /// A number is Fibonacci if one of (5n²+4) or (5n²-4) is a perfect square.
    var isFibonacci: Bool {
        let n = self
        
        guard n >= 0, n.isInt else { return false }
        
        if n == 0 || n == 1 { return true }
        
        var a: Math = 0
        var b: Math = 1
        
        while b < n {
            let next = a + b
            a = b
            b = next
        }
        
        return b == n
    }

    /// Returns `true` if this number is a palindrome.
    ///
    /// A palindromic number reads the same forwards and backwards: 0, 1, 2...9, 11, 22, 101, 121, 1331...
    var isPalindrome: Bool {
        let str = self.description
        return str == String(str.reversed())
    }

    /// Returns `true` if this number is a happy number.
    ///
    /// A happy number eventually reaches 1 when replaced by the sum of squares of its digits repeatedly.
    /// Examples: 1, 7, 10, 13, 19, 23, 28, 31, 32, 44, 49, 68, 70, 79, 82, 86, 91, 94, 97, 100...
    var isHappy: Bool {
        guard let n = self.asInt, n > 0 else { return false }

        var seen = Set<Int>()
        var current = n

        while current != 1 && !seen.contains(current) {
            seen.insert(current)
            var sum = 0
            while current > 0 {
                let digit = current % 10
                sum += digit * digit
                current /= 10
            }
            current = sum
        }

        return current == 1
    }

    /// Returns `true` if this number is a narcissistic number (Armstrong number).
    ///
    /// A narcissistic number equals the sum of its digits each raised to the power of the number of digits.
    /// Examples: 0, 1, 2...9 (1 digit), 153 = 1³+5³+3³, 370, 371, 407, 1634, 8208, 9474...
    var isNarcissistic: Bool {
        guard let n = self.asInt, n >= 0 else { return false }

        let str = String(n)
        let power = str.count
        var sum = 0

        for char in str {
            if let digit = Int(String(char)) {
                sum += Int(pow(Double(digit), Double(power)))
            }
        }

        return sum == n
    }

    /// Returns `true` if this number is a Harshad number (Niven number).
    ///
    /// A Harshad number is divisible by the sum of its digits.
    /// Examples: 1, 2...10, 12, 18, 20, 21, 24, 27, 30, 36, 40, 42, 45, 48, 50...
    var isHarshad: Bool {
        guard let n = self.asInt, n > 0 else { return false }

        var sum = 0
        var temp = n

        while temp > 0 {
            sum += temp % 10
            temp /= 10
        }

        return sum > 0 && n % sum == 0
    }

    /// Returns `true` if this number is a Keith number.
    ///
    /// A Keith number generates a Fibonacci-like sequence starting with its digits,
    /// and the number itself appears in the sequence.
    /// Examples: 14, 19, 28, 47, 61, 75, 197, 742, 1104...
    var isKeith: Bool {
        guard let n = self.asInt, n >= 10 else { return false }

        let digits = String(n).compactMap { Int(String($0)) }
        var sequence = digits

        while sequence.last! < n {
            let next = sequence.suffix(digits.count).reduce(0, +)
            sequence.append(next)
        }

        return sequence.last! == n
    }

    /// Returns `true` if this is a power of 2.
    ///
    /// Powers of 2: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024...
    var isPowerOfTwo: Bool {
        guard let n = self.asInt, n > 0 else { return false }
        return (n & (n - 1)) == 0
    }

    /// Returns `true` if this is a power of 10.
    ///
    /// Powers of 10: 1, 10, 100, 1000, 10000...
    var isPowerOfTen: Bool {
        guard let n = self.asInt, n > 0 else { return false }
        var temp = n
        while temp % 10 == 0 {
            temp /= 10
        }
        return temp == 1
    }
}
