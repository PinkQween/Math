//
//  Statistics.swift
//  Math
//
//  Comprehensive statistical functions for data analysis.
//
//  Created by Hanna Skairipa on 10/4/25.
//

import Foundation

// MARK: - Statistical Dataset

/// A collection of data points with statistical analysis capabilities.
///
/// ## Usage
/// ```swift
/// let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
/// print(data.mean)              // 5.5
/// print(data.median)            // 5.5
/// print(data.standardDeviation) // ≈2.87
/// ```
public struct Statistics: Sendable {
    /// The data points
    public let data: [Math]

    /// Creates a statistics dataset from an array of values.
    ///
    /// - Parameter data: Array of Math values
    public init(_ data: [Math]) {
        self.data = data
    }

    /// Number of data points
    public var count: Int {
        data.count
    }

    /// Returns true if the dataset is empty
    public var isEmpty: Bool {
        data.isEmpty
    }
}

// MARK: - Measures of Central Tendency

extension Statistics {
    /// Arithmetic mean (average): μ = (Σx_i) / n
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 3, 4, 5])
    /// print(data.mean)  // 3
    /// ```
    public var mean: Math? {
        guard !isEmpty else { return nil }
        let sum = data.reduce(Math(0), +)
        return sum / Math(integerLiteral: count)
    }

    /// Median (middle value when sorted)
    ///
    /// - For odd n: middle value
    /// - For even n: average of two middle values
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 3, 4, 5])
    /// print(data.median)  // 3
    /// ```
    public var median: Math? {
        guard !isEmpty else { return nil }

        let sorted = data.sorted()
        let mid = count / 2

        if count % 2 == 0 {
            return (sorted[mid - 1] + sorted[mid]) / 2
        } else {
            return sorted[mid]
        }
    }

    /// Mode (most frequent value)
    ///
    /// Returns nil if all values appear with equal frequency.
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 2, 3, 3, 3, 4])
    /// print(data.mode)  // 3
    /// ```
    public var mode: Math? {
        guard !isEmpty else { return nil }

        var frequencies: [String: Int] = [:]
        for value in data {
            let key = value.description
            frequencies[key, default: 0] += 1
        }

        let maxFreq = frequencies.values.max() ?? 0
        let modes = frequencies.filter { $0.value == maxFreq }

        // Return nil if all values appear equally (no true mode)
        guard modes.count == 1 else { return nil }

        // Convert back to Math
        if let modeStr = modes.keys.first {
            return Math(stringLiteral: modeStr)
        }
        return nil
    }

    /// Geometric mean: (Π x_i)^(1/n)
    ///
    /// Useful for growth rates and ratios.
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 4, 8])
    /// print(data.geometricMean)  // ≈2.828 (fourth root of 64)
    /// ```
    public var geometricMean: Math? {
        guard !isEmpty else { return nil }
        guard data.allSatisfy({ $0 > 0 }) else { return nil }  // Requires positive values

        let product = data.reduce(Math(1), *)
        return product |/ Math(integerLiteral: count)
    }

    /// Harmonic mean: n / (Σ 1/x_i)
    ///
    /// Useful for rates and ratios.
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 4])
    /// print(data.harmonicMean)  // ≈1.714
    /// ```
    public var harmonicMean: Math? {
        guard !isEmpty else { return nil }
        guard data.allSatisfy({ $0 != 0 }) else { return nil }

        let reciprocalSum = data.reduce(Math(0)) { sum, value in
            sum + (1 / value)
        }
        return Math(integerLiteral: count) / reciprocalSum
    }
}

// MARK: - Measures of Dispersion

