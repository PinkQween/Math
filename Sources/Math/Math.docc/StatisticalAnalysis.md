# Statistical Analysis

Comprehensive statistical functions for data analysis and interpretation.

## Overview

The ``Statistics`` type provides a complete suite of statistical analysis tools for working with datasets. With over 40 functions, it supports everything from basic descriptive statistics to advanced bivariate analysis.

### Creating a Dataset

```swift
// Create from an array of Math values
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

// Create from measurements
let temperatures = Statistics([
    Math(72.5), Math(73.2), Math(71.8),
    Math(74.0), Math(72.9)
])

// Check dataset properties
print(data.count)    // 10
print(data.isEmpty)  // false
```

## Measures of Central Tendency

Statistics that describe the center or typical value of a dataset.

### Mean (Average)

The arithmetic mean: sum(x) / n

```swift
let data = Statistics([1, 2, 3, 4, 5])
print(data.mean)  // 3

// Real-world example: average test score
let scores = Statistics([85, 92, 78, 90, 88])
print("Average score: \(scores.mean ?? 0)")  // 86.6
```

### Median

The middle value when data is sorted:

```swift
// Odd count: exact middle value
let oddData = Statistics([1, 3, 5, 7, 9])
print(oddData.median)  // 5

// Even count: average of two middle values
let evenData = Statistics([1, 2, 3, 4, 5, 6])
print(evenData.median)  // 3.5

// Median is robust to outliers
let withOutlier = Statistics([1, 2, 3, 4, 1000])
print("Mean: \(withOutlier.mean ?? 0)")      // 202 (affected)
print("Median: \(withOutlier.median ?? 0)")  // 3 (not affected)
```

### Mode

The most frequently occurring value:

```swift
let data = Statistics([1, 2, 2, 3, 3, 3, 4, 4])
print(data.mode)  // 3 (appears most often)

// Returns nil if all values appear equally
let uniform = Statistics([1, 2, 3, 4, 5])
print(uniform.mode)  // nil

// Real-world: most common shoe size
let sizes = Statistics([8, 9, 9, 9, 10, 10, 11])
print("Most common size: \(sizes.mode ?? 0)")  // 9
```

### Geometric Mean

The nth root of the product: (product x)^(1/n)

Best for growth rates and ratios:

```swift
// Investment returns: +10%, +20%, -5%
let returns = Statistics([1.1, 1.2, 0.95])
let avgReturn = returns.geometricMean
print("Average return factor: \(avgReturn ?? 0)")

// Population growth rates
let growthRates = Statistics([1.02, 1.03, 1.025])
let avgGrowth = growthRates.geometricMean
```

### Harmonic Mean

n / (sum 1/x_i)

Useful for rates and speeds:

```swift
// Average speed: 60 mph there, 40 mph back
let speeds = Statistics([60, 40])
print("Average speed: \(speeds.harmonicMean ?? 0) mph")  // 48 mph

// Not the same as arithmetic mean!
print("Arithmetic mean: \(speeds.mean ?? 0)")  // 50 mph
```

## Measures of Dispersion

Statistics that describe the spread or variability in data.

### Range

Difference between maximum and minimum:

```swift
let data = Statistics([1, 5, 10])
print(data.range)    // 9
print(data.minimum)  // 1
print(data.maximum)  // 10

// Temperature range
let temps = Statistics([65, 72, 68, 75, 70])
print("Daily range: \(temps.range ?? 0)F")  // 10F
```

### Variance

Average squared deviation from mean: sigma^2 = sum(x - mu)^2 / n

```swift
let data = Statistics([1, 2, 3, 4, 5])
print(data.variance)  // 2

// Sample variance (n-1 denominator)
print(data.sampleVariance)  // 2.5

// Higher variance = more spread
let lowSpread = Statistics([10, 10, 10, 10])
let highSpread = Statistics([1, 10, 15, 20])
print(lowSpread.variance)   // 0
print(highSpread.variance)  // ~52
```

### Standard Deviation

Square root of variance: sigma = sqrt(variance)

```swift
let data = Statistics([2, 4, 4, 4, 5, 5, 7, 9])
print(data.standardDeviation)  // ~2

// Sample standard deviation
print(data.sampleStandardDeviation)  // ~2.14

// Real-world: quality control
let measurements = Statistics([9.9, 10.0, 10.1, 9.95, 10.05])
let tolerance = measurements.standardDeviation ?? 0
print("Standard deviation: +/-\(tolerance)")
```

### Coefficient of Variation

Relative variability: CV = (sigma / mu) x 100%

