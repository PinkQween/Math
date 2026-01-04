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
        guard let n = self.asInt, n > 3 else { return false }
        
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
        guard let n = self.asInt, n > 3 else { return false }
        
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
        guard let n = self.asInt, n > 3 else { return false }
        
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
    
    /// A Boolean value indicating whether this number is a
    /// *lucky number* according to the Josephus Flavius sieve.
    ///
    /// Lucky numbers are defined by repeatedly removing numbers
    /// from the natural numbers sequence using the following
    /// sieve process:
    ///
    /// 1. Start with the positive integers: 1, 2, 3, 4, 5, ...
    /// 2. Remove every 2nd number, leaving 1, 3, 5, 7, 9, ...
    /// 3. The next surviving number is 3, so remove every 3rd
    ///    number, leaving 1, 3, 7, 9, 13, 15, ...
    /// 4. The next surviving number is 7, so remove every 7th
    ///    number.
    /// 5. Continue this process indefinitely.
    ///
    /// The resulting sequence is:
    /// `1, 3, 7, 9, 13, 15, 21, 25, 31, 33, ...`
    ///
    /// ### Example
    ///
    /// ```swift
    /// Math(7).isLucky      // true
    /// Math(8).isLucky      // false
    /// Math(13).isLucky     // true
    /// ```
    ///
    /// Lucky numbers share some similarities with primes, but
    /// arise from a distinct sieving process.
    ///
    /// - Returns: `true` if this number is lucky, otherwise `false`.
    var isLucky: Bool {
        let n = Int(self.description) ?? 0
        guard n > 0 else { return false }
        if n == 1 { return true }
        if n % 2 == 0 { return false }
        
        // Start with position in odd numbers sequence
        var pos = (n + 1) / 2
        
        // Apply sieve steps
        var step = 3
        var removed = 1
        
        while step <= pos {
            // Check if current position would be removed at this step
            if pos % step == 0 {
                return false
            }
            
            // Adjust position for already removed numbers
            let removedAtThisStep = (pos - removed) / step
            removed += removedAtThisStep
            pos -= removedAtThisStep
            
            // Move to next step (next lucky number position)
            // Calculate next lucky position after sieving
            var nextStep = step + 1
            var tempPos = (nextStep * 2 - 1 + 1) / 2
            
            // Find next position that survives all previous sieves
            while true {
                var survives = true
                var checkStep = 3
                var checkRemoved = 1
                
                while checkStep < nextStep && survives {
                    if tempPos % checkStep == 0 {
                        survives = false
                        break
                    }
                    let removedAtCheck = (tempPos - checkRemoved) / checkStep
                    checkRemoved += removedAtCheck
                    tempPos -= removedAtCheck
                    
                    checkStep += 2
                    while checkStep < nextStep {
                        let testPos = (checkStep * 2 - 1 + 1) / 2
                        var testSurvives = true
                        var innerCheckStep = 3
                        var innerRemoved = 1
                        
                        while innerCheckStep < checkStep && testSurvives {
                            if testPos % innerCheckStep == 0 {
                                testSurvives = false
                                break
                            }
                            let innerRemovedAtCheck = (testPos - innerRemoved) / innerCheckStep
                            innerRemoved += innerRemovedAtCheck
                            innerCheckStep = innerCheckStep == 3 ? 7 : innerCheckStep + 2
                        }
                        
                        if testSurvives {
                            break
                        }
                        checkStep += 2
                    }
                }
                
                if survives {
                    step = nextStep * 2 - 1
                    break
                }
                nextStep += 1
                tempPos = (nextStep * 2 - 1 + 1) / 2
            }
        }
        
        return true
    }

    
    /// Returns `true` if this number is a palindromic number.
    ///
    /// A *palindromic number* is a number that reads the same
    /// forwards and backwards.
    ///
    /// ### Examples
    ///
    /// ```swift
    /// Math(121).isPalindromic   // true   ("121")
    /// Math(1331).isPalindromic  // true   ("1331")
    /// Math(123).isPalindromic   // false  ("321")
    /// ```
    ///
    /// - Returns: `true` if this number is palindromic, otherwise `false`.
    var isPalindromic: Bool {
        let s = self.description
        return s == String(s.reversed())
    }
    
    /// Returns `true` if this number is automorphic.
    ///
    /// A number n is automorphic if n^2 ends with the same digits as n.
    /// Examples: 1 (1^2=1), 5 (25), 6 (36), 25 (625), 76 (5776)
    var isAutomorphic: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let square = n * n
        let nStr = String(n)
        let sStr = String(square)
        return sStr.hasSuffix(nStr)
    }

    /// Returns `true` if this number is a Kaprekar number.
    ///
    /// For base 10, a Kaprekar number n has the property that there exists a split of n^2
    /// into two parts that sum to n. The right part must have the same number of digits as n,
    /// but this implementation checks all possible splits.
    ///
    /// Examples: 1, 9, 45, 55, 99, 297, 703, 999 ...
    var isKaprekar: Bool {
        guard let n = self.asInt, n > 0 else { return false }
        let sq = n * n
        let s = String(sq)
        // Try all split positions
        for i in 1...s.count { // split after i characters from left
            let leftStr = String(s.prefix(i))
            let rightStr = String(s.suffix(s.count - i))
            let left = Int(leftStr) ?? 0
            let right = Int(rightStr) ?? 0
            if right > 0 && left + right == n { return true }
            // Some definitions allow right == 0 for n == left; keep conservative above
        }
        // Handle the case n == 1 explicitly (1^2 = 1)
        return n == 1
    }

    /// Returns `true` if this number is a Smith number.
    ///
    /// A Smith number is a composite number for which the sum of its digits is equal to the
    /// sum of the digits in its prime factorization (counted with multiplicity).
    ///
    /// Examples: 4 (2+2 = 4), 22 (2+2 = 4; 22 digits 2+2=4), 27 (3+3+3 = 9; 27 digits 2+7=9)
    var isSmith: Bool {
        guard let n = self.asInt, n > 1 else { return false }
        // Smith numbers are composite
        guard !self.isPrime else { return false }
        let digitSumN = Self.digitSum(n)
        let factors = Self.primeFactors(of: n)
        let digitSumFactors = factors.reduce(0) { $0 + Self.digitSum($1) }
        return digitSumN == digitSumFactors
    }

    // MARK: - Helpers for Smith/Kaprekar/Automorphic

    /// Sum of decimal digits of a non-negative integer
    private static func digitSum(_ x: Int) -> Int {
        var n = abs(x)
        var sum = 0
        while n > 0 {
            sum += n % 10
            n /= 10
        }
        return sum
    }

    /// Returns the prime factors of `n` with multiplicity (for n > 1).
    private static func primeFactors(of n: Int) -> [Int] {
        var num = n
        var result: [Int] = []
        var d = 2
        while d * d <= num {
            while num % d == 0 {
                result.append(d)
                num /= d
            }
            d += (d == 2 ? 1 : 2) // check 2, then odd numbers
        }
        if num > 1 { result.append(num) }
        return result
    }
    
    /// Returns `true` if this number is pentagonal.
    ///
    /// A number n is pentagonal if n = k(3k − 1)/2 for some integer k ≥ 1.
    /// Test: (24n + 1) must be a perfect square and (1 + √(24n+1)) is divisible by 6.
    var isPentagonal: Bool {
        guard let n = self.asInt, n > 0 else { return false }
        let x = 24 * n + 1
        let r = Int(Double(x).squareRoot())
        guard r * r == x else { return false }
        return (1 + r) % 6 == 0
    }

    /// Returns `true` if this number is hexagonal.
    ///
    /// A number n is hexagonal if n = k(2k − 1) for some integer k ≥ 1.
    /// Test: (8n + 1) must be a perfect square and (1 + √(8n+1)) is divisible by 4.
    var isHexagonal: Bool {
        guard let n = self.asInt, n > 0 else { return false }
        let x = 8 * n + 1
        let r = Int(Double(x).squareRoot())
        guard r * r == x else { return false }
        return (1 + r) % 4 == 0
    }

    /// Returns `true` if this number is ugly (its prime factors are only 2, 3, and 5).
    var isUgly: Bool {
        guard let n0 = self.asInt, n0 > 0 else { return false }
        var n = n0
        for p in [2, 3, 5] {
            while n % p == 0 { n /= p }
        }
        return n == 1
    }

    /// Returns `true` if this number is pronic (rectangular): n = k(k+1).
    var isPronic: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let k = Int(Double(n).squareRoot())
        return k * (k + 1) == n || (k - 1) * k == n
    }

    /// Returns `true` if this number is a duck number (contains a zero digit, not counting leading zeros).
    var isDuck: Bool {
        var s = self.description
        if s.first == "-" { s.removeFirst() }
        guard !s.isEmpty else { return false }
        while s.first == "0" { s.removeFirst() }
        return s.contains("0")
    }

    /// Returns `true` if this number is a buzz number (divisible by 7 or ends with 7).
    var isBuzz: Bool {
        guard let n = self.asInt else { return false }
        return n % 7 == 0 || abs(n) % 10 == 7
    }

    /// Returns `true` if this number is neon (sum of digits of n^2 equals n).
    var isNeon: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let sq = n * n
        var m = sq
        var sum = 0
        while m > 0 {
            sum += m % 10
            m /= 10
        }
        return sum == n
    }

    /// Returns `true` if this number is square-free (no squared prime divides it).
    /// 1 is considered square-free.
    var isSquareFree: Bool {
        guard let n0 = self.asInt, n0 > 0 else { return false }
        if n0 == 1 { return true }
        var n = n0
        var p = 2
        while p * p <= n {
            var count = 0
            while n % p == 0 {
                n /= p
                count += 1
                if count >= 2 { return false }
            }
            p += (p == 2 ? 1 : 2)
        }
        return true
    }

    /// Returns `true` if this number is powerful (for every prime factor p, p^2 divides n).
    /// 1 is considered powerful by convention.
    var isPowerful: Bool {
        guard let n0 = self.asInt, n0 > 0 else { return false }
        if n0 == 1 { return true }
        var n = n0
        var foundAny = false
        var p = 2
        while p * p <= n {
            var count = 0
            while n % p == 0 {
                n /= p
                count += 1
                foundAny = true
            }
            if count > 0 && count < 2 { return false }
            p += (p == 2 ? 1 : 2)
        }
        // If leftover n > 1, it is a prime factor with exponent 1
        if n > 1 { return false }
        return foundAny
    }

    /// Returns `true` if this number is sunny (n + 1 is a perfect square).
    var isSunny: Bool {
        return (self + 1).isSquare
    }

    /// Returns `true` if this number is trimorphic (n^3 ends with n).
    var isTrimorphic: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let cube = n * n * n
        return String(cube).hasSuffix(String(n))
    }

    /// Returns `true` if this number is a Disarium number.
    /// Sum of its digits powered with their positions equals the number.
    var isDisarium: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let s = String(n)
        var sum = 0
        for (i, ch) in s.enumerated() {
            if let d = Int(String(ch)) {
                sum += Int(pow(Double(d), Double(i + 1)))
            }
        }
        return sum == n
    }

    /// Returns `true` if this number is a Spy number (sum of digits equals product of digits).
    var isSpy: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        if n == 0 { return true } // digits: [0], sum=0, product=0
        var m = n
        var sum = 0
        var product = 1
        while m > 0 {
            let d = m % 10
            sum += d
            product *= d
            m /= 10
        }
        return sum == product
    }

    /// Returns `true` if this number is a perfect power: n = a^b with integers a > 1, b > 1.
    var isPerfectPower: Bool {
        guard let n = self.asInt, n > 1 else { return false }
        let maxBase = Int(Double(n).squareRoot())
        if maxBase < 2 { return false }
        for a in 2...maxBase {
            var value = a * a
            while value <= n {
                if value == n { return true }
                if value > n / a { break }
                value *= a
            }
        }
        return false
    }

    /// Returns `true` if this number is a prime power with exponent ≥ 2: n = p^k, k ≥ 2.
    var isPrimePower: Bool {
        guard let n = self.asInt, n > 1 else { return false }
        // Factorize n and ensure all prime factors are the same and exponent ≥ 2
        var num = n
        var p = 2
        var primeFactor: Int? = nil
        var exponent = 0
        while p * p <= num {
            while num % p == 0 {
                if let pf = primeFactor, pf != p { return false }
                primeFactor = p
                exponent += 1
                num /= p
            }
            p += (p == 2 ? 1 : 2)
        }
        if num > 1 {
            if let pf = primeFactor, pf != num { return false }
            primeFactor = num
            exponent += 1
        }
        return primeFactor != nil && exponent >= 2
    }

    /// Returns `true` if this number is a factorion (Krishnamurthy number):
    /// the sum of the factorials of its digits equals the number.
    /// Examples: 1, 2, 145, 40585
    var isFactorion: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        var m = n
        var sum = 0
        while m > 0 {
            let d = m % 10
            sum += Math.factorialDigitLookup[d]
            m /= 10
        }
        if n == 0 { return Math.factorialDigitLookup[0] == 0 } // 0! = 1, so 0 is not a factorion
        return sum == n
    }

    /// Alias for `isNarcissistic`.
    var isArmstrong: Bool { self.isNarcissistic }

    /// Returns `true` if this number is a palindrome in binary representation.
    var isBinaryPalindromic: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let s = String(n, radix: 2)
        return s == String(s.reversed())
    }

    /// Returns `true` if this number is a palindrome in hexadecimal representation.
    var isHexPalindromic: Bool {
        guard let n = self.asInt, n >= 0 else { return false }
        let s = String(n, radix: 16)
        return s == String(s.reversed())
    }

    /// Returns `true` if this number is tetrahedral: n = k(k+1)(k+2)/6 for some k ≥ 1.
    var isTetrahedral: Bool {
        guard let n = self.asInt, n > 0 else { return false }
        var k = 1
        while true {
            let value = k * (k + 1) * (k + 2) / 6
            if value == n { return true }
            if value > n { return false }
            k += 1
        }
    }

    /// Returns `true` if this number is a centered square number: n = 1 + 4*T(k).
    var isCenteredSquare: Bool {
        guard let n = self.asInt, n > 0 else { return false }
        let diff = n - 1
        guard diff % 4 == 0 else { return false }
        let t = Math(integerLiteral: diff / 4)
        return t.isTriangular
    }

    /// Returns `true` if this number is a power of three.
    var isPowerOfThree: Bool {
        guard let n0 = self.asInt, n0 > 0 else { return false }
        var n = n0
        while n % 3 == 0 { n /= 3 }
        return n == 1
    }

    /// Returns `true` if this number is a power of five.
    var isPowerOfFive: Bool {
        guard let n0 = self.asInt, n0 > 0 else { return false }
        var n = n0
        while n % 5 == 0 { n /= 5 }
        return n == 1
    }

    // MARK: - Local helpers
    /// Precomputed factorials for digits 0...9
    private static let factorialDigitLookup: [Int] = {
        var f = [Int](repeating: 1, count: 10)
        for i in 2..<10 { f[i] = f[i - 1] * i }
        return f
    }()
}
