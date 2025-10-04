//
//  Factorial.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation


// MARK: - Factorial & Factorial Derivatives

// -------------------------------
// Standard Factorial (!)
// -------------------------------

postfix operator ~!
public extension Math {
    /// Factorial of a non-negative integer `n`.
    ///
    /// - Returns: `n! = 1 × 2 × ... × n`
    /// - Note: Returns `1` if the value is not a non-negative integer.
    static postfix func ~! (x: Math) -> Math {
        guard let n = x.asInt else {
            fatalError("Cannot calculate factorial of non-integer")
        }
        
        guard n >= 0 else { return 1 }
        if n == 0 || n == 1 { return 1 }
        
        var result = BigInt(1)
        for i in 2...n {
            result *= BigInt(i)
        }
        return Math(bigDecimal: result, scale: 0)
    }
}

// -------------------------------
// Subfactorial (!n, derangements)
// -------------------------------

prefix operator ~!
public extension Math {
    /// Subfactorial (derangements) of a non-negative integer `n`.
    ///
    /// - Returns: `!n`, the number of permutations of `n` elements with no fixed points.
    /// - Definition: `!0 = 1`, `!1 = 0`, and
    ///   `!n = (n-1)(!(n-1) + !(n-2))` for `n > 1`.
    /// - Note: Returns `1` if the value is not a non-negative integer.
    static prefix func ~! (x: Math) -> Math {
        guard let n = x.asInt, n >= 0 else { return 1 }
        if n == 0 { return 1 }
        if n == 1 { return 0 }

        var dp: [BigInt] = [1, 0] // !0=1, !1=0
        for i in 2...n {
            let value = BigInt(i - 1) * (dp[i - 1] + dp[i - 2])
            dp.append(value)
        }

        return Math(bigDecimal: dp[n], scale: 0)
    }
}

// -------------------------------
// Step Factorials (Double, Triple, Quadruple, etc.)
// -------------------------------

postfix operator ~!!
postfix operator ~!!!
postfix operator ~!!!!

public extension Math {
    /// General step factorial.
    ///
    /// - Parameters:
    ///   - n: The number to compute the factorial of.
    ///   - step: Step size for the factorial (2 for double factorial, 3 for triple, etc.).
    /// - Returns: Product of numbers from `n` down to `1` in steps of `step`.
    static func generalFactorial(_ n: Math, step: Math = 1) -> Math {
        guard n > 1 else { return 1 }
        var result: Math = 1
        var current = n
        while current > 1 {
            result *= current
            current -= step
        }
        return result
    }

    /// Double factorial: `n!! = n × (n-2) × (n-4) ...`
    static postfix func ~!! (x: Math) -> Math {
        return generalFactorial(x, step: 2)
    }

    /// Triple factorial: `n!!! = n × (n-3) × (n-6) ...`
    static postfix func ~!!! (x: Math) -> Math {
        return generalFactorial(x, step: 3)
    }

    /// Quadruple factorial: `n!!!! = n × (n-4) × (n-8) ...`
    static postfix func ~!!!! (x: Math) -> Math {
        return generalFactorial(x, step: 4)
    }
}
