# Trigonometry

Complete trigonometric functions and triangle solving capabilities.

## Overview

The Math library provides a comprehensive trigonometry system including all standard trig functions, inverse functions, hyperbolic functions, and a powerful triangle solver that works with any 3 known values.

### Basic Trigonometric Functions

```swift
// Angle mode can be degrees or radians
let result = Calculate(settings: .init(angleMode: .degrees)) {
    Math.sin(Math(90))   // 1.0
    Math.cos(Math(0))    // 1.0
    Math.tan(Math(45))   // ~1.0
}
```

### Inverse Trigonometric Functions

```swift
let angle = Calculate(settings: .init(angleMode: .degrees)) {
    Math.asin(Math(1))   // 90°
    Math.acos(Math(0))   // 90°
    Math.atan(Math(1))   // 45°
}

// Two-argument arctangent for quadrant determination
let theta = Math.atan2(Math(1), Math(1))  // 45° (Quadrant I)
```

### Hyperbolic Functions

```swift
let sinh = Math.sinh(Math(1))
let cosh = Math.cosh(Math(1))
let tanh = Math.tanh(Math(1))

// Inverse hyperbolic functions
let asinh = Math.asinh(Math(1))
let acosh = Math.acosh(Math(2))
let atanh = Math.atanh(Math(0.5))
```

## Triangle Solver

Solve any triangle with 3 known values using the ``Triangle`` type.

### Pythagorean Theorem

```swift
// Right triangle: a² + b² = c²
let c = Triangle.pythagorean(a: Math(3), b: Math(4))  // 5

// Solve for a leg: a² = c² - b²
let a = Triangle.pythagoreanLeg(c: Math(5), b: Math(4))  // 3
```

### Solving Triangles

The triangle solver supports all standard cases:

#### SSS (Side-Side-Side)

```swift
var triangle = Triangle(a: Math(3), b: Math(4), c: Math(5))
triangle.solve()

print(triangle.alpha)  // ~36.87°
print(triangle.beta)   // ~53.13°
print(triangle.gamma)  // 90°
```

#### SAS (Side-Angle-Side)

```swift
var triangle = Triangle(a: Math(3), b: Math(4), gamma: Math(90))
triangle.solve()

print(triangle.c)  // 5 (Law of Cosines)
```

#### ASA/AAS (Angle-Side-Angle or Angle-Angle-Side)

```swift
var triangle = Triangle(a: Math(10), beta: Math(45), gamma: Math(60))
triangle.solve()

// Uses Law of Sines to find remaining sides
print(triangle.b)
print(triangle.c)
```

### Triangle Properties

```swift
let triangle = Triangle(a: Math(3), b: Math(4), c: Math(5))

// Perimeter
print(triangle.perimeter)  // 12

// Area (Heron's formula)
print(triangle.area)  // 6
```

## Available Functions

### Basic Trigonometry

- ``Math/sin(_:)`` - Sine
- ``Math/cos(_:)`` - Cosine
- ``Math/tan(_:)`` - Tangent

### Inverse Trigonometry

- ``Math/asin(_:)`` - Arcsine
- ``Math/acos(_:)`` - Arccosine
- ``Math/atan(_:)`` - Arctangent
- ``Math/atan2(_:_:)`` - Two-argument arctangent

### Hyperbolic Functions

- ``Math/sinh(_:)`` - Hyperbolic sine
- ``Math/cosh(_:)`` - Hyperbolic cosine
- ``Math/tanh(_:)`` - Hyperbolic tangent

### Inverse Hyperbolic

- ``Math/asinh(_:)`` - Inverse hyperbolic sine
- ``Math/acosh(_:)`` - Inverse hyperbolic cosine
- ``Math/atanh(_:)`` - Inverse hyperbolic tangent

### Helper Functions

- ``Math/exp(_:)`` - Exponential (e^x)
- ``Math/ln(_:)`` - Natural logarithm
- ``Math/sqrt(_:)`` - Square root

## Topics

### Triangle Solving

- ``Triangle``
- ``Triangle/solve()``
- ``Triangle/pythagorean(a:b:)``
- ``Triangle/pythagoreanLeg(c:b:)``
- ``Triangle/area``
- ``Triangle/perimeter``

### Settings

- ``MathSettings/angleMode``
- ``Calculate(settings:_:)``

## See Also

- <doc:Roots>
- ``MathSettings``
