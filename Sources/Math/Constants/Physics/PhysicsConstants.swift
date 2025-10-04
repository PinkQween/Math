//
//  PhysicsConstants.swift
//  Math
//
//  Created by Hanna Skairipa on 10/4/25.
//

/// Fundamental physical constants.
///
/// All constants are provided as Math values in SI units.
/// Units are documented in the constant descriptions.
public struct PhysicsConstants: Sendable {

    // MARK: - Universal Constants

    /// Speed of light in vacuum (c)
    /// Value: 299,792,458 m/s (exact)
    public static let speedOfLight = Math(299792458)

    /// Alias for speed of light
    public static let c = speedOfLight

    /// Gravitational constant (G)
    /// Value: 6.67430 × 10⁻¹¹ m³/(kg·s²)
    public static let gravitationalConstant = Math(6.67430e-11)

    /// Alias for gravitational constant
    public static let G = gravitationalConstant

    /// Planck constant (h)
    /// Value: 6.62607015 × 10⁻³⁴ J·s (exact)
    public static let planckConstant = Math(6.62607015e-34)

    /// Alias for Planck constant
    public static let h = planckConstant

    /// Reduced Planck constant (ℏ = h/2π)
    /// Value: 1.054571817 × 10⁻³⁴ J·s
    public static let reducedPlanckConstant = Math(1.054571817e-34)

    /// Alias for reduced Planck constant
    public static let ℏ = reducedPlanckConstant

    /// Alias for reduced Planck constant
    public static let hbar = reducedPlanckConstant

    // MARK: - Electromagnetic Constants

    /// Elementary charge (e)
    /// Value: 1.602176634 × 10⁻¹⁹ C (exact)
    public static let elementaryCharge = Math(1.602176634e-19)

    /// Alias for elementary charge
    public static let e = elementaryCharge

    /// Vacuum permittivity (ε₀)
    /// Value: 8.8541878128 × 10⁻¹² F/m
    public static let vacuumPermittivity = Math(8.8541878128e-12)

    /// Alias for vacuum permittivity
    public static let ε₀ = vacuumPermittivity

    /// Vacuum permeability (μ₀)
    /// Value: 1.25663706212 × 10⁻⁶ H/m
    public static let vacuumPermeability = Math(1.25663706212e-6)

    /// Alias for vacuum permeability
    public static let μ₀ = vacuumPermeability

    /// Coulomb constant (k_e = 1/(4πε₀))
    /// Value: 8.9875517923 × 10⁹ N·m²/C²
    public static let coulombConstant = Math(8.9875517923e9)

    /// Alias for Coulomb constant
    public static let k_e = coulombConstant

    // MARK: - Atomic and Nuclear Constants

    /// Electron mass (m_e)
    /// Value: 9.1093837015 × 10⁻³¹ kg
    public static let electronMass = Math(9.1093837015e-31)

    /// Alias for electron mass
    public static let m_e = electronMass

    /// Proton mass (m_p)
    /// Value: 1.67262192369 × 10⁻²⁷ kg
    public static let protonMass = Math(1.67262192369e-27)

    /// Alias for proton mass
    public static let m_p = protonMass

    /// Neutron mass (m_n)
    /// Value: 1.67492749804 × 10⁻²⁷ kg
    public static let neutronMass = Math(1.67492749804e-27)

    /// Alias for neutron mass
    public static let m_n = neutronMass

    /// Atomic mass unit (u or amu)
    /// Value: 1.66053906660 × 10⁻²⁷ kg
    public static let atomicMassUnit = Math(1.66053906660e-27)

    /// Alias for atomic mass unit
    public static let u = atomicMassUnit

    /// Alias for atomic mass unit
    public static let amu = atomicMassUnit

    /// Avogadro constant (N_A)
    /// Value: 6.02214076 × 10²³ mol⁻¹ (exact)
    public static let avogadroConstant = Math(6.02214076e23)

    /// Alias for Avogadro constant
    public static let N_A = avogadroConstant

    /// Boltzmann constant (k_B)
    /// Value: 1.380649 × 10⁻²³ J/K (exact)
    public static let boltzmannConstant = Math(1.380649e-23)

    /// Alias for Boltzmann constant
    public static let k_B = boltzmannConstant

    /// Gas constant (R = N_A × k_B)
    /// Value: 8.314462618 J/(mol·K)
    public static let gasConstant = Math(8.314462618)

    /// Alias for gas constant
    public static let R = gasConstant

    /// Faraday constant (F = N_A × e)
    /// Value: 96485.33212 C/mol
    public static let faradayConstant = Math(96485.33212)

    /// Alias for Faraday constant
    public static let F = faradayConstant

    /// Rydberg constant (R∞)
    /// Value: 10973731.568160 m⁻¹
    public static let rydbergConstant = Math(10973731.568160)

    /// Bohr radius (a₀)
    /// Value: 5.29177210903 × 10⁻¹¹ m
    public static let bohrRadius = Math(5.29177210903e-11)

    /// Alias for Bohr radius
    public static let a₀ = bohrRadius

    /// Fine-structure constant (α)
    /// Value: 7.2973525693 × 10⁻³ (dimensionless)
    public static let fineStructureConstant = Math(7.2973525693e-3)

    /// Alias for fine-structure constant
    public static let α = fineStructureConstant

    // MARK: - Thermodynamic Constants

    /// Stefan-Boltzmann constant (σ)
    /// Value: 5.670374419 × 10⁻⁸ W/(m²·K⁴)
    public static let stefanBoltzmannConstant = Math(5.670374419e-8)

    /// Alias for Stefan-Boltzmann constant
    public static let σ = stefanBoltzmannConstant

    /// Wien displacement constant (b)
    /// Value: 2.897771955 × 10⁻³ m·K
    public static let wienDisplacementConstant = Math(2.897771955e-3)

    /// Alias for Wien displacement constant
    public static let b = wienDisplacementConstant

    /// Standard atmosphere (atm)
    /// Value: 101325 Pa (exact)
    public static let standardAtmosphere = Math(101325)

    /// Alias for standard atmosphere
    public static let atm = standardAtmosphere

    /// Standard temperature (0°C)
    /// Value: 273.15 K
    public static let standardTemperature = Math(273.15)

    /// Absolute zero
    /// Value: 0 K
    public static let absoluteZero = Math(0)
}
