# Contributing to Math

Thank you for your interest in contributing to Math! This document provides guidelines and best practices for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)
- [Adding New Features](#adding-new-features)

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Maintain professional communication

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Math.git
   cd Math
   ```
3. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### Requirements
- Swift 6.1+
- Xcode 15+ (for macOS development)
- Swift Package Manager

### Build the Project
```bash
swift build
```

### Run Tests
```bash
swift test
```

### Generate Documentation
```bash
swift package generate-documentation
```

## Project Structure

The project follows a modular structure:

```
Sources/Math/
├── Core/               # Core Math type and settings
├── Operations/         # Arithmetic, hyperoperations, factorials, roots, trig
├── Properties/         # Number properties (primes, special numbers, etc.)
├── Units/              # Unit system (200+ units)
├── Algebra/            # Matrix and vector operations
├── Constants/          # Mathematical and physical constants
├── Definitions/        # Basic enums (Parity, Sign)
├── Miscellaneous/      # Utilities like NumberSpeller
└── Imported/           # BigInt implementation
```

## Coding Standards

### Swift API Design Guidelines

Follow [Apple's Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/):

- Use clear, self-documenting names
- Prefer methods and properties over free functions
- Name functions based on their side effects
- Use terminology consistently

### Documentation

All public APIs must include comprehensive documentation:

```swift
/// Brief one-line summary.
///
/// Detailed description explaining:
/// - What the function does
/// - When to use it
/// - Any important behaviors or edge cases
///
/// ## Example
/// ```swift
/// let result = Math(5)~!  // 120
/// ```
///
/// - Parameters:
///   - value: Description of the parameter
/// - Returns: Description of what is returned
/// - Throws: Description of errors (if applicable)
/// - Complexity: Time/space complexity (for non-trivial algorithms)
/// - SeeAlso: Related types or functions
public func yourFunction(_ value: Math) -> Math {
    // Implementation
}
```

### Code Style

- **Indentation**: 4 spaces (no tabs)
- **Line length**: Soft limit of 120 characters
- **Braces**: Opening brace on same line
- **Spacing**: Space after control flow keywords (`if`, `for`, `while`)
- **Access control**: Use `public`, `internal`, or `private` explicitly
- **File organization**: Use `// MARK: -` to organize code sections

### Naming Conventions

- **Types**: `UpperCamelCase` (e.g., `Math`, `StandardUnits`)
- **Functions/Variables**: `lowerCamelCase` (e.g., `isPrime`, `nextPrime`)
- **Constants**: `lowerCamelCase` (e.g., `maxIterations`)
- **Enum cases**: `lowerCamelCase` (e.g., `.celsius`, `.fahrenheit`)

## Testing

### Writing Tests

- Place tests in `Tests/MathTests/`
- Use Swift Testing framework (`@Test`, `#expect`)
- Group related tests with `@Suite`
- Name tests descriptively

Example:

```swift
import Testing
@testable import Math

@Suite("Temperature Conversions")
struct TemperatureTests {

    @Test("Convert Celsius to Fahrenheit")
    func testCelsiusToFahrenheit() async throws {
        let celsius = MathUnit(Math(0), StandardUnits.celsius)
        let fahrenheit = StandardUnits.celsius.convertWithinDimension(
            celsius,
            to: StandardUnits.fahrenheit
        )

        #expect(fahrenheit != nil)
        let diff = abs(Double(fahrenheit!.value - Math(32)))
        #expect(diff < 0.001)
    }
}
```

### Test Coverage

- Aim for high test coverage (>80%)
- Test edge cases (zero, negative, very large numbers)
- Test error conditions
- Include performance tests for critical paths

### Running Specific Tests

```bash
# Run all tests
swift test

# Run specific suite
swift test --filter TemperatureTests

# Run specific test
swift test --filter testCelsiusToFahrenheit
```

## Pull Request Process

### Before Submitting

1. **Ensure tests pass**:
   ```bash
   swift test
   ```

2. **Ensure code builds**:
   ```bash
   swift build
   ```

3. **Format your code** consistently with existing style

4. **Update documentation** if adding/changing public APIs

5. **Add tests** for new functionality

### PR Description Template

```markdown
## Description
Brief description of what this PR does

## Motivation
Why is this change needed? What problem does it solve?

## Changes
- List of specific changes made
- Another change
- etc.

## Testing
Description of how this was tested

## Checklist
- [ ] Tests pass locally
- [ ] New tests added for new functionality
- [ ] Documentation updated
- [ ] Code follows style guidelines
- [ ] No breaking changes (or documented if unavoidable)
```

### Review Process

- Maintainers will review your PR
- Address feedback promptly
- Keep PR scope focused (one feature/fix per PR)
- Be patient and respectful during review

## Adding New Features

### Adding Number Properties

1. Create extension in `Properties/` folder
2. Add computed property to `Math`
3. Write comprehensive documentation
4. Add tests

Example:

```swift
// In Properties/SpecialNumbers.swift
public extension Math {
    /// Returns `true` if the number is a Fibonacci number.
    ///
    /// A Fibonacci number is part of the sequence where each number
    /// is the sum of the two preceding ones: 0, 1, 1, 2, 3, 5, 8, 13...
    ///
    /// ## Example
    /// ```swift
    /// Math(13).isFibonacci  // true
    /// Math(14).isFibonacci  // false
    /// ```
    ///
    /// - Complexity: O(log n) time, O(1) space
    var isFibonacci: Bool {
        // Implementation
    }
}
```

### Adding Units

1. Add unit definition to appropriate file in `Units/`
2. Follow existing pattern:
   ```swift
   /// Brief description
   public static let yourUnit = Unit(
       name: "full name",
       symbol: "sym",
       dimension: .standard(.appropriateDimension),
       toBaseScale: Math(conversionFactor),
       notes: "Helpful context or conversion info"
   )
   ```
3. Add conversion tests

### Adding Operations

1. Create new file in `Operations/` or extend existing
2. Define operators if needed
3. Document complexity and behavior
4. Add comprehensive tests

## Common Pitfalls

### Precision Issues

- Remember that `Math` maintains arbitrary precision
- Avoid converting to `Double` unless necessary
- Use `BigInt` for exact integer arithmetic

### Unit Conversions

- Always use `toBaseScale` relative to SI base unit
- Remember `toBaseOffset` for affine units (temperature)
- Test both directions of conversion

### Performance

- BigInt operations are slower than native types
- Cache results when possible
- Consider complexity for large numbers

## Questions?

- **Issues**: [GitHub Issues](https://github.com/PinkQween/Math/issues)
- **Discussions**: [GitHub Discussions](https://github.com/PinkQween/Math/discussions)
- **Email**: [Maintainer email]

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Math! 🎉
