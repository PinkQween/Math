//
//  Primes.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Prime Number Properties

public extension Math {

    /// Determines whether the current value is a prime number.
    ///
    /// A *prime number* is a positive integer greater than `1` whose only divisors
    /// are `1` and itself. Equivalently, `n` is prime if there does **not** exist
    /// any integer `d` with `2 ≤ d ≤ √n` such that `n % d == 0`.
    ///
    /// - Returns: `true` if the number is prime; otherwise, `false`.
    ///
    /// - Complexity:
    ///   Runs in **O(√n)** time, since divisibility is only checked up to the
    ///   square root of the value.
    ///
    /// - Important:
    ///   Values less than `2` are **not prime** by definition.
    ///
    /// # Examples
    ///
    /// ```swift
    /// Math(2).isPrime    // true
    /// Math(17).isPrime   // true
    /// Math(18).isPrime   // false
    /// Math(-7).isPrime   // false
    /// Math(0).isPrime    // false
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

    /// Returns `true` if this number is a composite number.
    ///
    /// A composite number is a positive integer greater than 1 that has at least
    /// one positive divisor other than 1 or itself. In other words, it's not prime.
    var isComposite: Bool {
        guard let n = self.asInt else { return false }
        return n > 1 && !isPrime
    }

    /// Returns `true` if this number is a Sophie Germain prime.
    ///
    /// A Sophie Germain prime is a prime number `p` where `2p + 1` is also prime.
    /// Examples: 2, 3, 5, 11, 23, 29, 41, 53, 83, 89, 113, 131...
    var isSophieGermainPrime: Bool {
        guard isPrime else { return false }
        let candidate = 2 * self + 1
        return candidate.isPrime
    }

    /// Returns `true` if this number is a safe prime.
    ///
    /// A safe prime is a prime number `p` where `(p-1)/2` is also prime.
    /// The number `(p-1)/2` is called a Sophie Germain prime.
    /// Examples: 5, 7, 11, 23, 47, 59, 83, 107...
    var isSafePrime: Bool {
        guard isPrime else { return false }
        guard self > 2 else { return false }
        let candidate = (self - 1) / 2
        return candidate.isPrime
    }

    /// Returns `true` if this number is a twin prime.
    ///
    /// A twin prime is a prime number that differs from another prime by 2.
    /// For example, both members of the twin prime pairs (3, 5), (5, 7), (11, 13), (17, 19).
    /// This property returns true if either `n-2` or `n+2` is prime.
    var isTwinPrime: Bool {
        guard isPrime else { return false }
        return (self - 2).isPrime || (self + 2).isPrime
    }

    /// Returns `true` if this number is a cousin prime.
    ///
    /// Cousin primes differ by 4. Examples: (3, 7), (7, 11), (13, 17), (19, 23).
    var isCousinPrime: Bool {
        guard isPrime else { return false }
        return (self - 4).isPrime || (self + 4).isPrime
    }

    /// Returns `true` if this number is a sexy prime.
    ///
    /// Sexy primes differ by 6. The term "sexy" comes from the Latin word for six.
    /// Examples: (5, 11), (7, 13), (11, 17), (13, 19), (17, 23).
    var isSexyPrime: Bool {
        guard isPrime else { return false }
        return (self - 6).isPrime || (self + 6).isPrime
    }

    /// Returns `true` if this number is a Mersenne prime.
    ///
    /// A Mersenne prime is a prime number of the form `2^p - 1` where `p` is also prime.
    /// Examples: 3 (2²-1), 7 (2³-1), 31 (2⁵-1), 127 (2⁷-1).
    var isMersennePrime: Bool {
        guard isPrime else { return false }
        guard let n = self.asInt else { return false }

        // Check if n+1 is a power of 2
        let candidate = n + 1
        return candidate > 0 && (candidate & (candidate - 1)) == 0
    }

    /// Returns `true` if this number is a Fermat prime.
    ///
    /// A Fermat prime is a prime number of the form `2^(2^n) + 1`.
    /// Only five Fermat primes are known: 3, 5, 17, 257, 65537.
    var isFermatPrime: Bool {
        guard isPrime else { return false }
        guard let n = self.asInt else { return false }

        // Known Fermat primes
        let fermatPrimes = [3, 5, 17, 257, 65537]
        return fermatPrimes.contains(n)
    }

    /// Returns the next prime number greater than this value.
    func nextPrime() -> Math {
        var candidate = self + 1
        while !candidate.isPrime {
            candidate += 1
        }
        return candidate
    }

    /// Returns the previous prime number less than this value.
    /// Returns `nil` if no smaller prime exists (i.e., if this value is ≤ 2).
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
