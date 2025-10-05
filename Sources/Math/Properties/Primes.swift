//
//  Primes.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Core Prime Properties

public extension Math {
    /// Returns `true` if this value is a prime number.
    ///
    /// A *prime number* is a positive integer greater than `1` whose only
    /// divisors are `1` and itself. This implementation performs trial
    /// division up to √n.
    ///
    /// - Returns: `true` if the value is prime; otherwise `false`.
    ///
    /// - Complexity: **O(√n)** in the value's magnitude.
    ///
    /// ### Examples
    ///
    /// ```swift
    /// Math(2).isPrime   // true
    /// Math(17).isPrime  // true
    /// Math(18).isPrime  // false
    /// ```
    var isPrime: Bool {
        guard let n = self.asInt else { return false }
        if n < 2 { return false }
        if n == 2 { return true }
        if n % 2 == 0 { return false }

        let limit = Int(Double(n).squareRoot())
        if limit < 3 { return true }

        for i in stride(from: 3, through: limit, by: 2) {
            if n % i == 0 { return false }
        }
        return true
    }

    /// Returns `true` if the value is composite (greater than 1 and not prime).
    ///
    /// - Returns: `true` if composite, otherwise `false`.
    var isComposite: Bool {
        guard let n = self.asInt else { return false }
        return n > 1 && !isPrime
    }

    /// The 1-based index of this number in the ordered sequence of primes,
    /// or `nil` if the number is not prime.
    ///
    /// Example:
    /// `2 -> 1`, `3 -> 2`, `5 -> 3`, `7 -> 4`.
    ///
    /// - Returns: A `Math` representing the prime index, or `nil`.
    var primeIndex: Math? {
        guard self.isPrime, let n = self.asInt else { return nil }

        var count = 0
        var candidate = 2
        while candidate <= n {
            if Math(integerLiteral: candidate).isPrime {
                count += 1
                if candidate == n { return Math(integerLiteral: count) }
            }
            candidate += 1
        }
        return nil
    }
}

// MARK: - Prime Families

public extension Math {
    /// Returns `true` if this number is a Sophie Germain prime.
    ///
    /// A *Sophie Germain prime* is a prime number `p` such that
    /// `2p + 1` is also prime. The corresponding prime `2p + 1`
    /// is called a *safe prime*.
    ///
    /// - Returns: `true` if this number is a Sophie Germain prime,
    ///   otherwise `false`.
    ///
    /// - Complexity: **O(√n)** for the primality test of `p` and `2p+1`.
    ///
    /// # Examples
    /// ```swift
    /// Math(2).isSophieGermainPrime   // true (2p+1 = 5 is prime)
    /// Math(3).isSophieGermainPrime   // true (2p+1 = 7 is prime)
    /// Math(5).isSophieGermainPrime   // true (2p+1 = 11 is prime)
    /// Math(11).isSophieGermainPrime  // true (2p+1 = 23 is prime)
    /// Math(23).isSophieGermainPrime  // false (2p+1 = 47, not prime)
    /// ```
    var isSophieGermainPrime: Bool {
        guard isPrime else { return false }
        return (2 * self + 1).isPrime
    }

    /// Returns `true` if this is a safe prime.
    ///
    /// A safe prime `p` is one where `(p - 1) / 2` is prime.
    ///
    /// - Returns: `true` if safe prime, otherwise `false`.
    var isSafePrime: Bool {
        guard isPrime, self > 2 else { return false }
        return ((self - 1) / 2).isPrime
    }

    /// Returns `true` if this prime is part of a twin prime pair (difference 2).
    ///
    /// - Returns: `true` if `p-2` or `p+2` is prime.
    var isTwinPrime: Bool {
        guard isPrime else { return false }
        return (self - 2).isPrime || (self + 2).isPrime
    }

    /// Returns `true` if this prime is a cousin prime (difference 4).
    ///
    /// - Returns: `true` if `p-4` or `p+4` is prime.
    var isCousinPrime: Bool {
        guard isPrime else { return false }
        return (self - 4).isPrime || (self + 4).isPrime
    }

    /// Returns `true` if this prime is a sexy prime (difference 6).
    ///
    /// - Returns: `true` if `p-6` or `p+6` is prime.
    var isSexyPrime: Bool {
        guard isPrime else { return false }
        return (self - 6).isPrime || (self + 6).isPrime
    }

