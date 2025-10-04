# Math

**Math** is a comprehensive Swift library for advanced mathematical computations with arbitrary precision, extensive number properties, and a complete units system. Built following Apple's coding standards with a clean, modular architecture.

[![Swift](https://img.shields.io/badge/Swift-6.1-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](https://github.com/PinkQween/Math)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## ✨ Features

### 🔢 Core Mathematics
- **Arbitrary-precision arithmetic** using `BigInt` and `BigDecimal`
- **Dynamic number handling** - integers, doubles, and large numbers seamlessly
- **Operator overloading** for intuitive Swift-native syntax
- **Thread-safe global settings** for precision and angle modes

### 🚀 Advanced Operations
- **Standard arithmetic**: `+`, `-`, `*`, `/`, `%`
- **Exponentiation**: `**` (power operator)
- **Hyperoperations**: `^^` (tetration), `^^^` (pentation), etc.
- **Factorials**: `!`, `!!` (double), `!!!` (triple), subfactorial `!n`
- **Roots**: `|/` (nth root), `√` (alternative syntax)
- **Trigonometry**: `sin`, `cos`, `asin` with degree/radian support

### 🎯 50+ Number Properties
- **Prime classifications**: prime, Sophie Germain, safe, twin, cousin, sexy, Mersenne, Fermat
- **Special numbers**: perfect, abundant, deficient, triangular, square, Fibonacci
- **Number tests**: palindrome, happy, narcissistic, Harshad, Keith
- **Basic properties**: parity, sign, even/odd detection

### 📏 157 Units of Measurement
- **Standard units**: meters, feet, liters, pounds, etc.
- **Physics units**: watts, amps, volts, joules, hertz, planck constants
- **Exotic units**: parsecs, smoots, furlongs, hogsheads, astronomical units
- **Automatic conversion** between compatible units

### 🗣️ Number Pronunciation
- **Spell out numbers** in English ("forty two")
- **Aviation pronunciation** for clarity ("four two")
- **Support for large numbers** (up to vigintillion and beyond!)

## 📦 Installation

### Swift Package Manager

Add Math to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/PinkQween/Math.git", from: "1.0.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/PinkQween/Math.git`
3. Select version and add to your target

## 🚀 Quick Start

```swift
import Math

// Basic arithmetic with arbitrary precision
let a: Math = 10
let b: Math = 3

let sum = a + b           // 13
let product = a * b       // 30
let division = a / b      // 3.333...

// Advanced operations
let power = a ** b        // 1000 (10³)
let tetration = 2 ^^ 4    // 65536 (2^2^2^2)
let root = 27 |/ 3        // 3 (cube root)
let factorial = 5~!       // 120

// Large numbers - no problem!
let huge: Math = "123456789012345678901234567890"
let bigger = huge ** 2

// Number properties
Math(17).isPrime              // true
Math(17).isTwinPrime          // true
Math(28).isPerfect            // true
Math(153).isNarcissistic      // true
Math(6).isTriangular          // true

// Spell out numbers
Math(42).spelledOut           // "forty two"
Math(1234).spelledOut         // "one thousand two hundred thirty four"
Math(42).spelledAviation      // "four two"

// Unit conversions
let meters = StandardUnits.meter
let feet = StandardUnits.foot
let distance = 100.0

if let distanceInFeet = meters.convert(distance, to: feet) {
    print("\(distance)m = \(distanceInFeet)ft")  // 100m = 328.084ft
}

// Work with exotic units
let parsecs = ExoticUnits.parsec
let smoot = ExoticUnits.smoot  // MIT's favorite unit!
```

## 📚 Documentation

### Number Properties

#### Basic Properties
```swift
Math(42).parity              // .even
Math(42).sign                // .positive
Math(42).isEven              // true
Math(42).isZero              // false
Math(42).absoluteValue       // 42
```

#### Prime Numbers
```swift
Math(17).isPrime                  // true
Math(17).isComposite              // false
Math(11).isSophieGermainPrime     // true (2*11+1=23 is prime)
Math(7).isSafePrime               // true ((7-1)/2=3 is prime)
Math(13).isTwinPrime              // true (11 and 13 are twins)
Math(7).isCousinPrime             // true (3 and 7 differ by 4)
Math(7).isSexyPrime               // true (13 and 7 differ by 6)
Math(127).isMersennePrime         // true (2^7-1)

Math(13).nextPrime()              // 17
Math(13).previousPrime()          // 11
```

#### Special Numbers
```swift
Math(28).isPerfect               // true (1+2+4+7+14=28)
Math(12).isAbundant              // true (sum of divisors > 12)
Math(8).isDeficient              // true (sum of divisors < 8)
Math(10).isTriangular            // true (1+2+3+4=10)
Math(16).isSquare                // true (4²=16)
Math(8).isCube                   // true (2³=8)
Math(13).isFibonacci             // true
Math(121).isPalindrome           // true
Math(7).isHappy                  // true
Math(153).isNarcissistic         // true (1³+5³+3³=153)
Math(18).isHarshad               // true (18/(1+8)=2)
Math(256).isPowerOfTwo           // true (2⁸)
Math(1000).isPowerOfTen          // true (10³)
```

### Hyperoperations

```swift
// Level 2: Exponentiation
2 ** 3                // 8 (2³)

// Level 3: Tetration (power tower)
2 ^^ 3                // 16 (2^2^2)

// Level 4: Pentation
2 ^^^ 3               // 65536 (2^^2^^2)

// Higher levels available: ^^^^, ^^^^^, ^^^^^^, ^^^^^^^, ^^^^^^^^
```

### Factorials

```swift
5~!                   // 120 (standard factorial)
5~!!                  // 15 (double factorial: 5*3*1)
5~!!!                 // 10 (triple factorial: 5*2)
~!3                   // 2 (subfactorial/derangements)
```

### Units System

```swift
// Length conversions
let km = StandardUnits.kilometer
let mi = StandardUnits.mile
km.convert(10, to: mi)    // 6.21371 miles

// Physics units
let kW = PhysicsUnits.kilowatt
let hp = PhysicsUnits.horsepower
kW.convert(100, to: hp)   // ~134 horsepower

// Exotic units
let ly = ExoticUnits.lightYear
let pc = ExoticUnits.parsec
ly.convert(1, to: pc)     // ~0.306 parsecs

// View unit information
print(ExoticUnits.smoot)  // "smoot (sm) - ≈ 5'7" (Harvard Bridge = 364.4 smoots)"
```

### Settings & Configuration

```swift
// Global settings (thread-safe)
MathSettings.shared.angleMode = .radians
MathSettings.shared.precision = 100

// Scoped calculations
let result = Calculate(settings: .init(angleMode: .degrees, precision: 50)) {
    Math.sin(90)  // Uses degrees temporarily
}
// Settings automatically restored
```

## 🏗️ Project Structure

```
Sources/Math/
├── Core/                    # Essential types
│   ├── Math.swift          # Core type definition
│   ├── MathSettings.swift  # Global settings
│   └── MathStorage.swift   # Internal storage
│
├── Operations/              # Mathematical operations
│   ├── Arithmetic.swift    # +, -, *, /, %
│   ├── Hyperoperations.swift  # **, ^^, ^^^
│   ├── Factorial.swift     # !, !!, !!!
│   └── Roots.swift         # nth roots
│
├── Properties/              # 50+ number properties
│   ├── BasicProperties.swift   # parity, sign, etc.
│   ├── Primes.swift           # 10+ prime types
│   ├── SpecialNumbers.swift   # 20+ classifications
│   └── Pronunciation.swift    # Spell out numbers
│
├── Units/                   # 157 measurement units
│   ├── Unit.swift          # Core unit system
│   ├── StandardUnits.swift # Meters, feet, liters
│   ├── PhysicsUnits.swift  # Watts, amps, joules
│   └── ExoticUnits.swift   # Parsecs, smoots, etc.
│
├── Definitions/             # Basic enums
│   ├── Parity.swift
│   └── Sign.swift
│
├── Constants/               # Mathematical constants
├── Algebra/                 # Linear algebra (Matrix)
├── Miscellaneous/           # NumberSpeller
└── Geometry.swift           # Trigonometry
```

## 🎯 Use Cases

- **Scientific computing** with arbitrary precision
- **Educational tools** demonstrating number properties
- **Physics simulations** with comprehensive units
- **Financial calculations** requiring exact decimal arithmetic
- **Cryptography** with large number support
- **Game development** for complex mathematical mechanics
- **Data visualization** with proper unit conversions
- **Accessibility** with number pronunciation features

## 🧪 Examples

### Cryptography: Generate Large Primes
```swift
var candidate: Math = Math("999999999999999999")!
while !candidate.isPrime {
    candidate = candidate.nextPrime()
}
print("Large prime: \(candidate)")
```

### Physics: Unit Conversions
```swift
let speedOfLight = PhysicsUnits.speedOfLight
let distance = 1.0  // meter
let time = speedOfLight.convert(distance, to: StandardUnits.second)
print("Light travels 1m in \(time) seconds")
```

### Math Education: Explore Number Properties
```swift
for n in 1...100 {
    let num = Math(n)
    if num.isPerfect {
        print("\(n) is a perfect number!")
    }
}
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Add more properties**: Implement new number classifications
2. **Expand units**: Add more measurement systems
3. **Optimize performance**: Improve algorithms for large numbers
4. **Documentation**: Improve examples and guides
5. **Bug fixes**: Report or fix issues

Please follow Apple's Swift API Design Guidelines and maintain the existing code structure.

## 📝 Requirements

- Swift 6.1+
- iOS 13.0+ / macOS 10.15+ / Linux

## 📄 License

MIT License © 2025

## 🙏 Acknowledgments

- Built with [BigInt](https://github.com/attaswift/BigInt) for arbitrary-precision arithmetic
- Follows [Apple's Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Inspired by mathematical libraries from Python, Mathematica, and Haskell

## 📮 Contact

- GitHub: [@PinkQween](https://github.com/PinkQween)
- Issues: [Report a bug](https://github.com/PinkQween/Math/issues)

---

Made with ❤️ and ☕ by Hanna Skairipa
