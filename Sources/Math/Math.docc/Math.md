# ``Math``

A comprehensive, high-precision mathematical computation library for Swift.

## Overview

The Math library provides arbitrary-precision arithmetic, extensive unit conversions, advanced mathematical operations, and comprehensive number properties. Perfect for scientific computing, educational tools, financial calculations, and applications requiring exact decimal arithmetic.

### Key Features

- **Arbitrary-Precision Arithmetic**: Handle numbers of any size with BigInt integration
- **Complex Numbers**: Full support for complex arithmetic in rectangular and polar forms
- **Calculus Operations**: Numerical derivatives, integrals, series, limits, and root finding
- **Statistical Analysis**: Comprehensive statistics with 40+ functions for data analysis
- **200+ Units**: Comprehensive unit system with automatic conversions
- **Advanced Operations**: Hyperoperations, factorials, roots, and complete trigonometry
- **50+ Number Properties**: Prime detection, special numbers, and mathematical classifications
- **Triangle Solver**: Solve triangles with any 3 known values using Law of Sines and Cosines

## Topics

### Core Types

- ``Math``
- ``Complex``
- ``Statistics``
- ``MathSettings``
- ``MathStorage``

### New Features

- <doc:ComplexNumbers>
- <doc:CalculusOperations>
- <doc:StatisticalAnalysis>

### Arithmetic Operations

- <doc:Arithmetic>
- <doc:Hyperoperations>
- <doc:Factorials>
- <doc:Roots>
- <doc:Trigonometry>

### Units System

- ``Unit``
- ``MathUnit``
- ``StandardUnits``
- ``PhysicsUnits``
- ``ExoticUnits``
- ``DimensionID``
- ``StandardDimension``
- ``MinimalDimension``

### Number Properties

- <doc:Primes>
- <doc:SpecialNumbers>
- <doc:BasicProperties>

### Algebra

- ``Matrix``
- ``Vertex``

### Utilities

- ``NumberSpeller``
- ``Triangle``
- ``Parity``
- ``Sign``

### Constants

- <doc:MathematicalConstants>
- <doc:PhysicalConstants>

## Getting Started

### Installation

Add Math to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/PinkQween/Math.git", from: "1.0.0")
]
```

### Basic Usage

```swift
import Math

// Arbitrary-precision arithmetic
let a: Math = "123456789012345678901234567890"
let b: Math = 42
let result = a * b

// Unit conversions
let meters = MathUnit(Math(100), StandardUnits.meter)
let feet = StandardUnits.meter.convertWithinDimension(meters, to: StandardUnits.foot)
print(feet?.value)  // 328.084 ft

// Advanced operations
let factorial = Math(10)~!  // 3628800
let power = Math(2) ** Math(10)  // 1024

// Number properties
if Math(17).isPrime {
    print("17 is prime!")
}

// Complex numbers
let z1 = Complex(real: 3, imaginary: 4)
let z2 = Complex(real: 1, imaginary: -2)
let product = z1 * z2
print(product.magnitude)  // Magnitude of result

// Calculus
let derivative = Math.derivative(of: { x in x * x }, at: 3)
print(derivative)  // ≈ 6

let integral = Math.integrate({ x in x * x }, from: 0, to: 1)
print(integral)  // ≈ 1/3

// Statistics
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
print(data.mean)  // 5.5
print(data.median)  // 5.5
print(data.summary)  // Full statistical summary
```

## See Also

- [GitHub Repository](https://github.com/PinkQween/Math)
- [Contributing Guide](https://github.com/PinkQween/Math/blob/main/CONTRIBUTING.md)
- [Examples](https://github.com/PinkQween/Math/blob/main/README.md#-examples)
