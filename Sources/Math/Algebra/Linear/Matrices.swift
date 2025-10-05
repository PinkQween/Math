//
//  Matrices.swift
//  Math
//
//  Created by Hanna Skairipa on 9/21/25.
//

/// A matrix of ``Math`` numbers, supporting element access and storage.
///
/// `Matrix` stores elements in **row-major order**. Rows and columns are
/// fixed after initialization. Elements can be accessed and modified
/// using subscripts.
///
/// ### How to Use
/// ```swift
/// // Initialize a 3x3 matrix filled with zeros
/// var matrix = Matrix(rows: 3, columns: 3)
///
/// // Initialize a 2x2 matrix with all elements set to 5
/// let filledMatrix = Matrix(rows: 2, columns: 2, initialValue: 5)
///
/// // Access and modify elements using subscripts
/// matrix[0, 0] = 1
/// matrix[1, 2] = 3
///
/// // Print the matrix
/// print(matrix)
///
/// // Output:
/// // [ 1, 0, 0 ]
/// // [ 0, 0, 3 ]
/// // [ 0, 0, 0 ]
/// ```
public struct Matrix: CustomStringConvertible, Equatable {
    // MARK: - Properties
    
    /// Number of rows in the matrix.
    public let rows: Int
    
    /// Number of columns in the matrix.
    public let columns: Int
    
    /// Internal storage of matrix elements in row-major order.
    private var grid: [Math]
    
    // MARK: - Initialization
    