    /// Returns `true` if this prime is part of a sexy prime triplet.
    ///
    /// A sexy prime triplet is three primes in arithmetic progression:
    /// `(p, p+6, p+12)`. This property returns `true` when `self` is any
    /// member of such an arrangement.
    ///
    /// Known triplets: (5, 11, 17) and (7, 13, 19).
    var isSexyPrimeTriplet: Bool {
        guard isPrime else { return false }
        let p = self
        return ((p + 6).isPrime && (p + 12).isPrime) ||
               ((p - 6).isPrime && (p + 6).isPrime) ||
               ((p - 12).isPrime && (p - 6).isPrime)
    }

    /// Returns `true` if this number is a Mersenne prime.
    ///
    /// A Mersenne prime is a prime of the form `2^q - 1`, where `q` itself is prime.
    /// The implementation checks whether `n + 1` is a power of two.
    ///
    /// - Returns: `true` if Mersenne prime, otherwise `false`.
    ///
    /// - Complexity: **O(log n)** for the power-of-two test plus primality check.
    ///
    /// # Examples
    /// ```swift
    /// Math(3).isMersennePrime   // true, since 3 = 2^2 - 1
    /// Math(7).isMersennePrime   // true, since 7 = 2^3 - 1
    /// Math(31).isMersennePrime  // true
    /// ```
    var isMersennePrime: Bool {
        guard isPrime, let n = self.asInt else { return false }
        let candidate = n + 1
        return candidate > 0 && (candidate & (candidate - 1)) == 0
    }

    /// Returns `true` if this number is a Fermat prime.
    ///
    /// A *Fermat prime* is a prime of the form `2^(2^n) + 1`,
    /// where `n` is a non-negative integer.
    ///
    /// - Returns: `true` if this number is a Fermat prime, otherwise `false`.
    ///
    /// - Complexity: **O(log n)** for the exponentiation and primality check.
    ///
    /// # Examples
    /// ```swift
    /// Math(3).isFermatPrime    // true (n = 0, 2^(2^0)+1 = 3)
    /// Math(5).isFermatPrime    // true (n = 1, 2^(2^1)+1 = 5)
    /// Math(17).isFermatPrime   // true (n = 2, 2^(2^2)+1 = 17)
    /// Math(257).isFermatPrime  // true
    /// Math(65537).isFermatPrime// true
    /// Math(11).isFermatPrime   // false
    /// ```
    var isFermatPrime: Bool {
        guard isPrime, let n = self.asInt else { return false }
        return [3, 5, 17, 257, 65537].contains(n)
    }

    /// Returns `true` if this number is a super-prime.
    ///
    /// A super-prime is a prime whose index in the sequence of primes is itself prime.
    ///
    /// - Returns: `true` if super-prime, otherwise `false`.
    var isSuperPrime: Bool {
        guard let idx = self.primeIndex else { return false }
        return idx.isPrime
    }

    /// Returns `true` if this prime is isolated (not part of a twin prime).
    ///
    /// - Returns: `true` if neither `p-2` nor `p+2` is prime.
    var isIsolatedPrime: Bool {
        guard isPrime else { return false }
        return !(self - 2).isPrime && !(self + 2).isPrime
    }

    /// Returns `true` if this number is both lucky and prime.
    ///
    /// A lucky prime survives the Josephus Flavius sieve and is prime.
    var isLuckyPrime: Bool {
        return self.isLucky && self.isPrime
    }
}

// MARK: - Factorial / Primorial Based Primes

public extension Math {
    /// Returns `true` if this number is a factorial prime.
    ///
    /// A factorial prime has the form `n! ± 1`.
    ///
    /// - Note: this tries successive factorial values and compares; it relies
    ///         on your `Math` factorial implementation (`~!`).
    var isFactorialPrime: Bool {
        guard self > 1 else { return false }
        var n = Math(1)
        var fact = Math(1)
        while fact < self {
            fact *= n
            if fact + 1 == self || fact - 1 == self {
                return self.isPrime
            }
            n += 1
        }
        return false
    }

