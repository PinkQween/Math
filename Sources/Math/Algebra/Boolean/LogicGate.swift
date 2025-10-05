//
//  LogicGate.swift
//  Math
//
//  Boolean logic gates and operations
//

/// Common logic gates used in Boolean algebra.
///
/// Logic gates are fundamental building blocks that perform basic logical
/// operations on one or more binary inputs.
///
/// ### Example Usage
/// ```swift
/// let a = true
/// let b = false
///
/// let andResult = BooleanGates.and(a, b)    // false
/// let orResult = BooleanGates.or(a, b)      // true
/// let xorResult = BooleanGates.xor(a, b)    // true
/// let notA = BooleanGates.not(a)            // false
/// ```
public enum BooleanGates {

    // MARK: - Basic Gates

    /// AND gate: Returns true only if both inputs are true.
    ///
    /// Truth table:
    /// ```
    /// A  B | Output
    /// -----|-------
    /// 0  0 |   0
    /// 0  1 |   0
    /// 1  0 |   0
    /// 1  1 |   1
    /// ```
    ///
    /// - Parameters:
    ///   - a: First input.
    ///   - b: Second input.
    /// - Returns: The logical AND of the inputs.
    public static func and(_ a: Bool, _ b: Bool) -> Bool {
        a && b
    }

    /// OR gate: Returns true if at least one input is true.
    ///
    /// Truth table:
    /// ```
    /// A  B | Output
    /// -----|-------
    /// 0  0 |   0
    /// 0  1 |   1
    /// 1  0 |   1
    /// 1  1 |   1
    /// ```
    ///
    /// - Parameters:
    ///   - a: First input.
    ///   - b: Second input.
    /// - Returns: The logical OR of the inputs.
    public static func or(_ a: Bool, _ b: Bool) -> Bool {
        a || b
    }

    /// NOT gate (inverter): Returns the opposite of the input.
    ///
    /// Truth table:
    /// ```
    /// A | Output
    /// --|-------
    /// 0 |   1
    /// 1 |   0
    /// ```
    ///
    /// - Parameter a: The input.
    /// - Returns: The logical NOT of the input.
    public static func not(_ a: Bool) -> Bool {
        !a
    }

    // MARK: - Derived Gates

    /// NAND gate: NOT AND. Returns false only if both inputs are true.
    ///
    /// Truth table:
    /// ```
    /// A  B | Output
    /// -----|-------
    /// 0  0 |   1
    /// 0  1 |   1
    /// 1  0 |   1
    /// 1  1 |   0
    /// ```
    ///
    /// Note: NAND is a universal gate - any Boolean function can be implemented using only NAND gates.
    ///
    /// - Parameters:
    ///   - a: First input.
    ///   - b: Second input.
    /// - Returns: The logical NAND of the inputs.
    public static func nand(_ a: Bool, _ b: Bool) -> Bool {
        !(a && b)
    }

    /// NOR gate: NOT OR. Returns true only if both inputs are false.
    ///
    /// Truth table:
    /// ```
    /// A  B | Output
    /// -----|-------
    /// 0  0 |   1
    /// 0  1 |   0
    /// 1  0 |   0
    /// 1  1 |   0
    /// ```
    ///
    /// Note: NOR is a universal gate - any Boolean function can be implemented using only NOR gates.
    ///
    /// - Parameters:
    ///   - a: First input.
    ///   - b: Second input.
    /// - Returns: The logical NOR of the inputs.
    public static func nor(_ a: Bool, _ b: Bool) -> Bool {
        !(a || b)
    }

    /// XOR gate (exclusive OR): Returns true if inputs are different.
    ///
    /// Truth table:
    /// ```
    /// A  B | Output
    /// -----|-------
    /// 0  0 |   0
    /// 0  1 |   1
    /// 1  0 |   1
    /// 1  1 |   0
    /// ```
    ///
    /// - Parameters:
    ///   - a: First input.
    ///   - b: Second input.
    /// - Returns: The logical XOR of the inputs.
    public static func xor(_ a: Bool, _ b: Bool) -> Bool {
        (a || b) && !(a && b)
    }

    /// XNOR gate (exclusive NOR): Returns true if inputs are the same.
    ///
    /// Truth table:
    /// ```
    /// A  B | Output
    /// -----|-------
    /// 0  0 |   1
    /// 0  1 |   0
    /// 1  0 |   0
    /// 1  1 |   1
    /// ```
    ///
    /// - Parameters:
    ///   - a: First input.
    ///   - b: Second input.
    /// - Returns: The logical XNOR of the inputs.
    public static func xnor(_ a: Bool, _ b: Bool) -> Bool {
        !(xor(a, b))
    }

    // MARK: - Implication Gates

    /// IMPLY gate: Logical implication (A implies B).
    ///
    /// Returns false only when A is true and B is false.
    ///
    /// Truth table:
    /// ```
    /// A  B | Output
    /// -----|-------
    /// 0  0 |   1
    /// 0  1 |   1
    /// 1  0 |   0
    /// 1  1 |   1
    /// ```
    ///
    /// - Parameters:
    ///   - a: The antecedent.
    ///   - b: The consequent.
    /// - Returns: The logical implication.
    public static func imply(_ a: Bool, _ b: Bool) -> Bool {
        !a || b
    }

    // MARK: - Multi-Input Gates

    /// Multi-input AND gate.
    ///
    /// - Parameter inputs: Array of Boolean inputs.
    /// - Returns: True if all inputs are true.
    public static func and(_ inputs: [Bool]) -> Bool {
        inputs.allSatisfy { $0 }
    }

    /// Multi-input OR gate.
    ///
    /// - Parameter inputs: Array of Boolean inputs.
    /// - Returns: True if at least one input is true.
    public static func or(_ inputs: [Bool]) -> Bool {
        inputs.contains(true)
    }

    /// Multi-input XOR gate (odd parity).
    ///
    /// - Parameter inputs: Array of Boolean inputs.
    /// - Returns: True if an odd number of inputs are true.
    public static func xor(_ inputs: [Bool]) -> Bool {
        inputs.filter { $0 }.count % 2 == 1
    }

    // MARK: - Utility Functions

    /// Generates the truth table for a binary Boolean function.
    ///
    /// - Parameter function: A function taking two Boolean inputs and returning a Boolean output.
    /// - Returns: An array of tuples representing the truth table.
    public static func truthTable(for function: (Bool, Bool) -> Bool) -> [(a: Bool, b: Bool, output: Bool)] {
        [
            (false, false, function(false, false)),
            (false, true, function(false, true)),
            (true, false, function(true, false)),
            (true, true, function(true, true))
        ]
    }

    /// Generates the truth table for a unary Boolean function.
    ///
    /// - Parameter function: A function taking one Boolean input and returning a Boolean output.
    /// - Returns: An array of tuples representing the truth table.
    public static func truthTable(for function: (Bool) -> Bool) -> [(a: Bool, output: Bool)] {
        [
            (false, function(false)),
            (true, function(true))
        ]
    }
}
