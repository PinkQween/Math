# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2025-10-04

### Added

#### Core Features
- Arbitrary-precision arithmetic using `BigInt` and `BigDecimal`
- Dynamic number handling for integers, doubles, and large numbers
- Thread-safe global settings for precision and angle modes
- Operator overloading for intuitive Swift-native syntax

#### Mathematical Operations
- Standard arithmetic operators: `+`, `-`, `*`, `/`, `%`
- Exponentiation operator: `**`
- Hyperoperations: `^^` (tetration), `^^^` (pentation)
- Factorial operators: `!`, `!!` (double), `!!!` (triple), `!n` (subfactorial)
- Root operators: `|/` (nth root), `√` (alternative syntax)
- Trigonometric functions: `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `atan2`
- Hyperbolic functions: `sinh`, `cosh`, `tanh`, `asinh`, `acosh`, `atanh`
- Exponential and logarithmic functions: `exp`, `ln`, `log10`

#### Number Properties (50+)
- Prime classifications: prime, Sophie Germain, safe, twin, cousin, sexy, Mersenne, Fermat
- Special numbers: perfect, abundant, deficient, triangular, square, pentagonal, hexagonal
- Fibonacci and Lucas numbers
- Number tests: palindrome, happy, narcissistic, Harshad, Keith, Armstrong
- Basic properties: parity, sign, even/odd detection

#### Units System (200+)
- **Standard Units**: 150+ units across 16 dimensions
  - Length: meter, kilometer, foot, mile, nautical mile, etc.
  - Mass: kilogram, gram, pound, ounce, stone, metric ton
  - Time: second, minute, hour, day, week, year (with sub-second precision)
  - Temperature: Kelvin, Celsius, Fahrenheit (with offset conversions)
  - Area: square meter, acre, hectare
  - Volume: liter, gallon (US/Imperial), cubic meter
  - Speed: m/s, km/h, mph, knots
  - Pressure: pascal, bar, atmosphere, PSI, torr
  - Energy: joule, calorie, kilocalorie, watt-hour, electronvolt, BTU
  - Power: watt, kilowatt, horsepower
  - Angle: radian, degree, gradian, arcminute, arcsecond
  - Frequency: hertz and multiples, RPM
  - Data Storage: byte, KB/MB/GB (decimal) and KiB/MiB/GiB (binary)
  - Fuel Economy: L/100km, mpg (US/Imperial), km/L

- **Physics Units**: 50+ specialized units
  - Planck units: length, mass, time, temperature
  - Electrical: ampere, coulomb, volt, ohm, siemens, farad, henry
  - Magnetic: tesla, weber, gauss
  - Radiation: becquerel, gray, sievert, curie, roentgen, rad, rem
  - Force: newton, dyne, pound-force
  - Luminous: candela, lumen, lux
  - Amount of substance: mole

- **Exotic Units**: 30+ unusual units
  - Astronomical: parsec, light-year, astronomical unit
  - Historical: cubit, hand, fathom, furlong
  - Whimsical: smoot, beard-second
  - Volume: hogshead, firkin, bushel, peck
  - Speed: mach number
  - Force: poundal, kip, sthene
  - And more!

#### Mathematical Constants (70+)
- **Basic Constants** (MathConstants):
  - π (pi), e (Euler's number), √2, √3

- **Extended Mathematical Constants** (ExtendedMathConstants): 50+ constants
  - Transcendental numbers: τ (tau), φ (golden ratio), γ (Euler-Mascheroni)
  - Special constants: Apéry's constant ζ(3), Catalan's constant
  - Roots: √2, √3, √5, ∛2, ∛3
  - Trigonometric: π/2, π/3, π/4, π/6, 2π, 3π/2
  - Logarithmic: ln(2), ln(10), log₁₀(e), log₂(e)
  - Number theory: Khinchin's, Glaisher-Kinkelin, Conway's, Ramanujan-Soldner
  - Chaos theory: Feigenbaum delta and alpha
  - Metal ratios: golden, silver, bronze
  - Conversion: degrees per radian, radians per degree

- **Physics Constants** (PhysicsConstants): 30+ constants
  - Universal: speed of light (c), gravitational constant (G), Planck constant (h, ℏ)
  - Electromagnetic: elementary charge (e), vacuum permittivity (ε₀), vacuum permeability (μ₀)
  - Atomic: electron mass, proton mass, neutron mass, atomic mass unit
  - Avogadro constant (N_A), Boltzmann constant (k_B), gas constant (R)
  - Thermodynamic: Stefan-Boltzmann constant (σ), Wien displacement constant
  - Quantum: Rydberg constant, Bohr radius, fine-structure constant (α)

- **Astronomy Constants** (AstronomyConstants): 20+ constants
  - Cosmological: Hubble constant (H₀)
  - Solar: mass, radius, luminosity, temperature
  - Earth: mass, radius, gravity, astronomical unit, orbital period
  - Lunar: mass, radius, orbital periods
  - Jupiter: mass, radius
  - Distances: light-year, parsec, kiloparsec, megaparsec
  - Helper functions: schwarzschildRadius, escapeVelocity

#### Geometry
- Triangle solver with SSS, SAS, ASA methods
- Pythagorean theorem
- Heron's formula for area
- Perimeter calculations

#### Matrix Operations
- Matrix addition, subtraction, multiplication
- Element access and equality checking
- Support for arbitrary-precision matrix elements

#### Number Pronunciation
- English spelling: "forty two"
- Aviation pronunciation: "four two"
- Support for large numbers (vigintillion and beyond)

#### Advanced Features
- Dimensional analysis for unit compatibility
- Unit conversion with proper offset handling (e.g., temperature)
- Planck unit conversions
- Custom dimension support
- Compound unit factory

### Documentation
- Comprehensive README with examples
- API documentation with DocC
- Contributing guidelines
- Detailed code documentation

### Infrastructure
- Swift 6.1 support
- GitHub Actions CI workflow
- 107 test cases (all passing)
- MIT License

### Known Limitations
- Some trigonometric functions use placeholder implementations for very high precision calculations
- Newton-Raphson iterations may have convergence issues at extreme precision levels
- Taylor series expansions are slow with BigInt (exponential and logarithm functions)

[Unreleased]: https://github.com/PinkQween/Math/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/PinkQween/Math/releases/tag/v0.1.0