extension Statistics {
    /// Range (difference between max and min)
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 5, 10])
    /// print(data.range)  // 9
    /// ```
    public var range: Math? {
        guard let min = minimum, let max = maximum else { return nil }
        return max - min
    }

    /// Minimum value
    public var minimum: Math? {
        data.min()
    }

    /// Maximum value
    public var maximum: Math? {
        data.max()
    }

    /// Variance: σ² = Σ(x_i - μ)² / n (population variance)
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 3, 4, 5])
    /// print(data.variance)  // 2
    /// ```
    public var variance: Math? {
        guard let mean = mean, !isEmpty else { return nil }

        let squaredDiffs = data.map { value in
            (value - mean) ** 2
        }

        let sum = squaredDiffs.reduce(Math(0), +)
        return sum / Math(integerLiteral: count)
    }

    /// Sample variance: s² = Σ(x_i - μ)² / (n - 1)
    ///
    /// Use for sample data (unbiased estimator).
    public var sampleVariance: Math? {
        guard let mean = mean, count > 1 else { return nil }

        let squaredDiffs = data.map { value in
            (value - mean) ** 2
        }

        let sum = squaredDiffs.reduce(Math(0), +)
        return sum / Math(integerLiteral: count - 1)
    }

    /// Standard deviation: σ = √variance (population)
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([2, 4, 6, 8])
    /// print(data.standardDeviation)  // ≈2.236
    /// ```
    public var standardDeviation: Math? {
        guard let variance = variance else { return nil }
        return Math.sqrt(variance)
    }

    /// Sample standard deviation: s = √sampleVariance
    public var sampleStandardDeviation: Math? {
        guard let sampleVariance = sampleVariance else { return nil }
        return Math.sqrt(sampleVariance)
    }

    /// Mean absolute deviation: MAD = Σ|x_i - μ| / n
    public var meanAbsoluteDeviation: Math? {
        guard let mean = mean, !isEmpty else { return nil }

        let absoluteDiffs = data.map { value in
            (value - mean).absoluteValue
        }

        let sum = absoluteDiffs.reduce(Math(0), +)
        return sum / Math(integerLiteral: count)
    }

    /// Coefficient of variation: CV = (σ / μ) × 100%
    ///
    /// Measures relative variability (useful for comparing datasets with different units).
    public var coefficientOfVariation: Math? {
        guard let mean = mean, mean != 0, let sd = standardDeviation else { return nil }
        return (sd / mean) * 100
    }
}

// MARK: - Percentiles and Quartiles

extension Statistics {
    /// Computes the pth percentile value.
    ///
    /// - Parameter p: Percentile (0-100)
    /// - Returns: Value at the pth percentile
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    /// print(data.percentile(50))  // 5.5 (median)
    /// print(data.percentile(25))  // 2.75 (Q1)
    /// ```
    public func percentile(_ p: Math) -> Math? {
        guard !isEmpty, p >= 0, p <= 100 else { return nil }

        let sorted = data.sorted()
        let index = (p / 100) * Math(integerLiteral: count - 1)

        guard let indexInt = index.asInt else { return nil }

        // Linear interpolation between values
        if indexInt >= count - 1 {
            return sorted[count - 1]
        }

        let lower = sorted[indexInt]
        let upper = sorted[indexInt + 1]
        let fraction = index - Math(integerLiteral: indexInt)

        return lower + fraction * (upper - lower)
    }

    /// First quartile (Q1): 25th percentile
    public var q1: Math? {
        percentile(25)
    }

    /// Second quartile (Q2): 50th percentile (median)
    public var q2: Math? {
        median
    }

    /// Third quartile (Q3): 75th percentile
    public var q3: Math? {
        percentile(75)
    }

    /// Interquartile range: IQR = Q3 - Q1
    ///
    /// Measures spread of middle 50% of data.
    public var interquartileRange: Math? {
        guard let q1 = q1, let q3 = q3 else { return nil }
        return q3 - q1
    }
}

// MARK: - Distribution Properties

extension Statistics {
    /// Skewness: measures asymmetry of distribution
    ///
    /// - Positive: right-skewed (tail on right)
    /// - Zero: symmetric
    /// - Negative: left-skewed (tail on left)
    ///
    /// Formula: γ₁ = E[(X - μ)³] / σ³
    public var skewness: Math? {
        guard let mean = mean, let sd = standardDeviation, sd != 0, !isEmpty else { return nil }

        let cubedDiffs = data.map { value in
            ((value - mean) / sd) ** 3
        }

        let sum = cubedDiffs.reduce(Math(0), +)
        return sum / Math(integerLiteral: count)
    }

