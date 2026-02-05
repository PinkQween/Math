# Math

**Math** is a comprehensive Swift library for advanced mathematical computations with arbitrary precision, extensive number properties, and a complete units system. Built following Apple's coding standards with a clean, modular architecture. **Now with C/C++ support!**

[![Swift](https://img.shields.io/badge/Swift-6.1-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-Darwin%20%7C%20Linux-lightgrey.svg)](https://github.com/PinkQween/Math)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/PinkQween/Math?include_prereleases)](https://github.com/PinkQween/Math/releases)
[![Tests](https://github.com/PinkQween/Math/actions/workflows/swift.yml/badge.svg)](https://github.com/PinkQween/Math/actions/workflows/swift.yml)

## ✨ Features

### 🔢 Core Mathematics
- **Arbitrary-precision arithmetic** using `BigInt` and `BigDecimal`
- **Complex numbers** with rectangular and polar forms
- **Calculus operations** including derivatives, integrals, series, and limits
- **Statistical analysis** with 40+ functions for data analysis
- **Dynamic number handling** - integers, doubles, and large numbers seamlessly
- **Operator overloading** for intuitive Swift-native syntax
- **Thread-safe global settings** for precision and angle modes
- **🆕 C/C++ wrappers** for cross-language interoperability

### 🚀 Advanced Operations
- **Standard arithmetic**: `+`, `-`, `*`, `/`, `%`
- **Exponentiation**: `**` (power operator)
- **Hyperoperations**: `^^` (tetration), `^^^` (pentation), etc.
- **Factorials**: `~!`, `~!!` (double), `~!!!` (triple), subfactorial `~!n`
- **Roots**: `|/` (nth root), `√` (alternative syntax)
- **Trigonometry**: `sin`, `cos`, `asin` with degree/radian support
- **Numerical calculus**: derivatives, integrals, Taylor series, root finding

### 🎯 50+ Number Properties
- **Prime classifications**: prime, Sophie Germain, safe, twin, cousin, sexy, Mersenne, Fermat
- **Special numbers**: perfect, abundant, deficient, triangular, square, Fibonacci
- **Number tests**: palindrome, happy, narcissistic, Harshad, Keith
- **Basic properties**: parity, sign, even/odd detection

### 📏 200+ Units of Measurement
- **Standard units**: length, mass, time, temperature, speed, pressure, energy, power, angles, frequency
- **Data storage**: bytes, KB/MB/GB (decimal) and KiB/MiB/GiB (binary)
- **Physics units**: watts, amps, volts, joules, hertz, planck constants
- **Exotic units**: parsecs, smoots, furlongs, hogsheads, astronomical units
- **Temperature conversions**: Celsius, Fahrenheit, Kelvin with proper offset handling
- **Automatic conversion** between compatible units with dimensional analysis

### 🗣️ Number Pronunciation
- **Spell out numbers** in English ("forty two")
- **Aviation pronunciation** for clarity ("four two")
- **Support for large numbers** (up to vigintillion and beyond!)

## 📦 Installation

### Swift Package Manager

Add Math to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/PinkQween/Math.git", from: "0.1.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/PinkQween/Math.git`
3. Select version `0.1.0` or later and add to your target

### C/C++ Projects

For using Math in C or C++ projects, see the [C/C++ Usage Guide](Examples/README.md).

**Quick Start:**
```bash
# Build the library
swift build -c release

# Build C/C++ examples
./build_examples.sh

# Run examples
DYLD_LIBRARY_PATH=.build/release ./example_c    # C
DYLD_LIBRARY_PATH=.build/release ./example_cpp  # C++
```

> **Note**: This is an alpha release (0.1.0). The API may change in future versions. For production use, wait for version 1.0.0.

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

// Complex numbers
let z1 = Complex(real: 3, imaginary: 4)
let z2 = Complex(real: 1, imaginary: -2)
let product = z1 * z2              // Complex multiplication
print(z1.magnitude)                // 5.0

// Calculus
let derivative = Math.derivative(of: { x in x * x }, at: 3)  // ≈6
let integral = Math.integrate({ x in x * x }, from: 0, to: 1)  // ≈0.333

// Statistics
let data = Statistics([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
print(data.mean)                   // 5.5
print(data.standardDeviation)      // ≈2.87
```

### C/C++ Quick Start

```c
// C Example
#include "math_wrapper.h"

MathRef a = math_create_int(42);
MathRef b = math_create_int(10);
MathRef sum = math_add(a, b);

char buffer[1024];
math_to_string(sum, buffer, sizeof(buffer));
printf("Result: %s\n", buffer);  // Result: 52

// Check if prime
if (math_is_prime(math_create_int(17))) {
    printf("17 is prime!\n");
}

// Clean up
math_destroy(a);
math_destroy(b);
math_destroy(sum);
```

```cpp
// C++ Example (with RAII and operators!)
#include "PQMath.hpp"
using namespace math;

Math a(42);
Math b(10);

// Natural operators
std::cout << a + b << "\n";        // 52
std::cout << a * b << "\n";        // 420
std::cout << Math(2).power(Math(10)) << "\n";  // 1024

// Properties
if (Math(17).isPrime()) {
    std::cout << "17 is prime!\n";
}

// No cleanup needed - RAII handles it!
```

See the [C/C++ Usage Guide](Examples/README.md) for complete documentation and examples.

## 📚 Documentation

**📖 Full Documentation:** [https://math.hannaskairipa.com](https://math.hannaskairipa.com)

The complete documentation includes:
- **Complex Numbers**: Comprehensive tutorial and API reference
- **Calculus Operations**: Derivatives, integrals, series, limits, root finding
- **Statistical Analysis**: 40+ statistical functions for data analysis
- **All Core Features**: Number properties, units, constants, and more
- **100+ Code Examples**: Real-world usage examples and patterns

### Quick Reference

#### Number Properties

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
let meters = MathUnit(Math(100), StandardUnits.meter)
let feet = StandardUnits.meter.convertWithinDimension(meters, to: StandardUnits.foot)
print(feet?.value)  // 328.084 ft

// Temperature (with offset handling)
let celsius = MathUnit(Math(0), StandardUnits.celsius)
let fahrenheit = StandardUnits.celsius.convertWithinDimension(celsius, to: StandardUnits.fahrenheit)
print(fahrenheit?.value)  // 32°F

// Data storage
let megabytes = MathUnit(Math(1000), StandardUnits.megabyte)
let gigabytes = StandardUnits.megabyte.convertWithinDimension(megabytes, to: StandardUnits.gigabyte)
print(gigabytes?.value)  // 1 GB

// Binary vs decimal
let gb = MathUnit(Math(1), StandardUnits.gigabyte)  // 1,000,000,000 bytes
let gib = StandardUnits.gigabyte.convertWithinDimension(gb, to: StandardUnits.gibibyte)
print(gib?.value)  // 0.931 GiB (1,073,741,824 bytes)

// Speed
let kmh = MathUnit(Math(100), StandardUnits.kilometersPerHour)
let mph = StandardUnits.kilometersPerHour.convertWithinDimension(kmh, to: StandardUnits.milesPerHour)
print(mph?.value)  // 62.137 mph

// Energy for fitness apps
let calories = MathUnit(Math(500), StandardUnits.kilocalorie)
let joules = StandardUnits.kilocalorie.convertWithinDimension(calories, to: StandardUnits.joule)
print(joules?.value)  // 2,092,000 J
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
├── CMathWrapper/            # C/C++ interop layer
│   ├── MathWrapper.swift   # Swift -> C bridge
│   └── include/            # Public headers
│       ├── math_wrapper.h  # C API
│       └── PQMath.hpp # C++ wrapper
│
├── Operations/              # Mathematical operations
│   ├── Arithmetic.swift    # +, -, *, /, %
│   ├── Hyperoperations.swift  # **, ^^, ^^^
│   ├── Factorial.swift     # !, !!, !!!
│   ├── Roots.swift         # nth roots
│   └── Trigonometry/       # Trig functions
│       └── Trigonometry.swift  # sin, cos, tan, etc.
│
├── Properties/              # 50+ number properties
│   ├── BasicProperties.swift   # parity, sign, etc.
│   ├── Primes.swift           # 10+ prime types
│   ├── SpecialNumbers.swift   # 20+ classifications
│   └── Pronunciation.swift    # Spell out numbers
│
├── Units/                   # 200+ measurement units
│   ├── Unit.swift          # Core unit system
│   ├── MathUnit.swift      # Value + Unit wrapper
│   ├── StandardUnits.swift # Length, mass, time, temp, speed, data, pressure, energy, etc.
│   ├── PhysicsUnits.swift  # Watts, amps, volts, planck constants
│   └── ExoticUnits.swift   # Parsecs, smoots, etc.
│
├── Definitions/             # Basic enums
│   ├── Parity.swift        # Even/odd
│   └── Sign.swift          # Positive/negative/zero
│
├── Constants/               # Mathematical & physical constants
│   ├── Math/               # π, e, √2, √3, etc.
│   └── Physics/            # Speed of light, Planck, Hubble
│
├── Algebra/                 # Linear algebra
│   └── Linear/
│       ├── Matrices.swift  # Matrix operations
│       └── Vertices.swift  # Vector operations
│
├── Miscellaneous/           # Utilities
│   └── NumberSpeller.swift # Spell numbers in English
│
└── Imported/                # BigInt implementation
    └── BigInt.swift         # Arbitrary-precision integers
```

## 🎯 Use Cases

- **Swift applications** with advanced mathematical requirements
- **C/C++ integration** - use Swift's powerful math library from C/C++ code
- **Cross-platform development** - Swift, C, and C++ on macOS and Linux
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

## 📄 License

MIT License © 2025

## 🙏 Acknowledgments

- Built with [BigInt](https://github.com/attaswift/BigInt) for arbitrary-precision arithmetic
- Follows [Apple's Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)

## 📮 Contact

- GitHub: [@PinkQween](https://github.com/PinkQween)
- Issues: [Report a bug](https://github.com/PinkQween/Math/issues)

---

Made with ❤️ and ☕ by Hanna Skairipa
