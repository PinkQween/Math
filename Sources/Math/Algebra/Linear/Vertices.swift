//
//  Vertices.swift
//  Math
//
//  Vertex buffer for 3D graphics and geometry
//

/// A collection of vertices for 3D meshes and geometry.
///
/// `Vertices` stores and manages vertex data for 3D graphics applications,
/// providing efficient access to positions, normals, and texture coordinates.
///
/// ### Example Usage
/// ```swift
/// // Create vertices for a triangle
/// var vertices = Vertices()
/// vertices.addVertex(position: Vector3(x: 0, y: 1, z: 0))
/// vertices.addVertex(position: Vector3(x: -1, y: -1, z: 0))
/// vertices.addVertex(position: Vector3(x: 1, y: -1, z: 0))
///
/// // Access vertex data
/// let firstPosition = vertices.positions[0]
/// let bounds = vertices.boundingBox
/// ```
public struct Vertices: Equatable, CustomStringConvertible {
    // MARK: - Properties

    /// The positions of all vertices.
    public private(set) var positions: [Vector3]

    /// The normals of all vertices (optional).
    public private(set) var normals: [Vector3]

    /// The texture coordinates of all vertices (optional).
    public private(set) var texCoords: [Vector2]

    /// The colors of all vertices (optional, stored as Vector4 for RGBA).
    public private(set) var colors: [Vector4]

    // MARK: - Initialization

    /// Creates an empty vertex buffer.
    public init() {
        self.positions = []
        self.normals = []
        self.texCoords = []
        self.colors = []
    }

    /// Creates a vertex buffer with the given positions.
    ///
    /// - Parameter positions: The vertex positions.
    public init(positions: [Vector3]) {
        self.positions = positions
        self.normals = []
        self.texCoords = []
        self.colors = []
    }

    /// Creates a vertex buffer with positions and normals.
    ///
    /// - Parameters:
    ///   - positions: The vertex positions.
    ///   - normals: The vertex normals.
    public init(positions: [Vector3], normals: [Vector3]) {
        precondition(positions.count == normals.count, "Positions and normals must have the same count")
        self.positions = positions
        self.normals = normals
        self.texCoords = []
        self.colors = []
    }

    // MARK: - Computed Properties

    /// The number of vertices.
    public var count: Int {
        positions.count
    }

    /// Whether the vertex buffer is empty.
    public var isEmpty: Bool {
        positions.isEmpty
    }

    /// Whether this vertex buffer has normal data.
    public var hasNormals: Bool {
        !normals.isEmpty
    }

    /// Whether this vertex buffer has texture coordinate data.
    public var hasTexCoords: Bool {
        !texCoords.isEmpty
    }

    /// Whether this vertex buffer has color data.
    public var hasColors: Bool {
        !colors.isEmpty
    }

    /// The axis-aligned bounding box of all vertices.
    public var boundingBox: (min: Vector3, max: Vector3)? {
        guard !positions.isEmpty else { return nil }

        var min = positions[0]
        var max = positions[0]

        for position in positions {
            min = Vector3(
                x: Swift.min(min.x, position.x),
                y: Swift.min(min.y, position.y),
                z: Swift.min(min.z, position.z)
            )
            max = Vector3(
                x: Swift.max(max.x, position.x),
                y: Swift.max(max.y, position.y),
                z: Swift.max(max.z, position.z)
            )
        }

        return (min, max)
    }

    /// The center point of the bounding box.
    public var center: Vector3? {
        guard let bbox = boundingBox else { return nil }
        return (bbox.min + bbox.max) / 2
    }

    // MARK: - Modification

    /// Adds a vertex with the given position.
    ///
    /// - Parameter position: The vertex position.
    public mutating func addVertex(position: Vector3) {
        positions.append(position)
    }

    /// Adds a vertex with position and normal.
    ///
    /// - Parameters:
    ///   - position: The vertex position.
    ///   - normal: The vertex normal.
    public mutating func addVertex(position: Vector3, normal: Vector3) {
        positions.append(position)
        normals.append(normal)
    }

    /// Adds a vertex with position, normal, and texture coordinates.
    ///
    /// - Parameters:
    ///   - position: The vertex position.
    ///   - normal: The vertex normal.
    ///   - texCoord: The texture coordinate.
    public mutating func addVertex(position: Vector3, normal: Vector3, texCoord: Vector2) {
        positions.append(position)
        normals.append(normal)
        texCoords.append(texCoord)
    }

    /// Adds a vertex with all attributes.
    ///
    /// - Parameters:
    ///   - position: The vertex position.
    ///   - normal: The vertex normal.
    ///   - texCoord: The texture coordinate.
    ///   - color: The vertex color (RGBA).
    public mutating func addVertex(position: Vector3, normal: Vector3, texCoord: Vector2, color: Vector4) {
        positions.append(position)
        normals.append(normal)
        texCoords.append(texCoord)
        colors.append(color)
    }

    /// Removes all vertices.
    public mutating func removeAll() {
        positions.removeAll()
        normals.removeAll()
        texCoords.removeAll()
        colors.removeAll()
    }

    // MARK: - Transformations

