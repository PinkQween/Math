//
//  Calculus.swift
//  Math
//
//  Numerical calculus operations including derivatives, integrals, series, and limits.
//
//  Created by Hanna Skairipa on 10/4/25.
//

import Foundation

// MARK: - Function Type

/// A mathematical function from Math to Math.
public typealias MathFunction = (Math) -> Math

// MARK: - Derivative Operations

public extension Math {
    /// Computes the numerical derivative of a function at a point using central difference.
    ///
    /// Uses the formula: f'(x) ≈ [f(x+h) - f(x-h)] / (2h)
    ///
    /// ## Example
    /// ```swift
    /// // Derivative of x² at x=3 should be 6
    /// let derivative = Math.derivative(of: { x in x * x }, at: 3)
    /// print(derivative)  // ≈6.0
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function to differentiate
    ///   - x: The point at which to compute the derivative
    ///   - h: The step size (default: 0.0001)
    /// - Returns: Approximate derivative f'(x)
    static func derivative(of f: MathFunction, at x: Math, h: Math = 0.0001) -> Math {
        let fPlus = f(x + h)
        let fMinus = f(x - h)
        return (fPlus - fMinus) / (2 * h)
    }

    /// Computes the second derivative of a function at a point.
    ///
    /// Uses the formula: f''(x) ≈ [f(x+h) - 2f(x) + f(x-h)] / h²
    ///
    /// ## Example
    /// ```swift
    /// // Second derivative of x² is constant 2
    /// let secondDerivative = Math.secondDerivative(of: { x in x * x }, at: 5)
    /// print(secondDerivative)  // ≈2.0
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function to differentiate
    ///   - x: The point at which to compute the second derivative
    ///   - h: The step size (default: 0.0001)
    /// - Returns: Approximate second derivative f''(x)
    static func secondDerivative(of f: MathFunction, at x: Math, h: Math = 0.0001) -> Math {
        let fPlus = f(x + h)
        let fCenter = f(x)
        let fMinus = f(x - h)
        return (fPlus - 2 * fCenter + fMinus) / (h * h)
    }

    /// Computes the nth derivative of a function at a point.
    ///
    /// - Parameters:
    ///   - f: The function to differentiate
    ///   - n: The order of the derivative
    ///   - x: The point at which to compute the derivative
    ///   - h: The step size (default: 0.0001)
    /// - Returns: Approximate nth derivative
    static func nthDerivative(of f: @escaping MathFunction, n: Int, at x: Math, h: Math = 0.0001) -> Math {
        guard n > 0 else { return f(x) }

        if n == 1 {
            return derivative(of: f, at: x, h: h)
        }

        // Recursively compute higher derivatives
        let lowerDerivative: MathFunction = { point in
            nthDerivative(of: f, n: n - 1, at: point, h: h)
        }
        return derivative(of: lowerDerivative, at: x, h: h)
    }
}

// MARK: - Integration Operations

public extension Math {
    /// Computes the definite integral using the trapezoidal rule.
    ///
    /// Divides [a, b] into n intervals and approximates the area using trapezoids.
    ///
    /// ## Example
    /// ```swift
    /// // Integral of x from 0 to 1 should be 0.5
    /// let result = Math.integrate({ x in x }, from: 0, to: 1, intervals: 1000)
    /// print(result)  // ≈0.5
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function to integrate
    ///   - a: Lower bound
    ///   - b: Upper bound
    ///   - intervals: Number of subdivisions (higher = more accurate)
    /// - Returns: Approximate integral ∫f(x)dx from a to b
    static func integrate(
        _ f: MathFunction,
        from a: Math,
        to b: Math,
        intervals n: Int = 1000
    ) -> Math {
        guard n > 0 else { return 0 }

        let h = (b - a) / Math(integerLiteral: n)
        var sum: Math = (f(a) + f(b)) / 2

        for i in 1..<n {
            let x = a + Math(integerLiteral: i) * h
            sum += f(x)
        }

        return sum * h
    }

