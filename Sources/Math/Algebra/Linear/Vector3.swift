//
//  Vector3.swift
//  Math
//
//  3D vector for graphics, physics, and geometric applications
//

/// A 3D vector with x, y, and z components.
///
/// `Vector3` represents a point or direction in 3D space, essential for
/// 3D graphics, physics simulations, and geometric calculations.
///
/// ### Example Usage
/// ```swift
/// let position = Vector3(x: 1, y: 2, z: 3)
/// let direction = Vector3(x: 0, y: 1, z: 0)
/// let newPosition = position + direction
///
/// // Vector operations
/// let distance = position.length
/// let normalized = position.normalized
/// let dot = position.dot(direction)
/// let cross = position.cross(direction)
/// ```
public struct Vector3: Equatable, CustomStringConvertible, Hashable, Sendable {
    // MARK: - Properties

    /// The x-component of the vector.
    public var x: Math

    /// The y-component of the vector.
    public var y: Math

    /// The z-component of the vector.
    public var z: Math

    // MARK: - Initialization

    /// Creates a new 3D vector with the given components.
    ///
    /// - Parameters:
    ///   - x: The x-component.
    ///   - y: The y-component.
    ///   - z: The z-component.
    public init(x: Math = 0, y: Math = 0, z: Math = 0) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Creates a 3D vector from a 2D vector, setting z to 0.
    ///
    /// - Parameter vector2: The 2D vector.
    public init(_ vector2: Vector2) {
        self.x = vector2.x
        self.y = vector2.y
        self.z = 0
    }

    // MARK: - Common Vectors

    /// A vector with all components set to zero.
    public static let zero = Vector3(x: 0, y: 0, z: 0)

    /// A vector with all components set to one.
    public static let one = Vector3(x: 1, y: 1, z: 1)

    /// A unit vector pointing up (0, 1, 0).
    public static let up = Vector3(x: 0, y: 1, z: 0)

    /// A unit vector pointing down (0, -1, 0).
    public static let down = Vector3(x: 0, y: -1, z: 0)

    /// A unit vector pointing left (-1, 0, 0).
    public static let left = Vector3(x: -1, y: 0, z: 0)

    /// A unit vector pointing right (1, 0, 0).
    public static let right = Vector3(x: 1, y: 0, z: 0)

    /// A unit vector pointing forward (0, 0, 1).
    public static let forward = Vector3(x: 0, y: 0, z: 1)

    /// A unit vector pointing backward (0, 0, -1).
    public static let backward = Vector3(x: 0, y: 0, z: -1)

    // MARK: - Computed Properties

    /// The length (magnitude) of the vector.
    public var length: Math {
        Math.sqrt(x * x + y * y + z * z)
    }

    /// The squared length of the vector (faster than `length`).
    public var lengthSquared: Math {
        x * x + y * y + z * z
    }

    /// A normalized version of this vector (length = 1).
    ///
    /// Returns `zero` if the vector has zero length.
    public var normalized: Vector3 {
        let len = length
        guard len > 0 else { return .zero }
        return Vector3(x: x / len, y: y / len, z: z / len)
    }

    /// Returns the xy components as a Vector2.
    public var xy: Vector2 {
        Vector2(x: x, y: y)
    }

    /// Returns the xz components as a Vector2.
    public var xz: Vector2 {
        Vector2(x: x, y: z)
    }

    /// Returns the yz components as a Vector2.
    public var yz: Vector2 {
        Vector2(x: y, y: z)
    }

    // MARK: - Vector Operations

    /// Computes the dot product with another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The dot product.
    public func dot(_ other: Vector3) -> Math {
        x * other.x + y * other.y + z * other.z
    }

    /// Computes the cross product with another vector.
    ///
    /// The cross product is perpendicular to both input vectors.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The cross product vector.
    public func cross(_ other: Vector3) -> Vector3 {
        Vector3(
            x: y * other.z - z * other.y,
            y: z * other.x - x * other.z,
            z: x * other.y - y * other.x
        )
    }

