# Calculus Operations

Perform numerical calculus operations including derivatives, integrals, series, and limits.

## Overview

The Math library provides comprehensive numerical calculus operations for arbitrary-precision computations. These operations are particularly useful for scientific computing, optimization, and mathematical analysis.

### Derivatives

Calculate numerical derivatives using the central difference method.

#### First Derivative

```swift
// Derivative of f(x) = x≤
let derivative = Math.derivative(of: { x in x * x }, at: 3)
print(derivative)  // H6 (exact: 2x = 2∑3 = 6)

// Derivative of f(x) = sin(x)
let sinDerivative = Math.derivative(of: { x in Math.sin(x) }, at: 0)
print(sinDerivative)  // H1 (exact: cos(0) = 1)

// Custom step size for higher precision
let preciseDerivative = Math.derivative(
    of: { x in x * x * x },
    at: 2,
    h: 0.00001
)
```

#### Higher-Order Derivatives

```swift
// Second derivative of f(x) = x≤
let secondDerivative = Math.secondDerivative(of: { x in x * x }, at: 5)
print(secondDerivative)  // H2 (constant for quadratic)

// Nth derivative
let fourthDerivative = Math.nthDerivative(
    of: { x in x ** 5 },
    n: 4,
    at: 1
)
print(fourthDerivative)  // H120 (5! / 1! = 120)
```

### Integration

Compute definite integrals using numerical methods.

#### Trapezoidal Rule

Basic integration using trapezoids:

```swift
// +Äπ x dx = 0.5
let integral = Math.integrate({ x in x }, from: 0, to: 1)
print(integral)  // H0.5

// +Ä^¿ sin(x) dx = 2
let sinIntegral = Math.integrate(
    { x in Math.sin(x) },
    from: 0,
    to: .¿,
    intervals: 1000
)
print(sinIntegral)  // H2

// More intervals = higher accuracy
let precise = Math.integrate(
    { x in x * x },
    from: 0,
    to: 1,
    intervals: 10000
)
```

#### Simpson's Rule

More accurate integration using quadratic approximation:

```swift
// +Äπ x≤ dx = 1/3
let integral = Math.simpsonIntegrate(
    { x in x * x },
    from: 0,
    to: 1,
    intervals: 100
)
print(integral)  // H0.333...

// Simpson's rule is more accurate for smooth functions
let accurate = Math.simpsonIntegrate(
    { x in Math.exp(x) },
    from: 0,
    to: 1,
    intervals: 50
)
```

#### Improper Integrals

Approximate integrals to infinity:

```swift
// +Ä^ e^(-x) dx = 1
let improper = Math.improperIntegrate(
    { x in Math.exp(-x) },
    from: 0,
    upperBound: 10  // Approximate 
)
print(improper)  // H1

// +Å^ 1/x≤ dx = 1
let result = Math.improperIntegrate(
    { x in 1 / (x * x) },
    from: 1,
    upperBound: 100
)
```

### Series

Calculate arithmetic and geometric series.

#### Arithmetic Series

Sum of a + (a+d) + (a+2d) + ... for n terms:

```swift
// 1 + 2 + 3 + 4 + 5 = 15
let sum = Math.arithmeticSeries(
    firstTerm: 1,
    difference: 1,
    terms: 5
)
print(sum)  // 15

// Sum of even numbers: 2 + 4 + 6 + 8 + 10 = 30
let evenSum = Math.arithmeticSeries(
    firstTerm: 2,
    difference: 2,
    terms: 5
)
```

#### Geometric Series

Sum of a + ar + ar≤ + ... for n terms:

```swift
// 1 + 2 + 4 + 8 + 16 = 31
let sum = Math.geometricSeries(
    firstTerm: 1,
    ratio: 2,
    terms: 5
)
print(sum)  // 31

// Sum of 1 + 0.5 + 0.25 + 0.125 = 1.875
let decaySum = Math.geometricSeries(
    firstTerm: 1,
    ratio: 0.5,
    terms: 4
)
```

#### Infinite Geometric Series

For |r| < 1, sum = a / (1 - r):

```swift
// 1 + 1/2 + 1/4 + 1/8 + ... = 2
let infiniteSum = Math.infiniteGeometricSeries(
    firstTerm: 1,
    ratio: 0.5
)
print(infiniteSum)  // 2

// 1 + 1/3 + 1/9 + 1/27 + ... = 1.5
let thirdSum = Math.infiniteGeometricSeries(
    firstTerm: 1,
    ratio: Math(1) / 3
)
```

#### General Series

Sum arbitrary series using custom term functions:

```swift
// Sum of squares: 1≤ + 2≤ + 3≤ + 4≤ + 5≤ = 55
let squareSum = Math.sum(from: 1, to: 5) { k in k * k }
print(squareSum)  // 55

// Sum of reciprocals: 1 + 1/2 + 1/3 + 1/4 + 1/5
let harmonicSum = Math.sum(from: 1, to: 5) { k in 1 / k }

// Product series (factorial): 1 ∑ 2 ∑ 3 ∑ 4 ∑ 5 = 120
let factorial = Math.product(from: 1, to: 5) { k in k }
print(factorial)  // 120
```

### Limits

Approximate limits as x approaches a value or infinity.

#### Limits at a Point