    /// Computes the definite integral using Simpson's rule (more accurate than trapezoidal).
    ///
    /// Requires an even number of intervals. Uses quadratic approximation.
    ///
    /// ## Example
    /// ```swift
    /// // Integral of x² from 0 to 1 should be 1/3
    /// let result = Math.simpsonIntegrate({ x in x * x }, from: 0, to: 1, intervals: 100)
    /// print(result)  // ≈0.333...
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function to integrate
    ///   - a: Lower bound
    ///   - b: Upper bound
    ///   - intervals: Number of subdivisions (must be even)
    /// - Returns: Approximate integral using Simpson's 1/3 rule
    static func simpsonIntegrate(
        _ f: MathFunction,
        from a: Math,
        to b: Math,
        intervals n: Int = 1000
    ) -> Math {
        var actualN = n
        if actualN % 2 != 0 {
            actualN += 1  // Simpson's rule requires even intervals
        }

        let h = (b - a) / Math(integerLiteral: actualN)
        var sum: Math = f(a) + f(b)

        // Odd indices (multiplied by 4)
        for i in stride(from: 1, to: actualN, by: 2) {
            let x = a + Math(integerLiteral: i) * h
            sum += 4 * f(x)
        }

        // Even indices (multiplied by 2)
        for i in stride(from: 2, to: actualN, by: 2) {
            let x = a + Math(integerLiteral: i) * h
            sum += 2 * f(x)
        }

        return sum * h / 3
    }

    /// Computes an improper integral by limiting to a large bound.
    ///
    /// For integrals to infinity: ∫f(x)dx from a to ∞
    ///
    /// ## Example
    /// ```swift
    /// // Integral of e^(-x) from 0 to ∞ should be 1
    /// let result = Math.improperIntegrate({ x in Math.exp(-x) }, from: 0, upperBound: 10)
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function to integrate
    ///   - a: Lower bound
    ///   - upperBound: Approximation for infinity (default: 100)
    ///   - intervals: Number of subdivisions
    /// - Returns: Approximate improper integral
    static func improperIntegrate(
        _ f: MathFunction,
        from a: Math,
        upperBound: Math = 100,
        intervals: Int = 1000
    ) -> Math {
        return simpsonIntegrate(f, from: a, to: upperBound, intervals: intervals)
    }
}

// MARK: - Series Operations

public extension Math {
    /// Sums an arithmetic series: a + (a+d) + (a+2d) + ... for n terms.
    ///
    /// Uses the formula: S_n = n/2 · [2a + (n-1)d]
    ///
    /// ## Example
    /// ```swift
    /// // Sum of 1 + 2 + 3 + 4 + 5 = 15
    /// let sum = Math.arithmeticSeries(firstTerm: 1, difference: 1, terms: 5)
    /// print(sum)  // 15
    /// ```
    ///
    /// - Parameters:
    ///   - a: First term
    ///   - d: Common difference
    ///   - n: Number of terms
    /// - Returns: Sum of the arithmetic series
    static func arithmeticSeries(firstTerm a: Math, difference d: Math, terms n: Int) -> Math {
        let nMath = Math(integerLiteral: n)
        let term2 = Math(integerLiteral: n - 1) * d
        return (nMath / 2) * (2 * a + term2)
    }

    /// Sums a geometric series: a + ar + ar² + ... for n terms.
    ///
    /// Uses the formula: S_n = a(1 - r^n) / (1 - r) for r ≠ 1
    ///
    /// ## Example
    /// ```swift
    /// // Sum of 1 + 2 + 4 + 8 + 16 = 31
    /// let sum = Math.geometricSeries(firstTerm: 1, ratio: 2, terms: 5)
    /// print(sum)  // 31
    /// ```
    ///
    /// - Parameters:
    ///   - a: First term
    ///   - r: Common ratio
    ///   - n: Number of terms
    /// - Returns: Sum of the geometric series
    static func geometricSeries(firstTerm a: Math, ratio r: Math, terms n: Int) -> Math {
        if r == 1 {
            return a * Math(integerLiteral: n)
        }

        let nMath = Math(integerLiteral: n)
        let numerator = a * (1 - (r ** nMath))
        let denominator = 1 - r
        return numerator / denominator
    }

