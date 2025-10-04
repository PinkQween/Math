# Arithmetic Operations

Perform basic and advanced arithmetic with arbitrary precision.

## Overview

The Math library provides all standard arithmetic operators with full support for arbitrary-precision numbers. Operations automatically handle BigInt conversion and maintain precision throughout calculations.

### Basic Operators

```swift
let a = Math(1000000000000)
let b = Math(999999999999)

let sum = a + b           // Addition
let difference = a - b    // Subtraction
let product = a * b       // Multiplication
let quotient = a / b      // Division (maintains precision)
let remainder = a % b     // Modulo
```

### Unary Operators

```swift
let positive = Math(42)
let negative = -positive  // Unary negation: -42
```

### Compound Assignment

```swift
var value = Math(100)
value += Math(50)   // 150
value -= Math(25)   // 125
value *= Math(2)    // 250
value /= Math(5)    // 50
value %= Math(7)    // 1
```

## Division Precision

Division operations maintain high precision by using a configurable precision buffer:

```swift
let result = Math(1) / Math(3)
// Returns: 0.3333333333... (with 10+ decimal places)
```

The precision is controlled by `MathSettings.shared.precision`.

## Topics

### Operators

- ``Math/+(_:_:)``
- ``Math/-(_:_:)``
- ``Math/*(_:_:)``
- ``Math//(_:_:)``
- ``Math/%(_:_:)``
- ``Math/prefix-(_:)``

### Compound Assignment

- ``Math/+=(_:_:)``
- ``Math/-=(_:_:)``
- ``Math/*=(_:_:)``
- ``Math//=(_:_:)``
- ``Math/%=(_:_:)``

## See Also

- <doc:Hyperoperations>
- <doc:Roots>
- ``MathSettings``