    /// Kurtosis: measures "tailedness" of distribution
    ///
    /// - High: heavy tails, outliers
    /// - Normal distribution: kurtosis ≈ 3
    /// - Low: light tails
    ///
    /// Formula: γ₂ = E[(X - μ)⁴] / σ⁴
    public var kurtosis: Math? {
        guard let mean = mean, let sd = standardDeviation, sd != 0, !isEmpty else { return nil }

        let fourthPowerDiffs = data.map { value in
            ((value - mean) / sd) ** 4
        }

        let sum = fourthPowerDiffs.reduce(Math(0), +)
        return sum / Math(integerLiteral: count)
    }

    /// Excess kurtosis: kurtosis - 3
    ///
    /// - Positive: leptokurtic (heavy tails)
    /// - Zero: mesokurtic (normal)
    /// - Negative: platykurtic (light tails)
    public var excessKurtosis: Math? {
        guard let kurt = kurtosis else { return nil }
        return kurt - 3
    }
}

// MARK: - Bivariate Statistics

extension Statistics {
    /// Covariance between two datasets: Cov(X,Y) = Σ(x_i - μ_x)(y_i - μ_y) / n
    ///
    /// Measures how two variables change together.
    ///
    /// ## Example
    /// ```swift
    /// let x = Statistics([1, 2, 3, 4, 5])
    /// let y = Statistics([2, 4, 6, 8, 10])
    /// print(x.covariance(with: y))  // Positive covariance
    /// ```
    ///
    /// - Parameter other: The other dataset
    /// - Returns: Covariance value
    public func covariance(with other: Statistics) -> Math? {
        guard count == other.count, count > 0 else { return nil }
        guard let meanX = mean, let meanY = other.mean else { return nil }

        var sum: Math = 0
        for i in 0..<count {
            sum += (data[i] - meanX) * (other.data[i] - meanY)
        }

        return sum / Math(integerLiteral: count)
    }

    /// Pearson correlation coefficient: r = Cov(X,Y) / (σ_x · σ_y)
    ///
    /// Measures linear relationship strength.
    /// - Returns value in [-1, 1]
    /// - r = 1: perfect positive correlation
    /// - r = 0: no linear correlation
    /// - r = -1: perfect negative correlation
    ///
    /// ## Example
    /// ```swift
    /// let x = Statistics([1, 2, 3, 4, 5])
    /// let y = Statistics([2, 4, 6, 8, 10])
    /// print(x.correlation(with: y))  // 1.0 (perfect positive)
    /// ```
    public func correlation(with other: Statistics) -> Math? {
        guard let cov = covariance(with: other) else { return nil }
        guard let sdX = standardDeviation, let sdY = other.standardDeviation else { return nil }
        guard sdX != 0, sdY != 0 else { return nil }

        return cov / (sdX * sdY)
    }
}

// MARK: - Linear Regression

extension Statistics {
    /// Performs simple linear regression: y = mx + b
    ///
    /// Returns (slope, intercept) or nil if regression cannot be performed.
    ///
    /// ## Example
    /// ```swift
    /// let x = Statistics([1, 2, 3, 4, 5])
    /// let y = Statistics([2, 4, 6, 8, 10])
    /// if let (m, b) = x.linearRegression(y: y) {
    ///     print("y = \(m)x + \(b)")  // y = 2x + 0
    /// }
    /// ```
    ///
    /// - Parameter y: The dependent variable dataset
    /// - Returns: Tuple of (slope, intercept)
    public func linearRegression(y: Statistics) -> (slope: Math, intercept: Math)? {
        guard count == y.count, count > 1 else { return nil }
        guard let meanX = mean, let meanY = y.mean else { return nil }

        var numerator: Math = 0
        var denominator: Math = 0

        for i in 0..<count {
            let xDiff = data[i] - meanX
            let yDiff = y.data[i] - meanY
            numerator += xDiff * yDiff
            denominator += xDiff * xDiff
        }

        guard denominator != 0 else { return nil }

        let slope = numerator / denominator
        let intercept = meanY - slope * meanX

        return (slope, intercept)
    }

