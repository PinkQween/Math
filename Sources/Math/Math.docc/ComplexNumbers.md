# Complex Numbers

Work with complex numbers in rectangular and polar forms.

## Overview

The ``Complex`` type provides comprehensive support for complex number arithmetic and operations. Complex numbers extend the real number system by introducing the imaginary unit `i`, where `i^2 = -1`.

### Creating Complex Numbers

You can create complex numbers in two ways:

#### Rectangular Form (a + bi)

```swift
// Create from real and imaginary parts
let z1 = Complex(real: 3, imaginary: 4)  // 3 + 4i
let z2 = Complex(real: 1, imaginary: -2) // 1 - 2i

// Create purely real number
let realNum = Complex(real: 5)  // 5 + 0i
let alsoReal = Complex(Math(5)) // Convenience initializer

// Create purely imaginary number
let imagNum = Complex(real: 0, imaginary: 3)  // 0 + 3i
```

#### Polar Form (r �)

```swift
// Create from magnitude and phase
let polar = Complex(magnitude: 5, phase: Math.� / 4)

// The phase angle respects MathSettings.angleMode
Calculate(settings: .init(angleMode: .degrees)) {
    let z = Complex(magnitude: 1, phase: 90)  // 0 + 1i
}
```

### Basic Arithmetic

Complex numbers support all standard arithmetic operations:

```swift
let z1 = Complex(real: 3, imaginary: 4)
let z2 = Complex(real: 1, imaginary: -2)

let sum = z1 + z2        // 4 + 2i
let difference = z1 - z2  // 2 + 6i
let product = z1 * z2     // 11 - 2i
let quotient = z1 / z2    // -1 + 2i
let negation = -z1        // -3 - 4i

// Scalar operations
let scaled = z1 * Math(2)     // 6 + 8i
let divided = z1 / Math(2)    // 1.5 + 2i
```

### Properties and Functions

#### Magnitude and Phase

```swift
let z = Complex(real: 3, imaginary: 4)

print(z.magnitude)  // 5 (|z| = √(3² + 4²))
print(z.abs)        // 5 (alias for magnitude)

print(z.phase)      // ≈0.927 radians or ≈53.13°
print(z.argument)   // Same as phase
```

#### Conjugate

The conjugate of a complex number flips the sign of the imaginary part:

```swift
let z = Complex(real: 3, imaginary: 4)
let conjugate = z.conjugate  // 3 - 4i

// Property: z � z* = |z|�
let product = z * z.conjugate
print(product.real)  // 25 (= 5�)
print(product.imaginary)  // 0
```

#### Type Checks

```swift
let realNum = Complex(real: 5)
print(realNum.isReal)  // true

let imagNum = Complex(imaginary: 3)
print(imagNum.isImaginary)  // true

let zero = Complex.zero
print(zero.isZero)  // true
```

### Advanced Functions

#### Powers and Roots

```swift
let z = Complex(real: 1, imaginary: 1)

// Integer power (fast exponentiation)
let squared = z.power(2)  // 0 + 2i
let cubed = z.power(3)    // -2 + 2i

// Square root
let sqrtResult = Complex.sqrt(z)

// General power (uses exp and ln)
let w = Complex(real: 2, imaginary: 0)
let power = Complex.pow(z, w)  // z�
```

#### Exponential and Logarithm

```swift
let z = Complex(real: 1, imaginary: Math.�)

// Euler's formula: e^(i�) = -1
let exp = Complex.exp(z)  // H-e + 0i

// Natural logarithm
let w = Complex(real: Math.e, imaginary: 0)
let ln = Complex.ln(w)  // H1 + 0i
```

#### Trigonometric Functions

```swift
let z = Complex(real: 0, imaginary: 1)

let sinZ = Complex.sin(z)   // Imaginary sine
let cosZ = Complex.cos(z)   // Complex cosine
let tanZ = Complex.tan(z)   // Complex tangent
```

#### Hyperbolic Functions

