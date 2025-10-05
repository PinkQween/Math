//
//  Vector2.swift
//  Math
//
//  2D vector for graphics and physics applications
//

/// A 2D vector with x and y components.
///
/// `Vector2` represents a point or direction in 2D space, commonly used in
/// 2D graphics, physics simulations, and geometric calculations.
///
/// ### Example Usage
/// ```swift
/// let position = Vector2(x: 10, y: 20)
/// let velocity = Vector2(x: 1, y: 2)
/// let newPosition = position + velocity
///
/// // Vector operations
/// let distance = position.length
/// let normalized = position.normalized
/// let dot = position.dot(velocity)
/// ```
public struct Vector2: Equatable, CustomStringConvertible, Hashable, Sendable {
    // MARK: - Properties

    /// The x-component of the vector.
    public var x: Math

    /// The y-component of the vector.
    public var y: Math

    // MARK: - Initialization

    /// Creates a new 2D vector with the given components.
    ///
    /// - Parameters:
    ///   - x: The x-component.
    ///   - y: The y-component.
    public init(x: Math = 0, y: Math = 0) {
        self.x = x
        self.y = y
    }

    /// Creates a vector from an angle in radians.
    ///
    /// - Parameter angle: The angle in radians.
    /// - Returns: A unit vector pointing in the direction of the angle.
    public init(angle: Math) {
        self.x = Math.cos(angle)
        self.y = Math.sin(angle)
    }

    // MARK: - Common Vectors

    /// A vector with both components set to zero.
    public static let zero = Vector2(x: 0, y: 0)

    /// A vector with both components set to one.
    public static let one = Vector2(x: 1, y: 1)

    /// A unit vector pointing up (0, 1).
    public static let up = Vector2(x: 0, y: 1)

    /// A unit vector pointing down (0, -1).
    public static let down = Vector2(x: 0, y: -1)

    /// A unit vector pointing left (-1, 0).
    public static let left = Vector2(x: -1, y: 0)

    /// A unit vector pointing right (1, 0).
    public static let right = Vector2(x: 1, y: 0)

    // MARK: - Computed Properties

    /// The length (magnitude) of the vector.
    public var length: Math {
        Math.sqrt(x * x + y * y)
    }

    /// The squared length of the vector (faster than `length`).
    public var lengthSquared: Math {
        x * x + y * y
    }

    /// A normalized version of this vector (length = 1).
    ///
    /// Returns `zero` if the vector has zero length.
    public var normalized: Vector2 {
        let len = length
        guard len > 0 else { return .zero }
        return Vector2(x: x / len, y: y / len)
    }

    /// The angle of this vector in radians.
    public var angle: Math {
        Math.atan2(y, x)
    }

    /// A perpendicular vector (rotated 90° counterclockwise).
    public var perpendicular: Vector2 {
        Vector2(x: -y, y: x)
    }

    // MARK: - Vector Operations

    /// Computes the dot product with another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The dot product.
    public func dot(_ other: Vector2) -> Math {
        x * other.x + y * other.y
    }

    /// Computes the cross product magnitude (2D cross product).
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The signed magnitude of the cross product.
    public func cross(_ other: Vector2) -> Math {
        x * other.y - y * other.x
    }

    /// Returns the distance to another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The distance between the vectors.
    public func distance(to other: Vector2) -> Math {
        (other - self).length
    }

    /// Returns the squared distance to another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The squared distance between the vectors.
    public func distanceSquared(to other: Vector2) -> Math {
        (other - self).lengthSquared
    }

    /// Returns the angle in radians between this vector and another.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The angle in radians.
    public func angle(to other: Vector2) -> Math {
        let dot = self.dot(other)
        let lengths = self.length * other.length
        guard lengths > 0 else { return 0 }
        return Math.acos(dot / lengths)
    }

    /// Linearly interpolates between this vector and another.
    ///
    /// - Parameters:
    ///   - other: The target vector.
    ///   - t: The interpolation factor (0 = this vector, 1 = other vector).
    /// - Returns: The interpolated vector.
    public func lerp(to other: Vector2, t: Math) -> Vector2 {
        self + (other - self) * t
    }

    /// Projects this vector onto another vector.
    ///
    /// - Parameter other: The vector to project onto.
    /// - Returns: The projected vector.
    public func project(onto other: Vector2) -> Vector2 {
        let scalar = self.dot(other) / other.lengthSquared
        return other * scalar
    }

    /// Reflects this vector off a surface with the given normal.
    ///
    /// - Parameter normal: The surface normal (should be normalized).
    /// - Returns: The reflected vector.
    public func reflect(normal: Vector2) -> Vector2 {
        self - normal * (2 * self.dot(normal))
    }

    /// Rotates the vector by an angle in radians.
    ///
    /// - Parameter angle: The rotation angle in radians.
    /// - Returns: The rotated vector.
    public func rotated(by angle: Math) -> Vector2 {
        let cos = Math.cos(angle)
        let sin = Math.sin(angle)
        return Vector2(
            x: x * cos - y * sin,
            y: x * sin + y * cos
        )
    }

    // MARK: - Operators

    /// Adds two vectors component-wise.
    public static func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Subtracts two vectors component-wise.
    public static func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /// Multiplies a vector by a scalar.
    public static func * (lhs: Vector2, rhs: Math) -> Vector2 {
        Vector2(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    /// Multiplies a scalar by a vector.
    public static func * (lhs: Math, rhs: Vector2) -> Vector2 {
        Vector2(x: lhs * rhs.x, y: lhs * rhs.y)
    }

    /// Divides a vector by a scalar.
    public static func / (lhs: Vector2, rhs: Math) -> Vector2 {
        Vector2(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    /// Negates a vector.
    public static prefix func - (vector: Vector2) -> Vector2 {
        Vector2(x: -vector.x, y: -vector.y)
    }

    /// Adds another vector to this vector.
    public static func += (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs + rhs
    }

    /// Subtracts another vector from this vector.
    public static func -= (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs - rhs
    }

    /// Multiplies this vector by a scalar.
    public static func *= (lhs: inout Vector2, rhs: Math) {
        lhs = lhs * rhs
    }

    /// Divides this vector by a scalar.
    public static func /= (lhs: inout Vector2, rhs: Math) {
        lhs = lhs / rhs
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        "Vector2(x: \(x), y: \(y))"
    }
}