```swift
// lim(xí0) sin(x)/x = 1
let limit = Math.limit(
    of: { x in Math.sin(x) / x },
    approaching: 0,
    epsilon: 0.00001
)
print(limit)  // H1

// lim(xí2) (x≤ - 4)/(x - 2) = 4
let algebraicLimit = Math.limit(
    of: { x in (x * x - 4) / (x - 2) },
    approaching: 2,
    epsilon: 0.0001
)
```

#### Limits at Infinity

```swift
// lim(xí) 1/x = 0
let limit = Math.limitAtInfinity(of: { x in 1 / x })
print(limit)  // H0

// lim(xí) (x≤ + 1)/x≤ = 1
let rationalLimit = Math.limitAtInfinity(
    of: { x in (x * x + 1) / (x * x) },
    largeValue: 100000
)
```

### Root Finding

Find zeros of functions using numerical methods.

#### Bisection Method

Guaranteed convergence if f(a) and f(b) have opposite signs:

```swift
// Find 2 by solving x≤ - 2 = 0
let root = Math.bisectionRoot(
    of: { x in x * x - 2 },
    in: 0...3,
    tolerance: 0.0001
)
print(root)  // H1.414

// Find zero of sin(x) in [3, 4]
let sinRoot = Math.bisectionRoot(
    of: { x in Math.sin(x) },
    in: 3...4
)
print(sinRoot)  // H¿
```

#### Newton's Method

Faster convergence using derivative information:

```swift
// Find 2 starting from x = 1
let root = Math.newtonRoot(
    of: { x in x * x - 2 },
    initialGuess: 1,
    tolerance: 0.0001
)
print(root)  // H1.414

// Find root of cubic equation
let cubicRoot = Math.newtonRoot(
    of: { x in x ** 3 - x - 1 },
    initialGuess: 1.5
)
```

### Taylor Series

Approximate functions using Taylor series expansion.

```swift
// Approximate sin(x) around 0
let sinApprox = Math.taylorSeries(
    of: { x in Math.sin(x) },
    around: 0,
    at: Math.¿ / 6,
    terms: 10
)
print(sinApprox)  // H0.5

// Approximate e^x around 0
let expApprox = Math.taylorSeries(
    of: { x in Math.exp(x) },
    around: 0,
    at: 1,
    terms: 20
)
print(expApprox)  // He
```

## Real-World Examples

### Physics: Velocity and Acceleration

```swift
// Position function: s(t) = t≤
let position: MathFunction = { t in t * t }

// Velocity: v(t) = ds/dt = 2t
let velocity = Math.derivative(of: position, at: 3)
print("Velocity at t=3: \(velocity) m/s")  // 6 m/s

// Acceleration: a(t) = dv/dt = 2
let acceleration = Math.secondDerivative(of: position, at: 3)
print("Acceleration: \(acceleration) m/s≤")  // 2 m/s≤
```

### Engineering: Work and Energy

```swift
// Force varies with position: F(x) = kx (spring)
let k = Math(100)  // Spring constant
let force: MathFunction = { x in k * x }

// Work = + F(x) dx from xÅ to xÇ
let work = Math.integrate(force, from: 0, to: 0.5)
print("Work done: \(work) J")  // 12.5 J
```

### Economics: Present Value of Cash Flows

```swift
// Continuous cash flow: f(t) = 1000e^(-0.05t)
let rate = Math(0.05)
let cashFlow: MathFunction = { t in
    Math(1000) * Math.exp(-rate * t)
}

// Present value = +Äπp f(t) dt
let presentValue = Math.integrate(cashFlow, from: 0, to: 10)
print("Present value: $\(presentValue)")
```

### Statistics: Normal Distribution

```swift
// Standard normal PDF: ∆(x) = (1/2¿)e^(-x≤/2)
let normalPDF: MathFunction = { x in
    let coefficient = 1 / Math.sqrt(2 * .¿)
    let exponent = -(x * x) / 2
    return coefficient * Math.exp(exponent)
}

// Probability P(-1 d X d 1) H 0.68
let probability = Math.simpsonIntegrate(normalPDF, from: -1, to: 1)
print("P(-1 d X d 1) = \(probability)")
```

## Topics

### Derivatives

- ``Math/derivative(of:at:h:)``
- ``Math/secondDerivative(of:at:h:)``
- ``Math/nthDerivative(of:n:at:h:)``

### Integration

- ``Math/integrate(_:from:to:intervals:)``
- ``Math/simpsonIntegrate(_:from:to:intervals:)``
- ``Math/improperIntegrate(_:from:upperBound:intervals:)``

### Series

- ``Math/arithmeticSeries(firstTerm:difference:terms:)``
- ``Math/geometricSeries(firstTerm:ratio:terms:)``
- ``Math/infiniteGeometricSeries(firstTerm:ratio:)``
- ``Math/sum(from:to:term:)``
- ``Math/product(from:to:term:)``

### Limits

- ``Math/limit(of:approaching:epsilon:)``
- ``Math/limitAtInfinity(of:largeValue:)``

### Root Finding

- ``Math/bisectionRoot(of:in:tolerance:maxIterations:)``
- ``Math/newtonRoot(of:initialGuess:tolerance:maxIterations:)``

### Taylor Series

- ``Math/taylorSeries(of:around:at:terms:)``