    /// R-squared (coefficient of determination) for linear regression.
    ///
    /// Measures how well the regression line fits the data.
    /// - R² = 1: perfect fit
    /// - R² = 0: no fit
    ///
    /// ## Example
    /// ```swift
    /// let x = Statistics([1, 2, 3, 4, 5])
    /// let y = Statistics([2, 4, 6, 8, 10])
    /// print(x.rSquared(y: y))  // 1.0 (perfect linear fit)
    /// ```
    public func rSquared(y: Statistics) -> Math? {
        guard let r = correlation(with: y) else { return nil }
        return r * r
    }
}

// MARK: - Z-Scores and Standardization

extension Statistics {
    /// Converts all values to z-scores: z = (x - μ) / σ
    ///
    /// Standardizes data to have mean=0 and standard deviation=1.
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 3, 4, 5])
    /// let zScores = data.zScores()
    /// // Z-scores will have mean ≈ 0, std dev ≈ 1
    /// ```
    public func zScores() -> Statistics? {
        guard let mean = mean, let sd = standardDeviation, sd != 0 else { return nil }

        let standardized = data.map { value in
            (value - mean) / sd
        }

        return Statistics(standardized)
    }

    /// Computes the z-score for a specific value.
    ///
    /// - Parameter value: The value to standardize
    /// - Returns: Z-score for the value
    public func zScore(for value: Math) -> Math? {
        guard let mean = mean, let sd = standardDeviation, sd != 0 else { return nil }
        return (value - mean) / sd
    }
}

// MARK: - Frequency Distribution

extension Statistics {
    /// Creates a frequency distribution with specified number of bins.
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 2, 3, 3, 3, 4, 4, 5])
    /// let freq = data.frequencyDistribution(bins: 5)
    /// ```
    ///
    /// - Parameter bins: Number of bins
    /// - Returns: Array of (binRange, frequency) tuples
    public func frequencyDistribution(bins: Int) -> [(range: ClosedRange<Math>, frequency: Int)]? {
        guard !isEmpty, bins > 0 else { return nil }
        guard let min = minimum, let max = maximum else { return nil }

        let binWidth = (max - min) / Math(integerLiteral: bins)
        var distribution: [(range: ClosedRange<Math>, frequency: Int)] = []

        for i in 0..<bins {
            let lower = min + Math(integerLiteral: i) * binWidth
            let upper = (i == bins - 1) ? max : (min + Math(integerLiteral: i + 1) * binWidth)

            let count = data.filter { value in
                value >= lower && value <= upper
            }.count

            distribution.append((range: lower...upper, frequency: count))
        }

        return distribution
    }
}

// MARK: - Summary Statistics

extension Statistics {
    /// Five-number summary: (min, Q1, median, Q3, max)
    ///
    /// Provides a comprehensive overview of the distribution.
    ///
    /// ## Example
    /// ```swift
    /// let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    /// let summary = data.fiveNumberSummary()
    /// print(summary)  // (1, 3.25, 5.5, 7.75, 10)
    /// ```
    public func fiveNumberSummary() -> (min: Math, q1: Math, median: Math, q3: Math, max: Math)? {
        guard let min = minimum,
              let q1 = q1,
              let med = median,
              let q3 = q3,
              let max = maximum else {
            return nil
        }

        return (min, q1, med, q3, max)
    }

    /// Comprehensive statistical summary as a formatted string.
    ///
    /// Note: Only includes fast-to-compute statistics. Variance, SD, and IQR
    /// are excluded due to expensive sqrt operations with BigInt precision.
    public var summary: String {
        var result = "Statistical Summary\n"
        result += "===================\n"
        result += "Count: \(count)\n"

        if let mean = mean {
            result += "Mean: \(mean)\n"
        }
        if let median = median {
            result += "Median: \(median)\n"
        }
        if let mode = mode {
            result += "Mode: \(mode)\n"
        }
        if let min = minimum, let max = maximum {
            result += "Range: [\(min), \(max)]\n"
        }

        return result
    }
}