```swift
let data = Statistics([10, 12, 14, 16, 18])
print(data.coefficientOfVariation)  // Percentage

// Compare variability across different scales
let heights = Statistics([150, 160, 170])  // cm
let weights = Statistics([50, 60, 70])     // kg

// CV allows comparison despite different units
```

## Percentiles and Quartiles

Values that divide data into equal parts.

### Percentiles

```swift
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

// 50th percentile = median
print(data.percentile(50))  // 5.5

// 25th percentile = first quartile
print(data.percentile(25))  // 3.25

// 75th percentile = third quartile
print(data.percentile(75))  // 7.75

// Test scores: "90th percentile"
let scores = Statistics([65, 72, 78, 85, 88, 92, 95])
let ninetiethPercentile = scores.percentile(90)
print("90th percentile: \(ninetiethPercentile ?? 0)")
```

### Quartiles

Divide data into four equal parts:

```swift
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

print(data.firstQuartile)   // Q1: 25th percentile
print(data.secondQuartile)  // Q2: 50th percentile (median)
print(data.thirdQuartile)   // Q3: 75th percentile

// Interquartile Range (IQR): measures spread of middle 50%
print(data.interquartileRange)  // Q3 - Q1
```

### Five-Number Summary

Comprehensive dataset overview:

```swift
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

if let summary = data.fiveNumberSummary() {
    print("Min: \(summary.min)")
    print("Q1:  \(summary.q1)")
    print("Median: \(summary.median)")
    print("Q3:  \(summary.q3)")
    print("Max: \(summary.max)")
}

// Used for box plots
```

## Z-Scores

Standardized scores showing distance from mean in standard deviations.

### Individual Z-Score

```swift
let data = Statistics([10, 12, 14, 16, 18])

// How many standard deviations is 18 from the mean?
let zScore = data.zScore(of: 18)
print("Z-score: \(zScore ?? 0)")  // Positive = above mean

// Interpretation:
// z = 0: at the mean
// z > 0: above mean
// z < 0: below mean
// |z| > 2: unusual value
// |z| > 3: outlier

// Test score interpretation
let testScores = Statistics([72, 75, 78, 80, 85, 88, 92])
let yourScore = Math(92)
let z = testScores.zScore(of: yourScore)
print("Your score is \(z ?? 0) standard deviations above average")
```

### All Z-Scores

```swift
let data = Statistics([10, 12, 14, 16, 18])
let zScores = data.zScores()

// Standardized dataset: mean = 0, SD = 1
print(zScores)  // [-1.26, -0.63, 0, 0.63, 1.26]
```

## Frequency Distributions

Organize data into bins or groups.

### Creating Distributions

```swift
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

// Divide into 5 bins
if let freq = data.frequencyDistribution(bins: 5) {
    for bin in freq {
        print("\(bin.range): \(bin.frequency) values")
    }
}

// Output:
// 1.0-2.8: 2 values
// 2.8-4.6: 2 values
// 4.6-6.4: 2 values
// 6.4-8.2: 2 values
// 8.2-10.0: 2 values
```

### Histograms

```swift
// Create histogram data for visualization
let heights = Statistics([
    165, 170, 168, 172, 169, 171, 167,
    173, 175, 168, 170, 172
])

if let histogram = heights.frequencyDistribution(bins: 4) {
    for bin in histogram {
        let bar = String(repeating: "#", count: bin.frequency)
        print("\(bin.range.lowerBound)-\(bin.range.upperBound): \(bar)")
    }
}
```

## Bivariate Statistics

Analyze relationships between two variables.

### Covariance

Measures how two variables vary together:

```swift
let x = Statistics([1, 2, 3, 4, 5])
let y = Statistics([2, 4, 6, 8, 10])

let cov = Statistics.covariance(x, y)
print("Covariance: \(cov ?? 0)")

// cov > 0: variables increase together
// cov < 0: variables move oppositely
// cov H 0: no linear relationship
```

### Correlation

Standardized measure of linear relationship (-1 to +1):

```swift
let studyHours = Statistics([2, 3, 4, 5, 6])
let testScores = Statistics([65, 75, 80, 85, 95])

let correlation = Statistics.correlation(studyHours, testScores)
print("Correlation: \(correlation ?? 0)")

// r = +1: perfect positive relationship
// r = 0: no linear relationship
// r = -1: perfect negative relationship
// |r| > 0.7: strong correlation
// |r| < 0.3: weak correlation
```

### Linear Regression

Find line of best fit: y = mx + b

```swift
let x = Statistics([1, 2, 3, 4, 5])
let y = Statistics([2, 4, 6, 8, 10])

if let (slope, intercept) = Statistics.linearRegression(x, y) {
    print("y = \(slope)x + \(intercept)")

    // Predict new values
    let newX = Math(7)
    let prediction = slope * newX + intercept
    print("Predicted y for x=7: \(prediction)")
}
```

