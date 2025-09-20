Math
============

**Math** is a Swift library designed to make advanced mathematical computations simple, precise, and intuitive for Swift developers. It supports dynamic handling of integers, decimals, large numbers, and advanced operations while maintaining Swift’s native syntax and feel.

Features
--------

*   **Dynamic Number Handling**  
    Supports regular integers, floating-point numbers, arbitrary-precision integers (`BigInt`), and high-precision decimals.
    
*   **Advanced Arithmetic Operators**  
    Includes all standard operations (`+`, `-`, `*`, `/`, `%`) and advanced operations like exponentiation, roots, factorials, tetration, and more.
    
*   **Operator Overloading**  
    Swift-native syntax for intuitive mathematical expressions.
    
*   **Fractional and Precise Computations**  
    Perform calculations with fractions or decimals without losing precision, even with very large numbers.
    
*   **Customizable Math Settings**  
    Configure precision, decimal scale, and rounding rules globally or per calculation.
    
*   **Extensible**  
    Easily extend the library with additional mathematical functions, trigonometry, and special constants.
    

Basic example Usage
-------------

```swift
import Math

let a: Math = 10
let b: Math = 3

// Standard operations
let sum = a + b        // 13
let product = a * b    // 30

// Advanced operations
let power = a ^^ b      // 10^10^10
let root = a |/ b      // cubic root of 10
let factorial = b~!     // 6

// BigInt support
let bigNumber: Math = Math(bigInt: BigInt("12345678901234567890")!)
let bigSum = bigNumber + a
```

Installation
------------

You can add **Math** via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/PinkQween/Math.git", from: "1.0.0")
]
```

Contributing
------------

Contributions are welcome! If you want to add new operators, functions, or improve precision, feel free to open a pull request.

License
-------

MIT License © 2025