    /// Returns a new vertex buffer with all positions transformed by a matrix.
    ///
    /// - Parameter matrix: The 4x4 transformation matrix.
    /// - Returns: A new vertex buffer with transformed positions.
    public func transformed(by matrix: Matrix) -> Vertices {
        precondition(matrix.rows == 4 && matrix.columns == 4, "Matrix must be 4x4")

        var result = self
        result.positions = positions.map { position in
            let vec4 = Vector4(position, w: 1)
            let transformed = matrix.multiply(vector: [vec4.x, vec4.y, vec4.z, vec4.w])
            return Vector3(
                x: transformed[0],
                y: transformed[1],
                z: transformed[2]
            )
        }

        // Transform normals (only rotation, ignore translation)
        if hasNormals {
            result.normals = normals.map { normal in
                let vec4 = Vector4(normal, w: 0) // w=0 for directions
                let transformed = matrix.multiply(vector: [vec4.x, vec4.y, vec4.z, vec4.w])
                return Vector3(
                    x: transformed[0],
                    y: transformed[1],
                    z: transformed[2]
                ).normalized
            }
        }

        return result
    }

    /// Returns a new vertex buffer with all positions translated.
    ///
    /// - Parameter offset: The translation offset.
    /// - Returns: A new vertex buffer with translated positions.
    public func translated(by offset: Vector3) -> Vertices {
        var result = self
        result.positions = positions.map { $0 + offset }
        return result
    }

    /// Returns a new vertex buffer with all positions scaled.
    ///
    /// - Parameter scale: The scale factor.
    /// - Returns: A new vertex buffer with scaled positions.
    public func scaled(by scale: Vector3) -> Vertices {
        var result = self
        result.positions = positions.map { Vector3(x: $0.x * scale.x, y: $0.y * scale.y, z: $0.z * scale.z) }
        return result
    }

    /// Returns a new vertex buffer with all positions scaled uniformly.
    ///
    /// - Parameter scale: The uniform scale factor.
    /// - Returns: A new vertex buffer with scaled positions.
    public func scaled(by scale: Math) -> Vertices {
        var result = self
        result.positions = positions.map { $0 * scale }
        return result
    }

    // MARK: - Normal Generation

    /// Generates smooth normals by averaging face normals.
    ///
    /// - Parameter indices: The triangle indices (in groups of 3).
    /// - Returns: A new vertex buffer with generated normals.
    public func withGeneratedNormals(indices: [Int]) -> Vertices {
        precondition(indices.count % 3 == 0, "Indices must be in groups of 3 (triangles)")

        var result = self
        var vertexNormals = Array(repeating: Vector3.zero, count: positions.count)

        // Calculate face normals and accumulate
        for i in stride(from: 0, to: indices.count, by: 3) {
            let i0 = indices[i]
            let i1 = indices[i + 1]
            let i2 = indices[i + 2]

            let v0 = positions[i0]
            let v1 = positions[i1]
            let v2 = positions[i2]

            let edge1 = v1 - v0
            let edge2 = v2 - v0
            let faceNormal = edge1.cross(edge2)

            vertexNormals[i0] += faceNormal
            vertexNormals[i1] += faceNormal
            vertexNormals[i2] += faceNormal
        }

        // Normalize
        result.normals = vertexNormals.map { $0.normalized }

        return result
    }

    // MARK: - Factory Methods

    /// Creates a cube with vertices.
    ///
    /// - Parameter size: The size of the cube.
    /// - Returns: A vertex buffer containing a cube.
    public static func cube(size: Math = 1) -> Vertices {
        let half = size / 2
        var vertices = Vertices()

        // Front face
        vertices.addVertex(position: Vector3(x: -half, y: -half, z: half))
        vertices.addVertex(position: Vector3(x: half, y: -half, z: half))
        vertices.addVertex(position: Vector3(x: half, y: half, z: half))
        vertices.addVertex(position: Vector3(x: -half, y: half, z: half))

        // Back face
        vertices.addVertex(position: Vector3(x: -half, y: -half, z: -half))
        vertices.addVertex(position: Vector3(x: half, y: -half, z: -half))
        vertices.addVertex(position: Vector3(x: half, y: half, z: -half))
        vertices.addVertex(position: Vector3(x: -half, y: half, z: -half))

        return vertices
    }

    /// Creates a plane with vertices.
    ///
    /// - Parameters:
    ///   - width: The width of the plane.
    ///   - height: The height of the plane.
    /// - Returns: A vertex buffer containing a plane.
    public static func plane(width: Math = 1, height: Math = 1) -> Vertices {
        let halfWidth = width / 2
        let halfHeight = height / 2

        var vertices = Vertices()
        vertices.addVertex(
            position: Vector3(x: -halfWidth, y: 0, z: -halfHeight),
            normal: Vector3.up,
            texCoord: Vector2(x: 0, y: 0)
        )
        vertices.addVertex(
            position: Vector3(x: halfWidth, y: 0, z: -halfHeight),
            normal: Vector3.up,
            texCoord: Vector2(x: 1, y: 0)
        )
        vertices.addVertex(
            position: Vector3(x: halfWidth, y: 0, z: halfHeight),
            normal: Vector3.up,
            texCoord: Vector2(x: 1, y: 1)
        )
        vertices.addVertex(
            position: Vector3(x: -halfWidth, y: 0, z: halfHeight),
            normal: Vector3.up,
            texCoord: Vector2(x: 0, y: 1)
        )

        return vertices
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        var desc = "Vertices(count: \(count)"
        if hasNormals { desc += ", normals: true" }
        if hasTexCoords { desc += ", texCoords: true" }
        if hasColors { desc += ", colors: true" }
        desc += ")"
        return desc
    }

    // MARK: - Subscript

    /// Accesses the position of a vertex at the given index.
    ///
    /// - Parameter index: The vertex index.
    /// - Returns: The position of the vertex.
    public subscript(index: Int) -> Vector3 {
        get { positions[index] }
        set { positions[index] = newValue }
    }
}
