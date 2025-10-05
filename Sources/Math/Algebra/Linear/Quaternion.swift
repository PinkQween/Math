//
//  Quaternion.swift
//  Math
//
//  Quaternions for 3D rotations in graphics and physics
//

/// A quaternion for representing 3D rotations.
///
/// Quaternions are a mathematical system that extends complex numbers and provides
/// an efficient, stable way to represent rotations in 3D space. They avoid gimbal lock
/// and are more efficient than rotation matrices for interpolation (slerp).
///
/// A quaternion has the form: q = w + xi + yj + zk
///
/// ### Example Usage
/// ```swift
/// // Create from axis-angle
/// let q = Quaternion(axis: Vector3(x: 0, y: 1, z: 0), angle: .pi / 2)
///
/// // Rotate a vector
/// let v = Vector3(x: 1, y: 0, z: 0)
/// let rotated = q.rotate(v)
///
/// // Combine rotations
/// let q2 = Quaternion(axis: Vector3(x: 1, y: 0, z: 0), angle: .pi / 4)
/// let combined = q * q2
///
/// // Smooth interpolation
/// let interpolated = q.slerp(to: q2, t: 0.5)
/// ```
public struct Quaternion: Equatable, CustomStringConvertible, Hashable, Sendable {
    // MARK: - Properties

    /// The scalar (real) part of the quaternion.
    public var w: Math

    /// The x-component of the vector (imaginary) part.
    public var x: Math

    /// The y-component of the vector (imaginary) part.
    public var y: Math

    /// The z-component of the vector (imaginary) part.
    public var z: Math

    // MARK: - Initialization

    /// Creates a quaternion with the given components.
    ///
    /// - Parameters:
    ///   - w: The scalar (real) part.
    ///   - x: The x-component of the vector part.
    ///   - y: The y-component of the vector part.
    ///   - z: The z-component of the vector part.
    public init(w: Math = 1, x: Math = 0, y: Math = 0, z: Math = 0) {
        self.w = w
        self.x = x
        self.y = y
        self.z = z
    }

    /// Creates a quaternion from an axis and angle.
    ///
    /// - Parameters:
    ///   - axis: The rotation axis (will be normalized).
    ///   - angle: The rotation angle in radians.
    public init(axis: Vector3, angle: Math) {
        let halfAngle = angle / 2
        let sinHalf = Math.sin(halfAngle)
        let normalized = axis.normalized

        self.w = Math.cos(halfAngle)
        self.x = normalized.x * sinHalf
        self.y = normalized.y * sinHalf
        self.z = normalized.z * sinHalf
    }

    /// Creates a quaternion from Euler angles (in radians).
    ///
    /// Uses ZYX rotation order (yaw, pitch, roll).
    ///
    /// - Parameters:
    ///   - pitch: Rotation around X-axis (radians).
    ///   - yaw: Rotation around Y-axis (radians).
    ///   - roll: Rotation around Z-axis (radians).
    public init(pitch: Math, yaw: Math, roll: Math) {
        let cy = Math.cos(yaw * 0.5)
        let sy = Math.sin(yaw * 0.5)
        let cp = Math.cos(pitch * 0.5)
        let sp = Math.sin(pitch * 0.5)
        let cr = Math.cos(roll * 0.5)
        let sr = Math.sin(roll * 0.5)

        self.w = cr * cp * cy + sr * sp * sy
        self.x = sr * cp * cy - cr * sp * sy
        self.y = cr * sp * cy + sr * cp * sy
        self.z = cr * cp * sy - sr * sp * cy
    }

    /// Creates a quaternion representing a rotation from one vector to another.
    ///
    /// - Parameters:
    ///   - from: The starting direction.
    ///   - to: The target direction.
    public init(from: Vector3, to: Vector3) {
        let fromNorm = from.normalized
        let toNorm = to.normalized

        let dot = fromNorm.dot(toNorm)

        // Vectors are parallel
        if dot >= 1.0 - Math(0.000001) {
            self = .identity
            return
        }

        // Vectors are opposite
        if dot <= Math(-1.0) + Math(0.000001) {
            // Find a perpendicular axis
            var axis = Vector3.right.cross(from)
            if axis.lengthSquared < Math(0.000001) {
                axis = Vector3.up.cross(from)
            }
            self.init(axis: axis.normalized, angle: .pi)
            return
        }

        let cross = fromNorm.cross(toNorm)
        let wVal = Math.sqrt((1 + dot) / 2)
        let s = 1 / (2 * wVal)
        self.init(
            w: wVal,
            x: cross.x * s,
            y: cross.y * s,
            z: cross.z * s
        )
    }

    // MARK: - Common Quaternions

    /// The identity quaternion (no rotation).
    public static let identity = Quaternion(w: 1, x: 0, y: 0, z: 0)

    // MARK: - Computed Properties

    /// The magnitude (length) of the quaternion.
    public var length: Math {
        Math.sqrt(w * w + x * x + y * y + z * z)
    }

    /// The squared magnitude of the quaternion.
    public var lengthSquared: Math {
        w * w + x * x + y * y + z * z
    }

    /// A normalized version of this quaternion (length = 1).
    public var normalized: Quaternion {
        let len = length
        guard len > 0 else { return .identity }
        return Quaternion(w: w / len, x: x / len, y: y / len, z: z / len)
    }

    /// The conjugate of this quaternion.
    ///
    /// For unit quaternions, the conjugate equals the inverse.
    public var conjugate: Quaternion {
        Quaternion(w: w, x: -x, y: -y, z: -z)
    }

