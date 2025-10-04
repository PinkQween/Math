//
//  AstronomyConstants.swift
//  Math
//
//  Created by Hanna Skairipa on 10/4/25.
//

/// Astronomical and cosmological constants.
///
/// All constants are provided as Math values in SI units unless otherwise noted.
/// Units are documented in the constant descriptions.
public struct AstronomyConstants: Sendable {

    // MARK: - Cosmological Constants

    /// Hubble constant (H₀)
    /// Value: ~70 km/(s·Mpc) (approximate, varies by measurement)
    /// Note: In SI units this is ~2.27 × 10⁻¹⁸ s⁻¹
    public static let hubbleConstant = Math(70)  // km/s/Mpc

    /// Alias for Hubble constant
    public static let H₀ = hubbleConstant

    /// Speed of light (c)
    /// Value: 299,792,458 m/s
    public static let c = PhysicsConstants.c

    /// Alias for speed of light
    public static let speedOfLight = c

    // MARK: - Solar System - Sun

    /// Solar mass (M☉)
    /// Value: 1.98892 × 10³⁰ kg
    public static let solarMass = Math(1.98892e30)

    /// Solar radius (R☉)
    /// Value: 6.96 × 10⁸ m (696,000 km)
    public static let solarRadius = Math(6.96e8)

    /// Solar luminosity (L☉)
    /// Value: 3.828 × 10²⁶ W
    public static let solarLuminosity = Math(3.828e26)

    /// Solar temperature (effective surface temperature)
    /// Value: 5778 K
    public static let solarTemperature = Math(5778)

    // MARK: - Solar System - Earth

    /// Earth mass (M⊕)
    /// Value: 5.97237 × 10²⁴ kg
    public static let earthMass = Math(5.97237e24)

    /// Earth radius (mean)
    /// Value: 6.371 × 10⁶ m (6,371 km)
    public static let earthRadius = Math(6.371e6)

    /// Earth equatorial radius
    /// Value: 6.3781 × 10⁶ m (6,378.1 km)
    public static let earthEquatorialRadius = Math(6.3781e6)

    /// Earth polar radius
    /// Value: 6.3568 × 10⁶ m (6,356.8 km)
    public static let earthPolarRadius = Math(6.3568e6)

    /// Standard gravity on Earth (g)
    /// Value: 9.80665 m/s² (exact, standard)
    public static let standardGravity = Math(9.80665)

    /// Alias for standard gravity
    public static let g = standardGravity

    /// Astronomical unit (AU) - Earth-Sun mean distance
    /// Value: 1.495978707 × 10¹¹ m (exact)
    public static let astronomicalUnit = Math(1.495978707e11)

    /// Alias for astronomical unit
    public static let AU = astronomicalUnit

    /// Earth orbital period (sidereal year)
    /// Value: 365.256363004 days
    public static let siderealYear = Math(365.256363004)

    /// Tropical year (equinox to equinox)
    /// Value: 365.24219 days
    public static let tropicalYear = Math(365.24219)

    /// Earth's orbital velocity (mean)
    /// Value: 29,780 m/s (29.78 km/s)
    public static let earthOrbitalVelocity = Math(29780)

    // MARK: - Solar System - Moon

    /// Lunar mass (M☾)
    /// Value: 7.342 × 10²² kg
    public static let lunarMass = Math(7.342e22)

    /// Lunar radius (mean)
    /// Value: 1.7374 × 10⁶ m (1,737.4 km)
    public static let lunarRadius = Math(1.7374e6)

    /// Earth-Moon mean distance
    /// Value: 3.844 × 10⁸ m (384,400 km)
    public static let earthMoonDistance = Math(3.844e8)

    /// Lunar orbital period (sidereal month)
    /// Value: 27.321661 days
    public static let siderealMonth = Math(27.321661)

    /// Synodic month (new moon to new moon)
    /// Value: 29.530589 days
    public static let synodicMonth = Math(29.530589)

    // MARK: - Solar System - Other Planets

    /// Jupiter mass (M♃)
    /// Value: 1.8982 × 10²⁷ kg
    public static let jupiterMass = Math(1.8982e27)

    /// Jupiter radius (equatorial)
    /// Value: 7.1492 × 10⁷ m (71,492 km)
    public static let jupiterRadius = Math(7.1492e7)

    // MARK: - Astronomical Distances

    /// Light-year (ly)
    /// Value: 9.4607304725808 × 10¹⁵ m
    public static let lightYear = Math(9.4607304725808e15)

    /// Alias for light-year
    public static let ly = lightYear

    /// Parsec (pc)
    /// Value: 3.0856775814913673 × 10¹⁶ m
    public static let parsec = Math(3.0856775814913673e16)

    /// Alias for parsec
    public static let pc = parsec

    /// Kiloparsec (kpc)
    /// Value: 3.0856775814913673 × 10¹⁹ m
    public static let kiloparsec = Math(3.0856775814913673e19)

    /// Alias for kiloparsec
    public static let kpc = kiloparsec

    /// Megaparsec (Mpc)
    /// Value: 3.0856775814913673 × 10²² m
    public static let megaparsec = Math(3.0856775814913673e22)

    /// Alias for megaparsec
    public static let Mpc = megaparsec

    // MARK: - Calculation Helpers

    /// Calculate Schwarzschild radius for a given mass
    /// Formula: r_s = 2GM/c²
    ///
    /// - Parameter mass: Mass in kilograms
    /// - Returns: Schwarzschild radius in meters
    ///
    /// Example:
    /// ```swift
    /// let rs = AstronomyConstants.schwarzschildRadius(mass: AstronomyConstants.solarMass)
    /// // rs ≈ 2953 m
    /// ```
    public static func schwarzschildRadius(mass: Math) -> Math {
        // r_s = 2GM/c² where G = 6.674e-11, c = 2.998e8
        let G = PhysicsConstants.G
        let c = PhysicsConstants.c
        return (2 * G * mass) / (c * c)
    }

    /// Calculate escape velocity from a celestial body
    /// Formula: v_esc = √(2GM/r)
    ///
    /// - Parameters:
    ///   - mass: Mass in kilograms
    ///   - radius: Radius in meters
    /// - Returns: Escape velocity in m/s
    ///
    /// Example:
    /// ```swift
    /// let vEsc = AstronomyConstants.escapeVelocity(
    ///     mass: AstronomyConstants.earthMass,
    ///     radius: AstronomyConstants.earthRadius
    /// )
    /// // vEsc ≈ 11,186 m/s
    /// ```
    public static func escapeVelocity(mass: Math, radius: Math) -> Math {
        let G = PhysicsConstants.G
        return Math.sqrt((2 * G * mass) / radius)
    }
}