    /// Returns `true` if this number is a primorial prime.
    ///
    /// A primorial prime has the form `p# ± 1`, where `p#` is the product of all primes ≤ `p`.
    var isPrimorialPrime: Bool {
        guard self > 2 else { return false }
        var product = Math(1)
        var p = Math(2)
        while product < self {
            if p.isPrime {
                product *= p
                if product + 1 == self || product - 1 == self {
                    return self.isPrime
                }
            }
            p += 1
        }
        return false
    }

    /// Returns `true` if this number is a Pillai prime.
    ///
    /// A *Pillai prime* `p` is a prime such that there exists
    /// some integer `n > 0` with:
    ///
    /// ```text
    /// n! ≡ -1 (mod p)
    /// ```
    ///
    /// Unlike Wilson primes, Pillai primes do not require `n = p-1`;
    /// they only require that some factorial is congruent to `-1 mod p`.
    ///
    /// - Returns: `true` if this number is a Pillai prime, otherwise `false`.
    ///
    /// - Complexity: Potentially high, since factorial growth is rapid.
    ///   This implementation performs iterative factorial checks until
    ///   exceeding the current prime.
    ///
    /// # Examples
    /// ```swift
    /// Math(23).isPillaiPrime   // true
    /// Math(31).isPillaiPrime   // true
    /// Math(5).isPillaiPrime    // false
    /// ```
    var isPillaiPrime: Bool {
        guard isPrime, let p = self.asInt else { return false }
        for n in 1..<(p * 2) {
            let fact = (Math(integerLiteral: n)~!)
            if fact % self == self - 1 && (fact + 1) % self != 0 {
                return true
            }
        }
        return false
    }

    /// Returns `true` if this number is a Chen prime.
    ///
    /// `p` is a Chen prime when `p + 2` is prime or semiprime.
    var isChenPrime: Bool {
        guard isPrime else { return false }
        return (self + 2).isPrime || (self + 2).isSemiPrime
    }
}

// MARK: - Truncatable Primes

public extension Math {
    /// Returns `true` if this number is a left-truncatable prime.
    ///
    /// A *left-truncatable prime* remains prime when digits are
    /// successively removed from the left.
    ///
    /// - Returns: `true` if left-truncatable, otherwise `false`.
    ///
    /// - Complexity: Up to **O(d · √n)** where `d` is the number of digits.
    ///
    /// # Examples
    /// ```swift
    /// Math(3797).isLeftTruncatablePrime  // true (3797 → 797 → 97 → 7)
    /// Math(23).isLeftTruncatablePrime    // true (23 → 3)
    /// Math(20).isLeftTruncatablePrime    // false
    /// ```
    var isLeftTruncatablePrime: Bool {
        guard isPrime else { return false }
        var s = self.description
        while s.count > 1 {
            s.removeFirst()
            let n = Math(stringLiteral: s)
            guard n.isPrime else { return false }
        }
        return true
    }

    /// Returns `true` if this number is a right-truncatable prime.
    ///
    /// A *right-truncatable prime* remains prime when digits are
    /// successively removed from the right.
    ///
    /// - Returns: `true` if right-truncatable, otherwise `false`.
    ///
    /// - Complexity: Up to **O(d · √n)** where `d` is the number of digits.
    ///
    /// # Examples
    /// ```swift
    /// Math(739397).isRightTruncatablePrime // true (739397 → 73939 → 7393 → 739 → 73 → 7)
    /// Math(53).isRightTruncatablePrime     // true (53 → 5)
    /// Math(25).isRightTruncatablePrime     // false
    /// ```
    var isRightTruncatablePrime: Bool {
        guard isPrime else { return false }
        var s = self.description
        while s.count > 1 {
            s.removeLast()
            let n = Math(stringLiteral: s)
            guard n.isPrime else { return false }
        }
        return true
    }

    /// Returns `true` if this number is two-sided truncatable prime
    /// (both left- and right-truncatable).
    var isTwoSidedTruncatablePrime: Bool {
        return isLeftTruncatablePrime && isRightTruncatablePrime
    }
}

// MARK: - Digit-Based Primes

public extension Math {
    /// Returns `true` if this number is a palindromic prime.
    ///
    /// A *palindromic prime* is both a prime number and a
    /// palindromic number (reads the same forwards and backwards).
    ///
    /// - Returns: `true` if palindromic prime, otherwise `false`.
    ///
    /// - Complexity: **O(√n)** for the primality test plus
    /// **O(d)** for palindrome check, where `d` is the number of digits.
    ///
    /// # Examples
    /// ```swift
    /// Math(131).isPalindromicPrime  // true
    /// Math(151).isPalindromicPrime  // true
    /// Math(101).isPalindromicPrime  // true
    /// Math(13).isPalindromicPrime   // false
    /// ```
    var isPalindromicPrime: Bool {
        guard isPrime else { return false }
        let s = self.description
        return s == String(s.reversed())
    }