    /// Sums an infinite geometric series (when |r| < 1).
    ///
    /// Uses the formula: S = a / (1 - r)
    ///
    /// ## Example
    /// ```swift
    /// // Sum of 1 + 1/2 + 1/4 + 1/8 + ... = 2
    /// let sum = Math.infiniteGeometricSeries(firstTerm: 1, ratio: 0.5)
    /// print(sum)  // 2
    /// ```
    ///
    /// - Parameters:
    ///   - a: First term
    ///   - r: Common ratio (must satisfy |r| < 1)
    /// - Returns: Sum of the infinite series
    static func infiniteGeometricSeries(firstTerm a: Math, ratio r: Math) -> Math {
        guard r.absoluteValue < 1 else {
            fatalError("Infinite geometric series requires |r| < 1")
        }
        return a / (1 - r)
    }

    /// Computes the sum of a general series using a term function.
    ///
    /// Computes: Σ f(k) for k from start to end
    ///
    /// ## Example
    /// ```swift
    /// // Sum of squares: 1² + 2² + 3² + 4² + 5² = 55
    /// let sum = Math.sum(from: 1, to: 5) { k in k * k }
    /// print(sum)  // 55
    /// ```
    ///
    /// - Parameters:
    ///   - start: Starting index
    ///   - end: Ending index (inclusive)
    ///   - term: Function that generates the kth term
    /// - Returns: Sum of the series
    static func sum(from start: Int, to end: Int, term: (Math) -> Math) -> Math {
        var result: Math = 0
        for k in start...end {
            result += term(Math(integerLiteral: k))
        }
        return result
    }

    /// Computes the product of a series.
    ///
    /// Computes: Π f(k) for k from start to end
    ///
    /// ## Example
    /// ```swift
    /// // Product: 1 · 2 · 3 · 4 · 5 = 120
    /// let product = Math.product(from: 1, to: 5) { k in k }
    /// print(product)  // 120
    /// ```
    ///
    /// - Parameters:
    ///   - start: Starting index
    ///   - end: Ending index (inclusive)
    ///   - term: Function that generates the kth term
    /// - Returns: Product of the series
    static func product(from start: Int, to end: Int, term: (Math) -> Math) -> Math {
        var result: Math = 1
        for k in start...end {
            result *= term(Math(integerLiteral: k))
        }
        return result
    }
}

// MARK: - Limit Operations

public extension Math {
    /// Approximates the limit of a function as x approaches a value.
    ///
    /// Uses successively smaller steps to approach the limit point.
    ///
    /// ## Example
    /// ```swift
    /// // lim(x→0) sin(x)/x = 1
    /// let limit = Math.limit(of: { x in Math.sin(x) / x }, approaching: 0)
    /// print(limit)  // ≈1
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function
    ///   - a: The point to approach
    ///   - epsilon: How close to get to the point (default: 0.00001)
    /// - Returns: Approximate limit
    static func limit(of f: MathFunction, approaching a: Math, epsilon: Math = 0.00001) -> Math {
        // Approach from the right
        let rightLimit = f(a + epsilon)

        // Could also approach from left and average, but this is a simple approximation
        return rightLimit
    }

    /// Approximates the limit as x approaches infinity.
    ///
    /// ## Example
    /// ```swift
    /// // lim(x→∞) 1/x = 0
    /// let limit = Math.limitAtInfinity(of: { x in 1 / x })
    /// print(limit)  // ≈0
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function
    ///   - largeValue: Value to use as approximation for infinity (default: 10000)
    /// - Returns: Approximate limit at infinity
    static func limitAtInfinity(of f: MathFunction, largeValue: Math = 10000) -> Math {
        return f(largeValue)
    }
}

