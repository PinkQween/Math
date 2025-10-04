# ``Math``

A comprehensive, high-precision mathematical computation library for Swift.

## Overview

The Math library provides arbitrary-precision arithmetic, extensive unit conversions, advanced mathematical operations, and comprehensive number properties. Perfect for scientific computing, educational tools, financial calculations, and applications requiring exact decimal arithmetic.

### Key Features

- **Arbitrary-Precision Arithmetic**: Handle numbers of any size with BigInt integration
- **200+ Units**: Comprehensive unit system with automatic conversions
- **Advanced Operations**: Hyperoperations, factorials, roots, and complete trigonometry
- **50+ Number Properties**: Prime detection, special numbers, and mathematical classifications
- **Triangle Solver**: Solve triangles with any 3 known values using Law of Sines and Cosines

## Topics

### Core Types

- ``Math``
- ``MathSettings``
- ``MathStorage``

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
```

## See Also

- [GitHub Repository](https://github.com/PinkQween/Math)
- [Contributing Guide](https://github.com/PinkQween/Math/blob/main/CONTRIBUTING.md)
- [Examples](https://github.com/PinkQween/Math/blob/main/README.md#-examples)
