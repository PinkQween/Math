//
//  Transform.swift
//  Math
//
//  Transformation matrices for 2D and 3D graphics
//

/// Transformation matrix utilities for 2D and 3D graphics.
///
/// Provides factory methods for creating common transformation matrices
/// including translation, rotation, scaling, and projection.
public enum Transform {

    // MARK: - 2D Transformations

    /// Creates a 2D translation matrix.
    ///
    /// - Parameters:
    ///   - x: Translation along the x-axis.
    ///   - y: Translation along the y-axis.
    /// - Returns: A 3x3 translation matrix for homogeneous 2D coordinates.
    public static func translate2D(x: Math, y: Math) -> Matrix {
        var m = Matrix.identity(size: 3)
        m[0, 2] = x
        m[1, 2] = y
        return m
    }

    /// Creates a 2D rotation matrix.
    ///
    /// - Parameter angle: The rotation angle in radians (counterclockwise).
    /// - Returns: A 3x3 rotation matrix.
    public static func rotate2D(angle: Math) -> Matrix {
        let cos = Math.cos(angle)
        let sin = Math.sin(angle)

        var m = Matrix.identity(size: 3)
        m[0, 0] = cos
        m[0, 1] = -sin
        m[1, 0] = sin
        m[1, 1] = cos
        return m
    }

    /// Creates a 2D scaling matrix.
    ///
    /// - Parameters:
    ///   - x: Scale factor along the x-axis.
    ///   - y: Scale factor along the y-axis.
    /// - Returns: A 3x3 scaling matrix.
    public static func scale2D(x: Math, y: Math) -> Matrix {
        var m = Matrix.identity(size: 3)
        m[0, 0] = x
        m[1, 1] = y
        return m
    }

    /// Creates a uniform 2D scaling matrix.
    ///
    /// - Parameter scale: The uniform scale factor.
    /// - Returns: A 3x3 scaling matrix.
    public static func scale2D(_ scale: Math) -> Matrix {
        scale2D(x: scale, y: scale)
    }

    // MARK: - 3D Transformations

    /// Creates a 3D translation matrix.
    ///
    /// - Parameters:
    ///   - x: Translation along the x-axis.
    ///   - y: Translation along the y-axis.
    ///   - z: Translation along the z-axis.
    /// - Returns: A 4x4 translation matrix.
    public static func translate3D(x: Math, y: Math, z: Math) -> Matrix {
        var m = Matrix.identity(size: 4)
        m[0, 3] = x
        m[1, 3] = y
        m[2, 3] = z
        return m
    }

    /// Creates a 3D translation matrix from a vector.
    ///
    /// - Parameter vector: The translation vector.
    /// - Returns: A 4x4 translation matrix.
    public static func translate3D(_ vector: Vector3) -> Matrix {
        translate3D(x: vector.x, y: vector.y, z: vector.z)
    }

    /// Creates a 3D rotation matrix around the X-axis.
    ///
    /// - Parameter angle: The rotation angle in radians.
    /// - Returns: A 4x4 rotation matrix.
    public static func rotateX(angle: Math) -> Matrix {
        let cos = Math.cos(angle)
        let sin = Math.sin(angle)

        var m = Matrix.identity(size: 4)
        m[1, 1] = cos
        m[1, 2] = -sin
        m[2, 1] = sin
        m[2, 2] = cos
        return m
    }

    /// Creates a 3D rotation matrix around the Y-axis.
    ///
    /// - Parameter angle: The rotation angle in radians.
    /// - Returns: A 4x4 rotation matrix.
    public static func rotateY(angle: Math) -> Matrix {
        let cos = Math.cos(angle)
        let sin = Math.sin(angle)

        var m = Matrix.identity(size: 4)
        m[0, 0] = cos
        m[0, 2] = sin
        m[2, 0] = -sin
        m[2, 2] = cos
        return m
    }

    /// Creates a 3D rotation matrix around the Z-axis.
    ///
    /// - Parameter angle: The rotation angle in radians.
    /// - Returns: A 4x4 rotation matrix.
    public static func rotateZ(angle: Math) -> Matrix {
        let cos = Math.cos(angle)
        let sin = Math.sin(angle)

        var m = Matrix.identity(size: 4)
        m[0, 0] = cos
        m[0, 1] = -sin
        m[1, 0] = sin
        m[1, 1] = cos
        return m
    }

    /// Creates a 3D rotation matrix around an arbitrary axis.
    ///
    /// Uses Rodrigues' rotation formula.
    ///
    /// - Parameters:
    ///   - axis: The rotation axis (will be normalized).
    ///   - angle: The rotation angle in radians.
    /// - Returns: A 4x4 rotation matrix.
    public static func rotate(axis: Vector3, angle: Math) -> Matrix {
        let normalized = axis.normalized
        let x = normalized.x
        let y = normalized.y
        let z = normalized.z

        let cos = Math.cos(angle)
        let sin = Math.sin(angle)
        let oneMinusCos = 1 - cos

        var m = Matrix.identity(size: 4)

        m[0, 0] = cos + x * x * oneMinusCos
        m[0, 1] = x * y * oneMinusCos - z * sin
        m[0, 2] = x * z * oneMinusCos + y * sin

        m[1, 0] = y * x * oneMinusCos + z * sin
        m[1, 1] = cos + y * y * oneMinusCos
        m[1, 2] = y * z * oneMinusCos - x * sin

        m[2, 0] = z * x * oneMinusCos - y * sin
        m[2, 1] = z * y * oneMinusCos + x * sin
        m[2, 2] = cos + z * z * oneMinusCos

        return m
    }

