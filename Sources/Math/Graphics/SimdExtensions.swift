//
//  SimdExtensions.swift
//  Math
//
//  SIMD matrix utilities for graphics rendering
//

#if canImport(simd)
import simd

// MARK: - Matrix Creation from Math

extension Math {
    /// Creates a perspective projection matrix
    /// - Parameters:
    ///   - fov: Field of view in radians
    ///   - aspect: Aspect ratio (width/height)
    ///   - near: Near clipping plane
    ///   - far: Far clipping plane
    public static func makePerspectiveMatrix(fov: Math, aspect: Math, near: Math, far: Math) -> simd_float4x4 {
        guard let fovF = fov.asDouble,
              let aspectF = aspect.asDouble,
              let nearF = near.asDouble,
              let farF = far.asDouble else {
            return matrix_identity_float4x4
        }

        let fovRad = Float(fovF)
        let halfFov = fovRad * 0.5
        let tanHalfFov = tanf(halfFov)

        let y = 1.0 / tanHalfFov
        let x = y / Float(aspectF)
        let z = Float(farF) / (Float(nearF) - Float(farF))

        return simd_float4x4(
            simd_float4(x, 0, 0, 0),
            simd_float4(0, y, 0, 0),
            simd_float4(0, 0, z, -1),
            simd_float4(0, 0, z * Float(nearF), 0)
        )
    }

    /// Creates a look-at view matrix
    /// - Parameters:
    ///   - eye: Camera position
    ///   - target: Look-at target position
    ///   - up: Up vector
    public static func makeLookAtMatrix(eye: (Math, Math, Math),
                                        target: (Math, Math, Math),
                                        up: (Math, Math, Math)) -> simd_float4x4 {
        guard let eyeX = eye.0.asDouble, let eyeY = eye.1.asDouble, let eyeZ = eye.2.asDouble,
              let targetX = target.0.asDouble, let targetY = target.1.asDouble, let targetZ = target.2.asDouble,
              let upX = up.0.asDouble, let upY = up.1.asDouble, let upZ = up.2.asDouble else {
            return matrix_identity_float4x4
        }

        let eyeVec = simd_float3(Float(eyeX), Float(eyeY), Float(eyeZ))
        let targetVec = simd_float3(Float(targetX), Float(targetY), Float(targetZ))
        let upVec = simd_float3(Float(upX), Float(upY), Float(upZ))

        let z = simd_normalize(eyeVec - targetVec)
        let x = simd_normalize(simd_cross(upVec, z))
        let y = simd_cross(z, x)

        return simd_float4x4(
            simd_float4(x.x, y.x, z.x, 0),
            simd_float4(x.y, y.y, z.y, 0),
            simd_float4(x.z, y.z, z.z, 0),
            simd_float4(-simd_dot(x, eyeVec), -simd_dot(y, eyeVec), -simd_dot(z, eyeVec), 1)
        )
    }

    /// Creates a translation matrix
    public static func makeTranslationMatrix(_ x: Math, _ y: Math, _ z: Math) -> simd_float4x4 {
        guard let xF = x.asDouble, let yF = y.asDouble, let zF = z.asDouble else {
            return matrix_identity_float4x4
        }

        var matrix = matrix_identity_float4x4
        matrix.columns.3 = simd_float4(Float(xF), Float(yF), Float(zF), 1)
        return matrix
    }

    /// Creates a rotation matrix around X axis (pitch)
    public static func makeRotationX(_ angle: Math) -> simd_float4x4 {
        guard let angleF = angle.asDouble else {
            return matrix_identity_float4x4
        }

        let a = Float(angleF)
        let c = cosf(a)
        let s = sinf(a)

        return simd_float4x4(
            simd_float4(1, 0, 0, 0),
            simd_float4(0, c, s, 0),
            simd_float4(0, -s, c, 0),
            simd_float4(0, 0, 0, 1)
        )
    }

    /// Creates a rotation matrix around Y axis (yaw)
    public static func makeRotationY(_ angle: Math) -> simd_float4x4 {
        guard let angleF = angle.asDouble else {
            return matrix_identity_float4x4
        }

        let a = Float(angleF)
        let c = cosf(a)
        let s = sinf(a)

        return simd_float4x4(
            simd_float4(c, 0, s, 0),
            simd_float4(0, 1, 0, 0),
            simd_float4(-s, 0, c, 0),
            simd_float4(0, 0, 0, 1)
        )
    }

    /// Creates a rotation matrix around Z axis (roll)
    public static func makeRotationZ(_ angle: Math) -> simd_float4x4 {
        guard let angleF = angle.asDouble else {
            return matrix_identity_float4x4
        }

        let a = Float(angleF)
        let c = cosf(a)
        let s = sinf(a)

        return simd_float4x4(
            simd_float4(c, s, 0, 0),
            simd_float4(-s, c, 0, 0),
            simd_float4(0, 0, 1, 0),
            simd_float4(0, 0, 0, 1)
        )
    }

    /// Creates a scale matrix
    public static func makeScaleMatrix(_ x: Math, _ y: Math, _ z: Math) -> simd_float4x4 {
        guard let xF = x.asDouble, let yF = y.asDouble, let zF = z.asDouble else {
            return matrix_identity_float4x4
        }

        return simd_float4x4(
            simd_float4(Float(xF), 0, 0, 0),
            simd_float4(0, Float(yF), 0, 0),
            simd_float4(0, 0, Float(zF), 0),
            simd_float4(0, 0, 0, 1)
        )
    }
}

// MARK: - Math Array Conversion

extension Array where Element == Math {
    /// Converts an array of Math values to Float array for GPU
    public var asFloatArray: [Float] {
        compactMap { $0.asDouble }.map { Float($0) }
    }
}

#endif
