//
//  Constants.swift
//  Math
//
//  Created by Hanna Skairipa on 9/20/25.
//

// MARK: - Constants

/// A namespace for organizing groups of well-known constants.
///
/// The `Constants` structure provides convenient access to categories
/// of mathematical and scientific constants via type aliases. This helps
/// keep related values grouped together without polluting the global scope.
///
/// Example usage:
///
/// ```swift
/// let pi = Constants.Math.pi
/// let hubble = Constants.Astronomy.hubbleConstant
/// ```
public struct Constants {
    
    /// Mathematical constants (e.g. π, e, φ).
    public typealias Math = MathConstants
    
    /// Astronomy and physics constants
    /// (e.g. speed of light, Hubble constant, gravitational constant).
    public typealias Astronomy = AstronomyConstants
}
