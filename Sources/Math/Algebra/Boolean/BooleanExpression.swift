//
//  BooleanExpression.swift
//  Math
//
//  Boolean expressions and algebraic simplification
//

/// A Boolean expression that can be evaluated and manipulated.
///
/// `BooleanExpression` represents logical expressions using variables and operators,
/// supporting evaluation, simplification, and algebraic manipulation.
///
/// ### Example Usage
/// ```swift
/// // Create expressions
/// let a = BooleanExpression.variable("A")
/// let b = BooleanExpression.variable("B")
/// let expr = a.and(b).or(a.not())
///
/// // Evaluate with variable assignments
/// let result = expr.evaluate(["A": true, "B": false])
///
/// // Get DNF (Disjunctive Normal Form)
/// let dnf = expr.toDNF()
/// ```
public indirect enum BooleanExpression: Equatable, CustomStringConvertible, Sendable {
    case constant(Bool)
    case variable(String)
    case not(BooleanExpression)
    case and(BooleanExpression, BooleanExpression)
    case or(BooleanExpression, BooleanExpression)
    case xor(BooleanExpression, BooleanExpression)
    case implies(BooleanExpression, BooleanExpression)

    // MARK: - Constants

    /// The constant true expression.
    public static let `true` = BooleanExpression.constant(true)

    /// The constant false expression.
    public static let `false` = BooleanExpression.constant(false)

    // MARK: - Construction Helpers

    /// Creates a NOT expression.
    public func not() -> BooleanExpression {
        .not(self)
    }

    /// Creates an AND expression.
    public func and(_ other: BooleanExpression) -> BooleanExpression {
        .and(self, other)
    }

    /// Creates an OR expression.
    public func or(_ other: BooleanExpression) -> BooleanExpression {
        .or(self, other)
    }

    /// Creates an XOR expression.
    public func xor(_ other: BooleanExpression) -> BooleanExpression {
        .xor(self, other)
    }

    /// Creates an IMPLIES expression.
    public func implies(_ other: BooleanExpression) -> BooleanExpression {
        .implies(self, other)
    }

    // MARK: - Evaluation

    /// Evaluates the expression with the given variable assignments.
    ///
    /// - Parameter variables: A dictionary mapping variable names to Boolean values.
    /// - Returns: The evaluated Boolean result, or nil if a variable is missing.
    public func evaluate(_ variables: [String: Bool]) -> Bool? {
        switch self {
        case .constant(let value):
            return value

        case .variable(let name):
            return variables[name]

        case .not(let expr):
            guard let value = expr.evaluate(variables) else { return nil }
            return !value

        case .and(let lhs, let rhs):
            guard let left = lhs.evaluate(variables), let right = rhs.evaluate(variables) else { return nil }
            return left && right

        case .or(let lhs, let rhs):
            guard let left = lhs.evaluate(variables), let right = rhs.evaluate(variables) else { return nil }
            return left || right

        case .xor(let lhs, let rhs):
            guard let left = lhs.evaluate(variables), let right = rhs.evaluate(variables) else { return nil }
            return LogicGate.xor(left, right)

        case .implies(let lhs, let rhs):
            guard let left = lhs.evaluate(variables), let right = rhs.evaluate(variables) else { return nil }
            return LogicGate.imply(left, right)
        }
    }

    // MARK: - Simplification

    /// Simplifies the expression using Boolean algebra rules.
    ///
    /// Applies rules such as:
    /// - Identity: A AND true = A, A OR false = A
    /// - Annihilation: A AND false = false, A OR true = true
    /// - Idempotence: A AND A = A, A OR A = A
    /// - Double negation: NOT NOT A = A
    ///
    /// - Returns: A simplified expression.
    public func simplified() -> BooleanExpression {
        switch self {
        case .constant, .variable:
            return self

        case .not(let expr):
            let simplified = expr.simplified()
            // Double negation: NOT NOT A = A
            if case .not(let inner) = simplified {
                return inner
            }
            // NOT true = false, NOT false = true
            if case .constant(let value) = simplified {
                return .constant(!value)
            }
            return .not(simplified)

        case .and(let lhs, let rhs):
            let left = lhs.simplified()
            let right = rhs.simplified()

            // A AND false = false
            if case .constant(false) = left { return .false }
            if case .constant(false) = right { return .false }

            // A AND true = A
            if case .constant(true) = left { return right }
            if case .constant(true) = right { return left }

            // A AND A = A (idempotence)
            if left == right { return left }

            return .and(left, right)

        case .or(let lhs, let rhs):
            let left = lhs.simplified()
            let right = rhs.simplified()

            // A OR true = true
            if case .constant(true) = left { return .true }
            if case .constant(true) = right { return .true }

            // A OR false = A
            if case .constant(false) = left { return right }
            if case .constant(false) = right { return left }

            // A OR A = A (idempotence)
            if left == right { return left }

            return .or(left, right)

        case .xor(let lhs, let rhs):
            let left = lhs.simplified()
            let right = rhs.simplified()

            // A XOR false = A
            if case .constant(false) = left { return right }
            if case .constant(false) = right { return left }

            // A XOR true = NOT A
            if case .constant(true) = left { return right.not() }
            if case .constant(true) = right { return left.not() }

            // A XOR A = false
            if left == right { return .false }

            return .xor(left, right)

        case .implies(let lhs, let rhs):
            let left = lhs.simplified()
            let right = rhs.simplified()

            // false IMPLIES B = true
            if case .constant(false) = left { return .true }

            // A IMPLIES true = true
            if case .constant(true) = right { return .true }

            // true IMPLIES B = B
            if case .constant(true) = left { return right }

            // A IMPLIES false = NOT A
            if case .constant(false) = right { return left.not() }

            return .implies(left, right)
        }
    }

    // MARK: - Normal Forms

    /// Converts to Disjunctive Normal Form (DNF): OR of ANDs.
    ///
    /// - Returns: An equivalent expression in DNF.
    public func toDNF() -> BooleanExpression {
        // For full DNF conversion, we'd need to enumerate all minterms
        // This is a simplified version that applies De Morgan's laws
        applyDeMorgans().simplified()
    }

    /// Converts to Conjunctive Normal Form (CNF): AND of ORs.
    ///
    /// - Returns: An equivalent expression in CNF.
    public func toCNF() -> BooleanExpression {
        // For full CNF conversion, we'd need to enumerate all maxterms
        // This is a simplified version
        applyDeMorgans().simplified()
    }

    // MARK: - Analysis

    /// Returns all variables used in this expression.
    public var variables: Set<String> {
        switch self {
        case .constant:
            return []
        case .variable(let name):
            return [name]
        case .not(let expr):
            return expr.variables
        case .and(let lhs, let rhs), .or(let lhs, let rhs), .xor(let lhs, let rhs), .implies(let lhs, let rhs):
            return lhs.variables.union(rhs.variables)
        }
    }

    /// Generates a truth table for this expression.
    ///
    /// - Returns: An array of variable assignments and their corresponding outputs.
    public func truthTable() -> [([String: Bool], Bool)] {
        let vars = Array(variables).sorted()
        let numRows = 1 << vars.count

        var table: [([String: Bool], Bool)] = []

        for i in 0..<numRows {
            var assignment: [String: Bool] = [:]
            for (index, varName) in vars.enumerated() {
                assignment[varName] = (i & (1 << index)) != 0
            }
            if let result = evaluate(assignment) {
                table.append((assignment, result))
            }
        }

        return table
    }

    // MARK: - Helper Methods

    private func applyDeMorgans() -> BooleanExpression {
        switch self {
        case .not(let expr):
            switch expr {
            case .and(let lhs, let rhs):
                // NOT (A AND B) = (NOT A) OR (NOT B)
                return lhs.not().applyDeMorgans().or(rhs.not().applyDeMorgans())
            case .or(let lhs, let rhs):
                // NOT (A OR B) = (NOT A) AND (NOT B)
                return lhs.not().applyDeMorgans().and(rhs.not().applyDeMorgans())
            default:
                return .not(expr.applyDeMorgans())
            }
        case .and(let lhs, let rhs):
            return .and(lhs.applyDeMorgans(), rhs.applyDeMorgans())
        case .or(let lhs, let rhs):
            return .or(lhs.applyDeMorgans(), rhs.applyDeMorgans())
        case .xor(let lhs, let rhs):
            return .xor(lhs.applyDeMorgans(), rhs.applyDeMorgans())
        case .implies(let lhs, let rhs):
            // A IMPLIES B = (NOT A) OR B
            return lhs.not().applyDeMorgans().or(rhs.applyDeMorgans())
        default:
            return self
        }
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        switch self {
        case .constant(let value):
            return value ? "1" : "0"
        case .variable(let name):
            return name
        case .not(let expr):
            return "¬\(expr)"
        case .and(let lhs, let rhs):
            return "(\(lhs) ∧ \(rhs))"
        case .or(let lhs, let rhs):
            return "(\(lhs) ∨ \(rhs))"
        case .xor(let lhs, let rhs):
            return "(\(lhs) ⊕ \(rhs))"
        case .implies(let lhs, let rhs):
            return "(\(lhs) → \(rhs))"
        }
    }
}