// MARK: - Taylor Series

public extension Math {
    /// Computes the Taylor series expansion of a function around a point.
    ///
    /// Taylor series: f(x) ≈ Σ [f^(n)(a) / n!] · (x - a)^n
    ///
    /// ## Example
    /// ```swift
    /// // Taylor series of sin(x) around 0 evaluated at π/6
    /// let sinFunc: MathFunction = { x in Math.sin(x) }
    /// let approx = Math.taylorSeries(of: sinFunc, around: 0, at: .pi / 6, terms: 10)
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function to expand
    ///   - a: The point to expand around
    ///   - x: The point to evaluate at
    ///   - terms: Number of terms in the expansion
    /// - Returns: Approximate value using Taylor series
    static func taylorSeries(
        of f: @escaping MathFunction,
        around a: Math,
        at x: Math,
        terms n: Int
    ) -> Math {
        var sum: Math = 0

        for k in 0..<n {
            let derivative = nthDerivative(of: f, n: k, at: a)
            let kMath = Math(integerLiteral: k)
            let factorial = kMath~!
            let term = (derivative / factorial) * ((x - a) ** kMath)
            sum += term
        }

        return sum
    }
}

// MARK: - Root Finding

public extension Math {
    /// Finds a root of f(x) = 0 using the bisection method.
    ///
    /// Requires f(a) and f(b) to have opposite signs.
    ///
    /// ## Example
    /// ```swift
    /// // Find root of x² - 2 (should be √2 ≈ 1.414)
    /// let root = Math.bisectionRoot(of: { x in x * x - 2 }, in: 0...2)
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function
    ///   - range: The interval [a, b] containing the root
    ///   - tolerance: Acceptable error (default: 0.0001)
    ///   - maxIterations: Maximum iterations (default: 100)
    /// - Returns: Approximate root
    static func bisectionRoot(
        of f: MathFunction,
        in range: ClosedRange<Math>,
        tolerance: Math = 0.0001,
        maxIterations: Int = 100
    ) -> Math {
        var a = range.lowerBound
        var b = range.upperBound

        let fa = f(a)
        let fb = f(b)

        guard (fa > 0 && fb < 0) || (fa < 0 && fb > 0) else {
            fatalError("Bisection method requires f(a) and f(b) to have opposite signs")
        }

        var iterations = 0
        while (b - a).absoluteValue > tolerance && iterations < maxIterations {
            let mid = (a + b) / 2
            let fmid = f(mid)

            if fmid == 0 {
                return mid
            }

            if (fa > 0 && fmid < 0) || (fa < 0 && fmid > 0) {
                b = mid
            } else {
                a = mid
            }

            iterations += 1
        }

        return (a + b) / 2
    }

    /// Finds a root of f(x) = 0 using Newton's method.
    ///
    /// Uses the iteration: x_{n+1} = x_n - f(x_n) / f'(x_n)
    ///
    /// ## Example
    /// ```swift
    /// // Find root of x² - 2 starting from x=1
    /// let root = Math.newtonRoot(of: { x in x * x - 2 }, initialGuess: 1)
    /// ```
    ///
    /// - Parameters:
    ///   - f: The function
    ///   - x0: Initial guess
    ///   - tolerance: Acceptable error (default: 0.0001)
    ///   - maxIterations: Maximum iterations (default: 50)
    /// - Returns: Approximate root
    static func newtonRoot(
        of f: @escaping MathFunction,
        initialGuess x0: Math,
        tolerance: Math = 0.0001,
        maxIterations: Int = 50
    ) -> Math {
        var x = x0
        var iterations = 0

        while iterations < maxIterations {
            let fx = f(x)
            if fx.absoluteValue < tolerance {
                return x
            }

            let fpx = derivative(of: f, at: x)
            guard fpx != 0 else {
                fatalError("Newton's method: derivative is zero")
            }

            x = x - fx / fpx
            iterations += 1
        }

        return x
    }
}