    /// Creates a 3D rotation matrix from a quaternion.
    ///
    /// - Parameter quaternion: The rotation quaternion.
    /// - Returns: A 4x4 rotation matrix.
    public static func rotate(_ quaternion: Quaternion) -> Matrix {
        let q = quaternion.normalized
        let xx = q.x * q.x
        let yy = q.y * q.y
        let zz = q.z * q.z
        let xy = q.x * q.y
        let xz = q.x * q.z
        let yz = q.y * q.z
        let wx = q.w * q.x
        let wy = q.w * q.y
        let wz = q.w * q.z

        var m = Matrix.identity(size: 4)

        m[0, 0] = 1 - 2 * (yy + zz)
        m[0, 1] = 2 * (xy - wz)
        m[0, 2] = 2 * (xz + wy)

        m[1, 0] = 2 * (xy + wz)
        m[1, 1] = 1 - 2 * (xx + zz)
        m[1, 2] = 2 * (yz - wx)

        m[2, 0] = 2 * (xz - wy)
        m[2, 1] = 2 * (yz + wx)
        m[2, 2] = 1 - 2 * (xx + yy)

        return m
    }

    /// Creates a 3D scaling matrix.
    ///
    /// - Parameters:
    ///   - x: Scale factor along the x-axis.
    ///   - y: Scale factor along the y-axis.
    ///   - z: Scale factor along the z-axis.
    /// - Returns: A 4x4 scaling matrix.
    public static func scale3D(x: Math, y: Math, z: Math) -> Matrix {
        var m = Matrix.identity(size: 4)
        m[0, 0] = x
        m[1, 1] = y
        m[2, 2] = z
        return m
    }

    /// Creates a uniform 3D scaling matrix.
    ///
    /// - Parameter scale: The uniform scale factor.
    /// - Returns: A 4x4 scaling matrix.
    public static func scale3D(_ scale: Math) -> Matrix {
        scale3D(x: scale, y: scale, z: scale)
    }

    /// Creates a 3D scaling matrix from a vector.
    ///
    /// - Parameter vector: The scale vector.
    /// - Returns: A 4x4 scaling matrix.
    public static func scale3D(_ vector: Vector3) -> Matrix {
        scale3D(x: vector.x, y: vector.y, z: vector.z)
    }

    // MARK: - View Matrices

    /// Creates a "look-at" view matrix.
    ///
    /// This positions the camera at `eye`, looking toward `target`, with `up` defining the upward direction.
    ///
    /// - Parameters:
    ///   - eye: The camera position.
    ///   - target: The point to look at.
    ///   - up: The up direction (typically [0, 1, 0]).
    /// - Returns: A 4x4 view matrix.
    public static func lookAt(eye: Vector3, target: Vector3, up: Vector3) -> Matrix {
        let forward = (target - eye).normalized
        let right = forward.cross(up.normalized).normalized
        let cameraUp = right.cross(forward)

        var m = Matrix.identity(size: 4)

        m[0, 0] = right.x
        m[0, 1] = right.y
        m[0, 2] = right.z
        m[0, 3] = -right.dot(eye)

        m[1, 0] = cameraUp.x
        m[1, 1] = cameraUp.y
        m[1, 2] = cameraUp.z
        m[1, 3] = -cameraUp.dot(eye)

        m[2, 0] = -forward.x
        m[2, 1] = -forward.y
        m[2, 2] = -forward.z
        m[2, 3] = forward.dot(eye)

        return m
    }

    // MARK: - Projection Matrices

    /// Creates a perspective projection matrix.
    ///
    /// - Parameters:
    ///   - fov: Field of view in radians.
    ///   - aspect: Aspect ratio (width / height).
    ///   - near: Near clipping plane distance.
    ///   - far: Far clipping plane distance.
    /// - Returns: A 4x4 perspective projection matrix.
    public static func perspective(fov: Math, aspect: Math, near: Math, far: Math) -> Matrix {
        let tanHalfFov = Math.tan(fov / 2)

        var m = Matrix(rows: 4, columns: 4)

        m[0, 0] = 1 / (aspect * tanHalfFov)
        m[1, 1] = 1 / tanHalfFov
        m[2, 2] = -(far + near) / (far - near)
        m[2, 3] = -(2 * far * near) / (far - near)
        m[3, 2] = -1

        return m
    }

    /// Creates an orthographic projection matrix.
    ///
    /// - Parameters:
    ///   - left: Left edge of the view volume.
    ///   - right: Right edge of the view volume.
    ///   - bottom: Bottom edge of the view volume.
    ///   - top: Top edge of the view volume.
    ///   - near: Near clipping plane distance.
    ///   - far: Far clipping plane distance.
    /// - Returns: A 4x4 orthographic projection matrix.
    public static func orthographic(left: Math, right: Math, bottom: Math, top: Math, near: Math, far: Math) -> Matrix {
        var m = Matrix.identity(size: 4)

        m[0, 0] = 2 / (right - left)
        m[1, 1] = 2 / (top - bottom)
        m[2, 2] = -2 / (far - near)

        m[0, 3] = -(right + left) / (right - left)
        m[1, 3] = -(top + bottom) / (top - bottom)
        m[2, 3] = -(far + near) / (far - near)

        return m
    }

    // MARK: - Compound Transformations

    /// Creates a transformation matrix combining translation, rotation, and scale.
    ///
    /// The order of transformations is: Scale → Rotate → Translate (SRT).
    ///
    /// - Parameters:
    ///   - translation: The translation vector.
    ///   - rotation: The rotation quaternion.
    ///   - scale: The scale vector.
    /// - Returns: A 4x4 transformation matrix.
    public static func trs(translation: Vector3, rotation: Quaternion, scale: Vector3) -> Matrix {
        let t = translate3D(translation)
        let r = rotate(rotation)
        let s = scale3D(scale)
        return t * r * s
    }
}
