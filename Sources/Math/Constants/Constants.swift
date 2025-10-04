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
/// let speedOfLight = Constants.Physics.c
/// let hubble = Constants.Astronomy.hubbleConstant
/// let goldenRatio = Constants.Extended.φ
/// ```
public struct Constants {

    /// Basic mathematical constants (π, e, √2, √3).
    ///
    /// Access fundamental mathematical values like pi, Euler's number,
    /// and common square roots.
    public typealias Math = MathConstants

    /// Extended mathematical constants (φ, γ, τ, and many more).
    ///
    /// Includes transcendental numbers, special constants, trigonometric values,
    /// and constants from number theory and chaos theory.
    public typealias Extended = ExtendedMathConstants

    /// Fundamental physical constants with units.
    ///
    /// Includes universal constants (c, G, h), electromagnetic constants (e, ε₀, μ₀),
    /// atomic constants (m_e, m_p, N_A), and thermodynamic constants (k_B, σ).
    /// All values include proper SI units using MathUnit.
    public typealias Physics = PhysicsConstants

    /// Astronomical and cosmological constants with units.
    ///
    /// Includes properties of celestial bodies (solar mass, Earth mass),
    /// astronomical distances (AU, parsec, light-year), and cosmological
    /// parameters (Hubble constant). All values include proper units.
    public typealias Astronomy = AstronomyConstants
}