    /// Creates a new matrix with the given number of rows and columns.
    ///
    /// All elements are initialized to `initialValue`.
    ///
    /// - Parameters:
    ///   - rows: The number of rows.
    ///   - columns: The number of columns.
    ///   - initialValue: The value to initialize each element with (default is `0`).
    public init(rows: Int, columns: Int, initialValue: Math = 0) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: initialValue, count: rows * columns)
    }
    
    // MARK: - Element Access
    
    /// Accesses the element at the specified row and column.
    ///
    /// - Parameters:
    ///   - row: The row index (0-based).
    ///   - column: The column index (0-based).
    /// - Returns: The element at the given position.
    public subscript(row: Int, column: Int) -> Math {
        get {
            precondition(row >= 0 && row < rows && column >= 0 && column < columns, "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            precondition(row >= 0 && row < rows && column >= 0 && column < columns, "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    
    // MARK: - Description
    
    /// A textual representation of the matrix.
    public var description: String {
        var result = ""
        for r in 0..<rows {
            let rowValues = (0..<columns).map { "\(self[r, $0])" }
            result += "[ " + rowValues.joined(separator: ", ") + " ]\n"
        }
        return result
    }
    
    // MARK: - Basic Operations
    
    /// Adds two matrices element-wise.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side matrix.
    ///   - rhs: Right-hand side matrix.
    /// - Returns: The resulting matrix after addition.
    public static func + (lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions must match")
        var result = Matrix(rows: lhs.rows, columns: lhs.columns)
        for r in 0..<lhs.rows {
            for c in 0..<lhs.columns {
                result[r, c] = lhs[r, c] + rhs[r, c]
            }
        }
        return result
    }
    
    /// Subtracts two matrices element-wise.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side matrix.
    ///   - rhs: Right-hand side matrix.
    /// - Returns: The resulting matrix after subtraction.
    public static func - (lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions must match")
        var result = Matrix(rows: lhs.rows, columns: lhs.columns)
        for r in 0..<lhs.rows {
            for c in 0..<lhs.columns {
                result[r, c] = lhs[r, c] - rhs[r, c]
            }
        }
        return result
    }
    
    /// Multiplies two matrices.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side matrix.
    ///   - rhs: Right-hand side matrix.
    /// - Returns: The resulting matrix after multiplication.
    /// - Note: The number of columns of `lhs` must equal the number of rows of `rhs`.
    public static func * (lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.columns == rhs.rows, "Matrix dimensions do not allow multiplication")
        var result = Matrix(rows: lhs.rows, columns: rhs.columns)
        for i in 0..<lhs.rows {
            for j in 0..<rhs.columns {
                var sum: Math = 0
                for k in 0..<lhs.columns {
                    sum += lhs[i, k] * rhs[k, j]
                }
                result[i, j] = sum
            }
        }
        return result
    }
    
    // MARK: - Equatable
    /// Returns `true` if two matrices have the same dimensions and all corresponding elements are equal.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side matrix.
    ///   - rhs: Right-hand side matrix.
    /// - Returns: `true` if matrices are equal, `false` otherwise.
    public static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        guard lhs.rows == rhs.rows && lhs.columns == rhs.columns else { return false }

        for r in 0..<lhs.rows {
            for c in 0..<lhs.columns {
                if !(lhs[r, c] == rhs[r, c]) { return false }
            }
        }

        return true
    }

    // MARK: - Factory Methods

    /// Creates an identity matrix of the specified size.
    ///
    /// - Parameter size: The dimension of the square identity matrix.
    /// - Returns: An identity matrix with 1s on the diagonal and 0s elsewhere.
    public static func identity(size: Int) -> Matrix {
        var result = Matrix(rows: size, columns: size)
        for i in 0..<size {
            result[i, i] = 1
        }
        return result
    }

    /// Creates a matrix from an array of rows.
    ///
    /// - Parameter rows: An array of row arrays.
    /// - Returns: A matrix initialized with the given rows.
    public static func from(rows: [[Math]]) -> Matrix {
        guard let firstRow = rows.first else {
            return Matrix(rows: 0, columns: 0)
        }

        let rowCount = rows.count
        let colCount = firstRow.count

        var result = Matrix(rows: rowCount, columns: colCount)
        for r in 0..<rowCount {
            for c in 0..<colCount {
                result[r, c] = rows[r][c]
            }
        }
        return result
    }

    // MARK: - Advanced Operations

    /// Returns the transpose of this matrix.
    ///
    /// The transpose flips the matrix over its diagonal, converting rows to columns.
    ///
    /// - Returns: The transposed matrix.
    public func transposed() -> Matrix {
        var result = Matrix(rows: columns, columns: rows)
        for r in 0..<rows {
            for c in 0..<columns {
                result[c, r] = self[r, c]
            }
        }
        return result
    }

    /// Computes the determinant of a square matrix.
    ///
    /// - Returns: The determinant value, or nil if the matrix is not square.
    public func determinant() -> Math? {
        guard rows == columns else { return nil }

        if rows == 1 {
            return self[0, 0]
        }

        if rows == 2 {
            return self[0, 0] * self[1, 1] - self[0, 1] * self[1, 0]
        }

        if rows == 3 {
            // Use rule of Sarrus for 3x3
            let a = self[0, 0] * self[1, 1] * self[2, 2]
            let b = self[0, 1] * self[1, 2] * self[2, 0]
            let c = self[0, 2] * self[1, 0] * self[2, 1]
            let d = self[0, 2] * self[1, 1] * self[2, 0]
            let e = self[0, 1] * self[1, 0] * self[2, 2]
            let f = self[0, 0] * self[1, 2] * self[2, 1]
            return a + b + c - d - e - f
        }

        // General case: cofactor expansion
        var det: Math = 0
        for c in 0..<columns {
            let cofactor = self.cofactor(row: 0, col: c)
            det += self[0, c] * cofactor
        }
        return det
    }

    /// Returns the inverse of this matrix.
    ///
    /// - Returns: The inverse matrix, or nil if the matrix is singular (not invertible).
    public func inverse() -> Matrix? {
        guard rows == columns else { return nil }
        guard let det = determinant(), det != 0 else { return nil }

        if rows == 2 {
            var result = Matrix(rows: 2, columns: 2)
            result[0, 0] = self[1, 1] / det
            result[0, 1] = -self[0, 1] / det
            result[1, 0] = -self[1, 0] / det
            result[1, 1] = self[0, 0] / det
            return result
        }

        // General case: adjugate matrix method
        var adjugate = Matrix(rows: rows, columns: columns)
        for r in 0..<rows {
            for c in 0..<columns {
                adjugate[c, r] = cofactor(row: r, col: c)
            }
        }

        var result = Matrix(rows: rows, columns: columns)
        for r in 0..<rows {
            for c in 0..<columns {
                result[r, c] = adjugate[r, c] / det
            }
        }
        return result
    }

    /// Scalar multiplication of the matrix.
    ///
    /// - Parameter scalar: The scalar value to multiply by.
    /// - Returns: The resulting matrix.
    public func scaled(by scalar: Math) -> Matrix {
        var result = Matrix(rows: rows, columns: columns)
        for r in 0..<rows {
            for c in 0..<columns {
                result[r, c] = self[r, c] * scalar
            }
        }
        return result
    }

    // MARK: - Helper Methods

    /// Computes the minor of an element (determinant of submatrix).
    private func minor(row: Int, col: Int) -> Math {
        let submatrix = submatrix(excludingRow: row, column: col)
        return submatrix.determinant() ?? 0
    }

    /// Computes the cofactor of an element.
    private func cofactor(row: Int, col: Int) -> Math {
        let sign = ((row + col) % 2 == 0) ? Math(1) : Math(-1)
        return sign * minor(row: row, col: col)
    }

    /// Returns a submatrix by removing the specified row and column.
    private func submatrix(excludingRow row: Int, column col: Int) -> Matrix {
        var result = Matrix(rows: rows - 1, columns: columns - 1)
        var destRow = 0
        for r in 0..<rows {
            if r == row { continue }
            var destCol = 0
            for c in 0..<columns {
                if c == col { continue }
                result[destRow, destCol] = self[r, c]
                destCol += 1
            }
            destRow += 1
        }
        return result
    }

    // MARK: - Matrix-Vector Operations

    /// Multiplies this matrix by a column vector.
    ///
    /// - Parameter vector: An array representing a column vector.
    /// - Returns: The resulting vector as an array.
    public func multiply(vector: [Math]) -> [Math] {
        precondition(vector.count == columns, "Vector length must match matrix columns")
        var result = [Math](repeating: 0, count: rows)
        for r in 0..<rows {
            var sum: Math = 0
            for c in 0..<columns {
                sum += self[r, c] * vector[c]
            }
            result[r] = sum
        }
        return result
    }

    /// Checks if this is a square matrix.
    public var isSquare: Bool {
        rows == columns
    }

    /// Checks if this is an identity matrix.
    public var isIdentity: Bool {
        guard isSquare else { return false }
        for r in 0..<rows {
            for c in 0..<columns {
                let expected: Math = (r == c) ? 1 : 0
                if self[r, c] != expected { return false }
            }
        }
        return true
    }
}