```swift
let z = Complex(real: 1, imaginary: 0)

let sinhZ = Complex.sinh(z)
let coshZ = Complex.cosh(z)
let tanhZ = Complex.tanh(z)
```

### Common Constants

```swift
Complex.zero  // 0 + 0i
Complex.one   // 1 + 0i
Complex.i     // 0 + 1i (imaginary unit)
```

## Examples

### Solving Quadratic Equations

Solve ax� + bx + c = 0 for complex roots:

```swift
func solveQuadratic(a: Math, b: Math, c: Math) -> (Complex, Complex) {
    let discriminant = b * b - 4 * a * c

    if discriminant >= 0 {
        // Real roots
        let sqrt = Math.sqrt(discriminant)
        let root1 = Complex((-b + sqrt) / (2 * a))
        let root2 = Complex((-b - sqrt) / (2 * a))
        return (root1, root2)
    } else {
        // Complex roots
        let realPart = -b / (2 * a)
        let imagPart = Math.sqrt(-discriminant) / (2 * a)
        let root1 = Complex(real: realPart, imaginary: imagPart)
        let root2 = Complex(real: realPart, imaginary: -imagPart)
        return (root1, root2)
    }
}

// Example: x� + 1 = 0
let (r1, r2) = solveQuadratic(a: 1, b: 0, c: 1)
print(r1)  // 0 + 1i
print(r2)  // 0 - 1i
```

### Electrical Engineering: Impedance

Calculate total impedance in AC circuits:

```swift
// Resistor: Z = R
let resistor = Complex(real: 100)  // 100�

// Capacitor: Z = -i/(�C)
let frequency = Math(60)  // 60 Hz
let capacitance = Math(0.0001)  // 100�F
let omega = 2 * .� * frequency
let capacitor = Complex(real: 0, imaginary: -1 / (omega * capacitance))

// Inductor: Z = i�L
let inductance = Math(0.1)  // 100mH
let inductor = Complex(real: 0, imaginary: omega * inductance)

// Series circuit
let totalImpedance = resistor + capacitor + inductor
print("Total impedance: \(totalImpedance)")
print("Magnitude: \(totalImpedance.magnitude) �")
print("Phase: \(totalImpedance.phase) radians")
```

### Mandelbrot Set

Check if a point is in the Mandelbrot set:

```swift
func inMandelbrotSet(_ c: Complex, maxIterations: Int = 100) -> Bool {
    var z = Complex.zero

    for _ in 0..<maxIterations {
        z = z.power(2) + c

        if z.magnitude > 2 {
            return false
        }
    }

    return true
}

let point = Complex(real: 0, imaginary: 1)
if inMandelbrotSet(point) {
    print("Point is in the Mandelbrot set")
}
```

## Topics

### Creating Complex Numbers

- ``Complex/init(real:imaginary:)``
- ``Complex/init(_:)``
- ``Complex/init(magnitude:phase:)``

### Properties

- ``Complex/real``
- ``Complex/imaginary``
- ``Complex/magnitude``
- ``Complex/abs``
- ``Complex/phase``
- ``Complex/argument``
- ``Complex/conjugate``
- ``Complex/isReal``
- ``Complex/isImaginary``
- ``Complex/isZero``

### Arithmetic Operations

- ``Complex/+(_:_:)``
- ``Complex/-(_:_:)``
- ``Complex/*(_:_:)``
- ``Complex//(_:_:)``
- ``Complex/-(_:)``

### Advanced Functions

- ``Complex/exp(_:)``
- ``Complex/ln(_:)``
- ``Complex/pow(_:_:)``
- ``Complex/power(_:)``
- ``Complex/sqrt(_:)``

### Trigonometric Functions

- ``Complex/sin(_:)``
- ``Complex/cos(_:)``
- ``Complex/tan(_:)``

### Hyperbolic Functions

- ``Complex/sinh(_:)``
- ``Complex/cosh(_:)``
- ``Complex/tanh(_:)``

### Constants

- ``Complex/zero``
- ``Complex/one``
- ``Complex/i``
