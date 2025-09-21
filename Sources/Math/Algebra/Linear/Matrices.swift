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
}