## Summary Statistics

Get comprehensive overview of a dataset.

### Quick Summary

```swift
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
print(data.summary)
```

Output includes:
- Count
- Mean
- Median
- Mode
- Range (min/max)

Note: Variance, standard deviation, and IQR are excluded from summary for performance but available as individual properties.

### Custom Analysis

```swift
func analyzeDataset(_ data: Statistics) {
    guard let mean = data.mean else {
        print("Empty dataset")
        return
    }

    print("Sample size: \(data.count)")
    print("Mean: \(mean)")
    print("Median: \(data.median ?? 0)")
    print("Range: \(data.range ?? 0)")

    if data.count > 1 {
        let sd = data.sampleStandardDeviation ?? 0
        print("Standard deviation: \(sd)")
        print("Coefficient of variation: \(data.coefficientOfVariation ?? 0)%")
    }
}
```

## Real-World Examples

### Quality Control

```swift
// Widget weights (grams)
let weights = Statistics([
    99.8, 100.1, 99.9, 100.2, 99.7,
    100.0, 100.1, 99.9, 100.3, 99.8
])

let mean = weights.mean ?? 0
let sd = weights.standardDeviation ?? 0

print("Target: 100g")
print("Actual mean: \(mean)g")
print("Standard deviation: \(sd)g")

// Check if within tolerance (0.5g)
let withinTolerance = weights.data.allSatisfy { weight in
    abs(weight - Math(100)) <= Math(0.5)
}
print("All within tolerance: \(withinTolerance)")
```

### Grade Analysis

```swift
let grades = Statistics([
    78, 85, 92, 88, 76, 95, 82,
    90, 87, 84, 91, 79
])

print("Class Performance")
print("=================")
print("Mean: \(grades.mean ?? 0)")
print("Median: \(grades.median ?? 0)")
print("Range: \(grades.minimum ?? 0) - \(grades.maximum ?? 0)")

if let summary = grades.fiveNumberSummary() {
    print("\nQuartiles:")
    print("25th percentile: \(summary.q1)")
    print("50th percentile: \(summary.median)")
    print("75th percentile: \(summary.q3)")
}

// Curved grading: A = mean + 1SD, B = mean, C = mean - 1SD
let mean = grades.mean ?? 0
let sd = grades.standardDeviation ?? 0
print("\nGrading curve:")
print("A: e\(mean + sd)")
print("B: e\(mean)")
print("C: e\(mean - sd)")
```

### Sales Analysis

```swift
let monthlySales = Statistics([
    45000, 52000, 48000, 55000, 51000,
    49000, 58000, 62000, 56000, 53000,
    60000, 67000
])

print("Annual Sales Report")
print("==================")
print("Total: $\(monthlySales.data.reduce(0, +))")
print("Average: $\(monthlySales.mean ?? 0)")
print("Best month: $\(monthlySales.maximum ?? 0)")
print("Worst month: $\(monthlySales.minimum ?? 0)")

let growth = monthlySales.coefficientOfVariation ?? 0
print("Variability: \(growth)%")

// Trend analysis
let months = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
if let (slope, _) = Statistics.linearRegression(months, monthlySales) {
    print("Monthly growth trend: $\(slope)")
}
```

## Topics

### Creating Datasets

- ``Statistics/init(_:)``
- ``Statistics/count``
- ``Statistics/isEmpty``

### Central Tendency

- ``Statistics/mean``
- ``Statistics/median``
- ``Statistics/mode``
- ``Statistics/geometricMean``
- ``Statistics/harmonicMean``

### Dispersion

- ``Statistics/range``
- ``Statistics/minimum``
- ``Statistics/maximum``
- ``Statistics/variance``
- ``Statistics/sampleVariance``
- ``Statistics/standardDeviation``
- ``Statistics/sampleStandardDeviation``
- ``Statistics/coefficientOfVariation``

### Percentiles & Quartiles

- ``Statistics/percentile(_:)``
- ``Statistics/firstQuartile``
- ``Statistics/secondQuartile``
- ``Statistics/thirdQuartile``
- ``Statistics/interquartileRange``
- ``Statistics/fiveNumberSummary()``

### Standardization

- ``Statistics/zScore(of:)``
- ``Statistics/zScores()``

### Frequency Distribution

- ``Statistics/frequencyDistribution(bins:)``

### Bivariate Analysis

- ``Statistics/covariance(_:_:)``
- ``Statistics/correlation(_:_:)``
- ``Statistics/linearRegression(_:_:)``

### Summary

- ``Statistics/summary``