    /// The inverse of this quaternion.
    public var inverse: Quaternion {
        let lenSq = lengthSquared
        guard lenSq > 0 else { return .identity }
        let conj = conjugate
        return Quaternion(
            w: conj.w / lenSq,
            x: conj.x / lenSq,
            y: conj.y / lenSq,
            z: conj.z / lenSq
        )
    }

    /// The axis of rotation.
    public var axis: Vector3 {
        let s = Math.sqrt(1 - w * w)
        guard s > Math(0.001) else { return Vector3.up }
        return Vector3(x: x / s, y: y / s, z: z / s)
    }

    /// The angle of rotation in radians.
    public var angle: Math {
        2 * Math.acos(w)
    }

    /// Converts the quaternion to Euler angles (pitch, yaw, roll) in radians.
    public var eulerAngles: (pitch: Math, yaw: Math, roll: Math) {
        // Roll (x-axis rotation)
        let sinr_cosp = 2 * (w * x + y * z)
        let cosr_cosp = 1 - 2 * (x * x + y * y)
        let roll = Math.atan2(sinr_cosp, cosr_cosp)

        // Pitch (y-axis rotation)
        let sinp = 2 * (w * y - z * x)
        let pitch: Math
        if sinp >= 1 || sinp <= -1 {
            // Gimbal lock
            pitch = (sinp >= 1) ? (.pi / 2) : (-.pi / 2)
        } else {
            pitch = Math.asin(sinp)
        }

        // Yaw (z-axis rotation)
        let siny_cosp = 2 * (w * z + x * y)
        let cosy_cosp = 1 - 2 * (y * y + z * z)
        let yaw = Math.atan2(siny_cosp, cosy_cosp)

        return (pitch, yaw, roll)
    }

    // MARK: - Operations

    /// Computes the dot product with another quaternion.
    ///
    /// - Parameter other: The other quaternion.
    /// - Returns: The dot product.
    public func dot(_ other: Quaternion) -> Math {
        w * other.w + x * other.x + y * other.y + z * other.z
    }

    /// Rotates a 3D vector by this quaternion.
    ///
    /// - Parameter vector: The vector to rotate.
    /// - Returns: The rotated vector.
    public func rotate(_ vector: Vector3) -> Vector3 {
        // Using formula: v' = q * v * q^-1
        // Optimized version: v' = v + 2 * cross(q.xyz, cross(q.xyz, v) + q.w * v)
        let qVec = Vector3(x: x, y: y, z: z)
        let cross1 = qVec.cross(vector)
        let cross2 = qVec.cross(cross1 + vector * w)
        return vector + cross2 * 2
    }

    /// Spherical linear interpolation between two quaternions.
    ///
    /// Provides smooth interpolation for rotations.
    ///
    /// - Parameters:
    ///   - other: The target quaternion.
    ///   - t: The interpolation factor (0 = this quaternion, 1 = other quaternion).
    /// - Returns: The interpolated quaternion.
    public func slerp(to other: Quaternion, t: Math) -> Quaternion {
        var cosHalfTheta = self.dot(other)
        var end = other

        // Take the shorter path
        if cosHalfTheta < 0 {
            end = Quaternion(w: -end.w, x: -end.x, y: -end.y, z: -end.z)
            cosHalfTheta = -cosHalfTheta
        }

        // If quaternions are very close, use linear interpolation
        if cosHalfTheta >= 1.0 - Math(0.001) {
            return Quaternion(
                w: w + (end.w - w) * t,
                x: x + (end.x - x) * t,
                y: y + (end.y - y) * t,
                z: z + (end.z - z) * t
            ).normalized
        }

        let halfTheta = Math.acos(cosHalfTheta)
        let sinHalfTheta = Math.sqrt(1 - cosHalfTheta * cosHalfTheta)

        let ratioA = Math.sin((1 - t) * halfTheta) / sinHalfTheta
        let ratioB = Math.sin(t * halfTheta) / sinHalfTheta

        return Quaternion(
            w: w * ratioA + end.w * ratioB,
            x: x * ratioA + end.x * ratioB,
            y: y * ratioA + end.y * ratioB,
            z: z * ratioA + end.z * ratioB
        )
    }

    // MARK: - Operators

    /// Multiplies two quaternions (combines rotations).
    ///
    /// Note: Quaternion multiplication is not commutative (q1 * q2 ≠ q2 * q1).
    public static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        Quaternion(
            w: lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z,
            x: lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y,
            y: lhs.w * rhs.y - lhs.x * rhs.z + lhs.y * rhs.w + lhs.z * rhs.x,
            z: lhs.w * rhs.z + lhs.x * rhs.y - lhs.y * rhs.x + lhs.z * rhs.w
        )
    }

    /// Multiplies a quaternion by a scalar.
    public static func * (lhs: Quaternion, rhs: Math) -> Quaternion {
        Quaternion(w: lhs.w * rhs, x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }

    /// Adds two quaternions component-wise.
    public static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        Quaternion(w: lhs.w + rhs.w, x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    /// Subtracts two quaternions component-wise.
    public static func - (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        Quaternion(w: lhs.w - rhs.w, x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    /// Negates a quaternion.
    public static prefix func - (quaternion: Quaternion) -> Quaternion {
        Quaternion(w: -quaternion.w, x: -quaternion.x, y: -quaternion.y, z: -quaternion.z)
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        "Quaternion(w: \(w), x: \(x), y: \(y), z: \(z))"
    }
}
