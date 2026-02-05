# Constants

Math provides curated constants for mathematics and science. Many constants are available both as raw ``Math`` values and as unit-aware ``MathUnit`` variants.

## Overview

- ``Constants.Math`` and ``Constants.Extended`` provide mathematical constants.
- ``Constants.Physics`` and ``Constants.Astronomy`` provide scientific constants.
- Unit-aware variants are exposed with a `Unit` suffix (e.g., `Constants.Physics.cUnit`).

## Examples

```swift
let pi = Constants.Math.pi
let piUnit = Constants.Math.piUnit  // dimensionless MathUnit
```

```swift
let c = Constants.Physics.cUnit
let energy = c.value * c.value  // Math arithmetic
```

```swift
let earthRadius = Constants.Astronomy.earthRadiusUnit
print(earthRadius.unit.symbol)  // m
```

## Notes

Unit-aware constants use the same numeric values as their ``Math`` counterparts.

