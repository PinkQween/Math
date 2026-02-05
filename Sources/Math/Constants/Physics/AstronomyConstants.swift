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
    private static func compoundUnit(
        name: String,
        symbol: String,
        components: [(unit: Unit, exponent: Int)]
    ) -> Unit {
        Unit.compound(name: name, symbol: symbol, components: components, notes: name)
    }

    // MARK: - Cosmological Constants

    /// Hubble constant (H₀)
    /// Value: ~70 km/(s·Mpc) (approximate, varies by measurement)
    /// Note: In SI units this is ~2.27 × 10⁻¹⁸ s⁻¹
    public static let hubbleConstant = Math(70)  // km/s/Mpc

    /// Alias for Hubble constant
    public static let H₀ = hubbleConstant

    /// Hubble constant with units (km/s/Mpc)
    public static let hubbleConstantUnit = MathUnit(
        hubbleConstant,
        compoundUnit(
            name: "hubble constant",
            symbol: "km/(s·Mpc)",
            components: [
                (StandardUnits.kilometer, 1),
                (StandardUnits.second, -1),
                (StandardUnits.megaparsec, -1)
            ]
        )
    )

    /// Alias for Hubble constant with units
    public static let H₀Unit = hubbleConstantUnit

    /// Speed of light (c)
    /// Value: 299,792,458 m/s
    public static let c = PhysicsConstants.c

    /// Alias for speed of light
    public static let speedOfLight = c

    /// Speed of light with units
    public static let speedOfLightUnit = PhysicsConstants.cUnit

    // MARK: - Solar System - Sun

    /// Solar mass (M☉)
    /// Value: 1.98892 × 10³⁰ kg
    public static let solarMass = Math(1.98892e30)

    /// Solar mass with units
    public static let solarMassUnit = MathUnit(solarMass, StandardUnits.kilogram)

    /// Solar radius (R☉)
    /// Value: 6.96 × 10⁸ m (696,000 km)
    public static let solarRadius = Math(6.96e8)

    /// Solar radius with units
    public static let solarRadiusUnit = MathUnit(solarRadius, StandardUnits.meter)

    /// Solar luminosity (L☉)
    /// Value: 3.828 × 10²⁶ W
    public static let solarLuminosity = Math(3.828e26)

    /// Solar luminosity with units
    public static let solarLuminosityUnit = MathUnit(solarLuminosity, StandardUnits.watt)

    /// Solar temperature (effective surface temperature)
    /// Value: 5778 K
    public static let solarTemperature = Math(5778)

    /// Solar temperature with units
    public static let solarTemperatureUnit = MathUnit(solarTemperature, StandardUnits.kelvin)

    // MARK: - Solar System - Earth

    /// Earth mass (M⊕)
    /// Value: 5.97237 × 10²⁴ kg
    public static let earthMass = Math(5.97237e24)

    /// Earth mass with units
    public static let earthMassUnit = MathUnit(earthMass, StandardUnits.kilogram)

    /// Earth radius (mean)
    /// Value: 6.371 × 10⁶ m (6,371 km)
    public static let earthRadius = Math(6.371e6)

    /// Earth radius with units
    public static let earthRadiusUnit = MathUnit(earthRadius, StandardUnits.meter)

    /// Earth equatorial radius
    /// Value: 6.3781 × 10⁶ m (6,378.1 km)
    public static let earthEquatorialRadius = Math(6.3781e6)

    /// Earth equatorial radius with units
    public static let earthEquatorialRadiusUnit = MathUnit(earthEquatorialRadius, StandardUnits.meter)

    /// Earth polar radius
    /// Value: 6.3568 × 10⁶ m (6,356.8 km)
    public static let earthPolarRadius = Math(6.3568e6)

    /// Earth polar radius with units
    public static let earthPolarRadiusUnit = MathUnit(earthPolarRadius, StandardUnits.meter)

    /// Standard gravity on Earth (g)
    /// Value: 9.80665 m/s² (exact, standard)
    public static let standardGravity = Math(9.80665)

    /// Alias for standard gravity
    public static let g = standardGravity

    /// Standard gravity with units
    public static let standardGravityUnit = MathUnit(standardGravity, StandardUnits.meterPerSecondSquared)

    /// Astronomical unit (AU) - Earth-Sun mean distance
    /// Value: 1.495978707 × 10¹¹ m (exact)
    public static let astronomicalUnit = Math(1.495978707e11)

    /// Alias for astronomical unit
    public static let AU = astronomicalUnit

    /// Astronomical unit with units
    public static let astronomicalUnitUnit = MathUnit(astronomicalUnit, StandardUnits.meter)

    /// Earth orbital period (sidereal year)
    /// Value: 365.256363004 days
    public static let siderealYear = Math(365.256363004)

    /// Sidereal year with units
    public static let siderealYearUnit = MathUnit(siderealYear, StandardUnits.day)

    /// Tropical year (equinox to equinox)
    /// Value: 365.24219 days
    public static let tropicalYear = Math(365.24219)

    /// Tropical year with units
    public static let tropicalYearUnit = MathUnit(tropicalYear, StandardUnits.day)

    /// Earth's orbital velocity (mean)
    /// Value: 29,780 m/s (29.78 km/s)
    public static let earthOrbitalVelocity = Math(29780)

    /// Earth's orbital velocity with units
    public static let earthOrbitalVelocityUnit = MathUnit(earthOrbitalVelocity, StandardUnits.meterPerSecond)

    // MARK: - Solar System - Moon

    /// Lunar mass (M☾)
    /// Value: 7.342 × 10²² kg
    public static let lunarMass = Math(7.342e22)

    /// Lunar mass with units
    public static let lunarMassUnit = MathUnit(lunarMass, StandardUnits.kilogram)

    /// Lunar radius (mean)
    /// Value: 1.7374 × 10⁶ m (1,737.4 km)
    public static let lunarRadius = Math(1.7374e6)

    /// Lunar radius with units
    public static let lunarRadiusUnit = MathUnit(lunarRadius, StandardUnits.meter)

    /// Earth-Moon mean distance
    /// Value: 3.844 × 10⁸ m (384,400 km)
    public static let earthMoonDistance = Math(3.844e8)

    /// Earth-Moon distance with units
    public static let earthMoonDistanceUnit = MathUnit(earthMoonDistance, StandardUnits.meter)

    /// Lunar orbital period (sidereal month)
    /// Value: 27.321661 days
    public static let siderealMonth = Math(27.321661)

    /// Sidereal month with units
    public static let siderealMonthUnit = MathUnit(siderealMonth, StandardUnits.day)

    /// Synodic month (new moon to new moon)
    /// Value: 29.530589 days
    public static let synodicMonth = Math(29.530589)

    /// Synodic month with units
    public static let synodicMonthUnit = MathUnit(synodicMonth, StandardUnits.day)

    // MARK: - Solar System - Other Planets

    /// Jupiter mass (M♃)
    /// Value: 1.8982 × 10²⁷ kg
    public static let jupiterMass = Math(1.8982e27)

    /// Jupiter mass with units
    public static let jupiterMassUnit = MathUnit(jupiterMass, StandardUnits.kilogram)

    /// Jupiter radius (equatorial)
    /// Value: 7.1492 × 10⁷ m (71,492 km)
    public static let jupiterRadius = Math(7.1492e7)

    /// Jupiter radius with units
    public static let jupiterRadiusUnit = MathUnit(jupiterRadius, StandardUnits.meter)

    // MARK: - Astronomical Distances

    /// Light-year (ly)
    /// Value: 9.4607304725808 × 10¹⁵ m
    public static let lightYear = Math(9.4607304725808e15)

    /// Alias for light-year
    public static let ly = lightYear

    /// Light-year with units
    public static let lightYearUnit = MathUnit(lightYear, StandardUnits.meter)

    /// Parsec (pc)
    /// Value: 3.0856775814913673 × 10¹⁶ m
    public static let parsec = Math(3.0856775814913673e16)

    /// Alias for parsec
    public static let pc = parsec

    /// Parsec with units
    public static let parsecUnit = MathUnit(parsec, StandardUnits.meter)

    /// Kiloparsec (kpc)
    /// Value: 3.0856775814913673 × 10¹⁹ m
    public static let kiloparsec = Math(3.0856775814913673e19)

    /// Alias for kiloparsec
    public static let kpc = kiloparsec

    /// Kiloparsec with units
    public static let kiloparsecUnit = MathUnit(kiloparsec, StandardUnits.meter)

    /// Megaparsec (Mpc)
    /// Value: 3.0856775814913673 × 10²² m
    public static let megaparsec = Math(3.0856775814913673e22)

    /// Alias for megaparsec
    public static let Mpc = megaparsec

    /// Megaparsec with units
    public static let megaparsecUnit = MathUnit(megaparsec, StandardUnits.meter)

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

    /// Calculate Schwarzschild radius for a given mass with units
    public static func schwarzschildRadius(mass: MathUnit) -> MathUnit? {
        guard let m = mass.converted(to: StandardUnits.kilogram) else { return nil }
        let rs = schwarzschildRadius(mass: m.value)
        return MathUnit(rs, StandardUnits.meter)
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

    /// Calculate escape velocity for a given mass and radius with units
    public static func escapeVelocity(mass: MathUnit, radius: MathUnit) -> MathUnit? {
        guard let m = mass.converted(to: StandardUnits.kilogram) else { return nil }
        guard let r = radius.converted(to: StandardUnits.meter) else { return nil }
        let v = escapeVelocity(mass: m.value, radius: r.value)
        return MathUnit(v, StandardUnits.meterPerSecond)
    }
}
