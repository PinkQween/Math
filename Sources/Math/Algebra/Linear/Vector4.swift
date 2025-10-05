//
//  Vector4.swift
//  Math
//
//  4D vector for homogeneous coordinates in 3D graphics
//

/// A 4D vector with x, y, z, and w components.
///
/// `Vector4` is primarily used for homogeneous coordinates in 3D graphics,
/// enabling efficient representation of transformations including translation,
/// rotation, scaling, and perspective projection.
///
/// ### Example Usage
/// ```swift
/// // Homogeneous point (w = 1)
/// let point = Vector4(x: 1, y: 2, z: 3, w: 1)
///
/// // Homogeneous direction (w = 0)
/// let direction = Vector4(x: 0, y: 1, z: 0, w: 0)
///
/// // RGBA color
/// let color = Vector4(x: 1, y: 0, z: 0, w: 1) // Red
/// ```
public struct Vector4: Equatable, CustomStringConvertible, Hashable, Sendable {
    // MARK: - Properties

    /// The x-component of the vector.
    public var x: Math

    /// The y-component of the vector.
    public var y: Math

    /// The z-component of the vector.
    public var z: Math

    /// The w-component of the vector (1 for points, 0 for directions).
    public var w: Math

    // MARK: - Initialization

    /// Creates a new 4D vector with the given components.
    ///
    /// - Parameters:
    ///   - x: The x-component.
    ///   - y: The y-component.
    ///   - z: The z-component.
    ///   - w: The w-component (default is 1 for points).
    public init(x: Math = 0, y: Math = 0, z: Math = 0, w: Math = 1) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    /// Creates a 4D vector from a 3D vector.
    ///
    /// - Parameters:
    ///   - vector3: The 3D vector.
    ///   - w: The w-component (1 for points, 0 for directions).
    public init(_ vector3: Vector3, w: Math = 1) {
        self.x = vector3.x
        self.y = vector3.y
        self.z = vector3.z
        self.w = w
    }

    /// Creates a 4D vector from a 2D vector.
    ///
    /// - Parameters:
    ///   - vector2: The 2D vector.
    ///   - z: The z-component.
    ///   - w: The w-component.
    public init(_ vector2: Vector2, z: Math = 0, w: Math = 1) {
        self.x = vector2.x
        self.y = vector2.y
        self.z = z
        self.w = w
    }

    // MARK: - Common Vectors

    /// A vector with all components set to zero.
    public static let zero = Vector4(x: 0, y: 0, z: 0, w: 0)

    /// A vector with all components set to one.
    public static let one = Vector4(x: 1, y: 1, z: 1, w: 1)

    // MARK: - Computed Properties

    /// The length (magnitude) of the vector.
    public var length: Math {
        Math.sqrt(x * x + y * y + z * z + w * w)
    }

    /// The squared length of the vector (faster than `length`).
    public var lengthSquared: Math {
        x * x + y * y + z * z + w * w
    }

    /// A normalized version of this vector (length = 1).
    ///
    /// Returns `zero` if the vector has zero length.
    public var normalized: Vector4 {
        let len = length
        guard len > 0 else { return .zero }
        return Vector4(x: x / len, y: y / len, z: z / len, w: w / len)
    }

    /// Returns the xyz components as a Vector3.
    public var xyz: Vector3 {
        Vector3(x: x, y: y, z: z)
    }

    /// Returns the xy components as a Vector2.
    public var xy: Vector2 {
        Vector2(x: x, y: y)
    }

    /// Converts homogeneous coordinates to 3D coordinates by perspective division.
    ///
    /// - Returns: A Vector3 with components divided by w.
    public var perspectiveDivide: Vector3 {
        guard w != 0 else { return Vector3(x: x, y: y, z: z) }
        return Vector3(x: x / w, y: y / w, z: z / w)
    }

    // MARK: - Vector Operations

    /// Computes the dot product with another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The dot product.
    public func dot(_ other: Vector4) -> Math {
        x * other.x + y * other.y + z * other.z + w * other.w
    }

    /// Returns the distance to another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The distance between the vectors.
    public func distance(to other: Vector4) -> Math {
        (other - self).length
    }

    /// Returns the squared distance to another vector.
    ///
    /// - Parameter other: The other vector.
    /// - Returns: The squared distance between the vectors.
    public func distanceSquared(to other: Vector4) -> Math {
        (other - self).lengthSquared
    }

    /// Linearly interpolates between this vector and another.
    ///
    /// - Parameters:
    ///   - other: The target vector.
    ///   - t: The interpolation factor (0 = this vector, 1 = other vector).
    /// - Returns: The interpolated vector.
    public func lerp(to other: Vector4, t: Math) -> Vector4 {
        self + (other - self) * t
    }

    /// Clamps each component of the vector between min and max values.
    ///
    /// - Parameters:
    ///   - min: The minimum vector.
    ///   - max: The maximum vector.
    /// - Returns: The clamped vector.
    public func clamped(min: Vector4, max: Vector4) -> Vector4 {
        Vector4(
            x: Swift.max(min.x, Swift.min(max.x, x)),
            y: Swift.max(min.y, Swift.min(max.y, y)),
            z: Swift.max(min.z, Swift.min(max.z, z)),
            w: Swift.max(min.w, Swift.min(max.w, w))
        )
    }

    // MARK: - Operators

    /// Adds two vectors component-wise.
    public static func + (lhs: Vector4, rhs: Vector4) -> Vector4 {
        Vector4(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z, w: lhs.w + rhs.w)
    }

    /// Subtracts two vectors component-wise.
    public static func - (lhs: Vector4, rhs: Vector4) -> Vector4 {
        Vector4(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z, w: lhs.w - rhs.w)
    }

    /// Multiplies a vector by a scalar.
    public static func * (lhs: Vector4, rhs: Math) -> Vector4 {
        Vector4(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs, w: lhs.w * rhs)
    }

    /// Multiplies a scalar by a vector.
    public static func * (lhs: Math, rhs: Vector4) -> Vector4 {
        Vector4(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z, w: lhs * rhs.w)
    }

    /// Component-wise multiplication (Hadamard product).
    public static func * (lhs: Vector4, rhs: Vector4) -> Vector4 {
        Vector4(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z, w: lhs.w * rhs.w)
    }

    /// Divides a vector by a scalar.
    public static func / (lhs: Vector4, rhs: Math) -> Vector4 {
        Vector4(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs, w: lhs.w / rhs)
    }

    /// Negates a vector.
    public static prefix func - (vector: Vector4) -> Vector4 {
        Vector4(x: -vector.x, y: -vector.y, z: -vector.z, w: -vector.w)
    }

    /// Adds another vector to this vector.
    public static func += (lhs: inout Vector4, rhs: Vector4) {
        lhs = lhs + rhs
    }

    /// Subtracts another vector from this vector.
    public static func -= (lhs: inout Vector4, rhs: Vector4) {
        lhs = lhs - rhs
    }

    /// Multiplies this vector by a scalar.
    public static func *= (lhs: inout Vector4, rhs: Math) {
        lhs = lhs * rhs
    }

    /// Divides this vector by a scalar.
    public static func /= (lhs: inout Vector4, rhs: Math) {
        lhs = lhs / rhs
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        "Vector4(x: \(x), y: \(y), z: \(z), w: \(w))"
    }
}
