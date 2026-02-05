 # Units
 
 The units system provides dimensional analysis, conversions, and unit-aware arithmetic.
 
 ## Overview
 
 - Use ``MathUnit`` to pair a value with a ``Unit``.
 - Convert within a dimension using ``Unit/convertWithinDimension(_:to:policy:)``.
 - Multiply and divide ``MathUnit`` values to produce compound units.
 - Common units live in ``StandardUnits``.
 
 ## Examples
 
 ```swift
 let distance = MathUnit(Math(1200), StandardUnits.meter)
 let time = MathUnit(Math(60), StandardUnits.second)
 let speed = distance / time
 print(speed?.unit)   // meter per second
 print(speed?.value)  // 20
 ```
 
 ```swift
 let area = MathUnit(Math(2), StandardUnits.squareMeter)
 let length = MathUnit(Math(3), StandardUnits.meter)
 let volume = area * length
 print(volume?.unit)  // cubic meter
 ```
 
 ## Dimensions
 
 - ``StandardDimension`` describes common physical dimensions.
 - ``MinimalDimension`` is the irreducible basis used for dimensional analysis.
 - ``DimensionID`` and ``CustomDimension`` let you extend the system safely.
 