    /// Returns the distance to another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The distance between the vectors.
    public func distance(to other: Vector3) -> Math {
        (other - self).length
    }

    /// Returns the squared distance to another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The squared distance between the vectors.
    public func distanceSquared(to other: Vector3) -> Math {
        (other - self).lengthSquared
    }

    /// Returns the angle in radians between this vector and another.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The angle in radians.
    public func angle(to other: Vector3) -> Math {
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
    public func lerp(to other: Vector3, t: Math) -> Vector3 {
        self + (other - self) * t
    }

    /// Projects this vector onto another vector.
    ///
    /// - Parameter other: The vector to project onto.
    /// - Returns: The projected vector.
    public func project(onto other: Vector3) -> Vector3 {
        let scalar = self.dot(other) / other.lengthSquared
        return other * scalar
    }

    /// Reflects this vector off a surface with the given normal.
    ///
    /// - Parameter normal: The surface normal (should be normalized).
    /// - Returns: The reflected vector.
    public func reflect(normal: Vector3) -> Vector3 {
        self - normal * (2 * self.dot(normal))
    }

    /// Rotates the vector around an axis by an angle.
    ///
    /// Uses Rodrigues' rotation formula.
    ///
    /// - Parameters:
    ///   - axis: The axis to rotate around (should be normalized).
    ///   - angle: The rotation angle in radians.
    /// - Returns: The rotated vector.
    public func rotated(around axis: Vector3, by angle: Math) -> Vector3 {
        let k = axis.normalized
        let cosAngle = Math.cos(angle)
        let sinAngle = Math.sin(angle)

        // Rodrigues' rotation formula
        return self * cosAngle + k.cross(self) * sinAngle + k * (k.dot(self)) * (1 - cosAngle)
    }

    /// Clamps each component of the vector between min and max values.
    ///
    /// - Parameters:
    ///   - min: The minimum vector.
    ///   - max: The maximum vector.
    /// - Returns: The clamped vector.
    public func clamped(min: Vector3, max: Vector3) -> Vector3 {
        Vector3(
            x: Swift.max(min.x, Swift.min(max.x, x)),
            y: Swift.max(min.y, Swift.min(max.y, y)),
            z: Swift.max(min.z, Swift.min(max.z, z))
        )
    }

    // MARK: - Operators

    /// Adds two vectors component-wise.
    public static func + (lhs: Vector3, rhs: Vector3) -> Vector3 {
        Vector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    /// Subtracts two vectors component-wise.
    public static func - (lhs: Vector3, rhs: Vector3) -> Vector3 {
        Vector3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    /// Multiplies a vector by a scalar.
    public static func * (lhs: Vector3, rhs: Math) -> Vector3 {
        Vector3(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }

    /// Multiplies a scalar by a vector.
    public static func * (lhs: Math, rhs: Vector3) -> Vector3 {
        Vector3(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }

    /// Component-wise multiplication (Hadamard product).
    public static func * (lhs: Vector3, rhs: Vector3) -> Vector3 {
        Vector3(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
    }

    /// Divides a vector by a scalar.
    public static func / (lhs: Vector3, rhs: Math) -> Vector3 {
        Vector3(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }

    /// Negates a vector.
    public static prefix func - (vector: Vector3) -> Vector3 {
        Vector3(x: -vector.x, y: -vector.y, z: -vector.z)
    }

    /// Adds another vector to this vector.
    public static func += (lhs: inout Vector3, rhs: Vector3) {
        lhs = lhs + rhs
    }

    /// Subtracts another vector from this vector.
    public static func -= (lhs: inout Vector3, rhs: Vector3) {
        lhs = lhs - rhs
    }

    /// Multiplies this vector by a scalar.
    public static func *= (lhs: inout Vector3, rhs: Math) {
        lhs = lhs * rhs
    }

    /// Divides this vector by a scalar.
    public static func /= (lhs: inout Vector3, rhs: Math) {
        lhs = lhs / rhs
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        "Vector3(x: \(x), y: \(y), z: \(z))"
    }
}
