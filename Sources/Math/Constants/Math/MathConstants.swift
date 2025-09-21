//
//  MathConstants.swift
//  Math
//
//  Created by Hanna Skairipa on 9/20/25.
//

// MARK: - Math Constants

/// Well-known mathematical constants, provided with both
/// Unicode and ASCII aliases for convenience.
///
/// Use these constants for precise and consistent values
/// in calculations instead of redefining them in your code.
///
/// Example:
/// ```swift
/// // Circumference of a circle
/// let circumference = 2 * Constants.Math.π * radius
///
/// // Exponential growth
/// let growth = pow(Constants.Math.e, x)
/// ```
public struct MathConstants: Sendable {
    
    /// Euler’s number (≈ 2.718…), base of the natural logarithm.
    ///
    /// Unicode symbol: `Ɛ`
    public static let Ɛ = Math.Ɛ
    
    /// Euler’s number (≈ 2.718…), ASCII alias for ``Ɛ``.
    public static let e = Math.Ɛ
    
    /// The constant π (≈ 3.14159…), ratio of a circle’s circumference to its diameter.
    ///
    /// Unicode symbol: `π`
    public static let π = Math.π
    
    /// The constant π (≈ 3.14159…), ASCII alias for ``π``.
    public static let pi = Math.π
    
    /// The square root of 2 (≈ 1.41421…).
    public static let sqrt2 = Math.sqrt2
    
    /// The square root of 3 (≈ 1.73205…).
    public static let sqrt3 = Math.sqrt3
}