    /// Returns `true` if this number is an emirp prime.
    ///
    /// An *emirp* is a non-palindromic prime that remains prime
    /// when its digits are reversed.
    ///
    /// - Returns: `true` if emirp, otherwise `false`.
    ///
    /// - Complexity: **O(√n)** for primality tests of both
    /// the original number and its reverse.
    ///
    /// # Examples
    /// ```swift
    /// Math(13).isEmirp   // true (reverse 31 is also prime)
    /// Math(17).isEmirp   // true (reverse 71 is also prime)
    /// Math(11).isEmirp   // false (palindromic prime, not an emirp)
    /// ```
    var isEmirp: Bool {
        guard isPrime else { return false }
        let reversedStr = String(self.description.reversed())
        let reversed = Math(stringLiteral: reversedStr)
        return reversed.isPrime && reversed != self
    }

    /// Returns `true` if this number is a repunit prime.
    ///
    /// A *repunit* is a number consisting entirely of `1`s in decimal form,
    /// such as 11, 111, 1111, etc. A *repunit prime* is a repunit number
    /// that is also prime.
    ///
    /// - Returns: `true` if this number is a repunit prime, otherwise `false`.
    ///
    /// - Complexity: **O(√n)** for the primality test, plus string
    /// validation of the digit pattern.
    ///
    /// # Examples
    /// ```swift
    /// Math(11).isRepunitPrime   // true (repunit "11")
    /// Math(1111111111111111111).isRepunitPrime // true (repunit prime R19)
    /// Math(111).isRepunitPrime  // false (111 = 3 × 37)
    /// ```
    var isRepunitPrime: Bool {
        guard isPrime else { return false }
        let s = self.description
        return Set(s).count == 1 && s.first == "1"
    }
}

// MARK: - Semi-Primes & Helpers

public extension Math {
    /// Returns `true` if this number is a semi-prime (product of exactly two primes).
    ///
    /// - Returns: `true` if semi-prime, otherwise `false`.
    var isSemiPrime: Bool {
        guard let n = self.asInt, n > 1 else { return false }

        var count = 0
        var num = n

        for i in 2...n {
            while num % i == 0 {
                num /= i
                count += 1
                if count > 2 { return false }
            }
        }
        return count == 2
    }
    
    /// Returns the next prime number strictly greater than this value.
    ///
    /// This method starts from the integer immediately above the current
    /// value and searches upward until it finds a prime number.
    ///
    /// - Returns: The next prime number after `self`.
    ///
    /// - Complexity:
    ///   In the worst case, this may require testing several consecutive
    ///   integers for primality. Each primality check runs in **O(√n)**
    ///   time, so the total cost depends on the size of the gap between
    ///   primes.
    ///
    /// # Examples
    ///
    /// ```swift
    /// Math(2).nextPrime()   // 3
    /// Math(3).nextPrime()   // 5
    /// Math(14).nextPrime()  // 17
    /// ```
    func nextPrime() -> Math {
        var candidate = self + 1
        while !candidate.isPrime {
            candidate += 1
        }
        return candidate
    }
    
    /// Returns the largest prime number strictly less than this value.
    ///
    /// If the current value is `≤ 2`, the function returns `nil`
    /// since there are no primes smaller than 2.
    ///
    /// - Returns: The previous prime number, or `nil` if no smaller prime exists.
    ///
    /// - Complexity:
    ///   May require checking several decreasing integers until a prime is found,
    ///   each test costing **O(√n)** time.
    ///
    /// # Examples
    ///
    /// ```swift
    /// Math(10).previousPrime()   // 7
    /// Math(7).previousPrime()    // 5
    /// Math(2).previousPrime()    // nil
    /// ```
    func previousPrime() -> Math? {
        guard self > 2 else { return nil }
        var candidate = self - 1
        while candidate >= 2 {
            if candidate.isPrime {
                return candidate
            }
            candidate -= 1
        }
        return nil
    }

}
