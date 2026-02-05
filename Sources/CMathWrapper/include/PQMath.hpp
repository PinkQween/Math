/**
 * @file PQMath.hpp
 * @brief C++ wrapper for the Swift Math library
 * 
 * This header provides a C++ class wrapper with RAII and operator overloading
 * for natural C++ syntax when using the Swift Math library.
 * 
 * @author Hanna Skairipa
 * @date 2026
 */

#ifndef PQMATH_HPP
#define PQMATH_HPP

#include "math_wrapper.h"
#include <string>
#include <stdexcept>
#include <memory>

namespace PQMath {

/**
 * C++ wrapper class for Math with RAII and operator overloading.
 */
class Math {
private:
    MathRef ref_;
    
    // Private constructor from MathRef (takes ownership)
    explicit Math(MathRef ref) : ref_(ref) {
        if (!ref_) {
            throw std::runtime_error("Failed to create Math object");
        }
    }
    
public:
    // Constructors
    Math(long long value) : ref_(math_create_int(value)) {
        if (!ref_) throw std::runtime_error("Failed to create Math from int");
    }
    
    Math(int value) : Math(static_cast<long long>(value)) {}
    
    Math(double value) : ref_(math_create_double(value)) {
        if (!ref_) throw std::runtime_error("Failed to create Math from double");
    }
    
    Math(const std::string& value) : ref_(math_create_string(value.c_str())) {
        if (!ref_) throw std::runtime_error("Failed to create Math from string");
    }
    
    Math(const char* value) : Math(std::string(value)) {}
    
    // Copy constructor
    Math(const Math& other) : ref_(math_copy(other.ref_)) {
        if (!ref_) throw std::runtime_error("Failed to copy Math object");
    }
    
    // Move constructor
    Math(Math&& other) noexcept : ref_(other.ref_) {
        other.ref_ = nullptr;
    }
    
    // Destructor
    ~Math() {
        if (ref_) {
            math_destroy(ref_);
        }
    }
    
    // Copy assignment
    Math& operator=(const Math& other) {
        if (this != &other) {
            if (ref_) math_destroy(ref_);
            ref_ = math_copy(other.ref_);
            if (!ref_) throw std::runtime_error("Failed to copy Math object");
        }
        return *this;
    }
    
    // Move assignment
    Math& operator=(Math&& other) noexcept {
        if (this != &other) {
            if (ref_) math_destroy(ref_);
            ref_ = other.ref_;
            other.ref_ = nullptr;
        }
        return *this;
    }
    
    // Conversions
    double toDouble() const {
        double value;
        if (math_to_double(ref_, &value) != MATH_SUCCESS) {
            throw std::runtime_error("Failed to convert to double");
        }
        return value;
    }
    
    long long toInt() const {
        long long value;
        if (math_to_int(ref_, &value) != MATH_SUCCESS) {
            throw std::runtime_error("Failed to convert to int");
        }
        return value;
    }
    
    std::string toString() const {
        char buffer[1024];
        if (math_to_string(ref_, buffer, sizeof(buffer)) != MATH_SUCCESS) {
            throw std::runtime_error("Failed to convert to string");
        }
        return std::string(buffer);
    }
    
    // Arithmetic operators
    Math operator+(const Math& other) const {
        return Math(math_add(ref_, other.ref_));
    }
    
    Math operator-(const Math& other) const {
        return Math(math_subtract(ref_, other.ref_));
    }
    
    Math operator*(const Math& other) const {
        return Math(math_multiply(ref_, other.ref_));
    }
    
    Math operator/(const Math& other) const {
        MathRef result = math_divide(ref_, other.ref_);
        if (!result) throw std::runtime_error("Division by zero");
        return Math(result);
    }
    
    Math operator%(const Math& other) const {
        return Math(math_modulo(ref_, other.ref_));
    }
    
    Math operator-() const {
        return Math(math_negate(ref_));
    }
    
    // Compound assignment operators
    Math& operator+=(const Math& other) {
        *this = *this + other;
        return *this;
    }
    
    Math& operator-=(const Math& other) {
        *this = *this - other;
        return *this;
    }
    
    Math& operator*=(const Math& other) {
        *this = *this * other;
        return *this;
    }
    
    Math& operator/=(const Math& other) {
        *this = *this / other;
        return *this;
    }
    
    Math& operator%=(const Math& other) {
        *this = *this % other;
        return *this;
    }
    
    // Comparison operators
    bool operator==(const Math& other) const {
        return math_equals(ref_, other.ref_);
    }
    
    bool operator!=(const Math& other) const {
        return !(*this == other);
    }
    
    bool operator<(const Math& other) const {
        return math_compare(ref_, other.ref_) < 0;
    }
    
    bool operator>(const Math& other) const {
        return math_compare(ref_, other.ref_) > 0;
    }
    
    bool operator<=(const Math& other) const {
        return math_compare(ref_, other.ref_) <= 0;
    }
    
    bool operator>=(const Math& other) const {
        return math_compare(ref_, other.ref_) >= 0;
    }
    
    // Mathematical functions
    Math power(const Math& exponent) const {
        return Math(math_power(ref_, exponent.ref_));
    }
    
    Math sqrt() const {
        return Math(math_sqrt(ref_));
    }
    
    Math nthRoot(const Math& n) const {
        return Math(math_nth_root(ref_, n.ref_));
    }
    
    Math factorial() const {
        return Math(math_factorial(ref_));
    }
    
    Math doubleFactorial() const {
        return Math(math_double_factorial(ref_));
    }
    
    Math subfactorial() const {
        return Math(math_subfactorial(ref_));
    }
    
    Math abs() const {
        return Math(math_abs(ref_));
    }
    
    // Trigonometric functions
    Math sin() const { return Math(math_sin(ref_)); }
    Math cos() const { return Math(math_cos(ref_)); }
    Math tan() const { return Math(math_tan(ref_)); }
    Math asin() const { return Math(math_asin(ref_)); }
    Math acos() const { return Math(math_acos(ref_)); }
    Math atan() const { return Math(math_atan(ref_)); }
    
    // Number properties
    bool isEven() const { return math_is_even(ref_); }
    bool isOdd() const { return math_is_odd(ref_); }
    bool isPrime() const { return math_is_prime(ref_); }
    bool isPerfect() const { return math_is_perfect(ref_); }
    bool isFibonacci() const { return math_is_fibonacci(ref_); }
    bool isPalindrome() const { return math_is_palindrome(ref_); }
    
    Math nextPrime() const {
        return Math(math_next_prime(ref_));
    }
    
    Math previousPrime() const {
        return Math(math_previous_prime(ref_));
    }
    
    // Pronunciation
    std::string spelledOut() const {
        char buffer[2048];
        if (math_spelled_out(ref_, buffer, sizeof(buffer)) != MATH_SUCCESS) {
            throw std::runtime_error("Failed to spell out number");
        }
        return std::string(buffer);
    }
    
    std::string spelledAviation() const {
        char buffer[2048];
        if (math_spelled_aviation(ref_, buffer, sizeof(buffer)) != MATH_SUCCESS) {
            throw std::runtime_error("Failed to spell out number in aviation mode");
        }
        return std::string(buffer);
    }
    
    // Friend function for stream output
    friend std::ostream& operator<<(std::ostream& os, const Math& m) {
        os << m.toString();
        return os;
    }
    
    // Direct access to underlying MathRef (use with caution)
    MathRef get() const { return ref_; }
};

// Global settings functions
inline void setAngleModeRadians(bool useRadians) {
    math_set_angle_mode_radians(useRadians);
}

inline bool getAngleModeRadians() {
    return math_get_angle_mode_radians();
}

inline void setPrecision(int precision) {
    math_set_precision(precision);
}

inline int getPrecision() {
    return math_get_precision();
}

// Helper functions for common operations
inline Math pow(const Math& base, const Math& exponent) {
    return base.power(exponent);
}

inline Math sqrt(const Math& value) {
    return value.sqrt();
}

inline Math abs(const Math& value) {
    return value.abs();
}

inline Math sin(const Math& value) { return value.sin(); }
inline Math cos(const Math& value) { return value.cos(); }
inline Math tan(const Math& value) { return value.tan(); }
inline Math asin(const Math& value) { return value.asin(); }
inline Math acos(const Math& value) { return value.acos(); }
inline Math atan(const Math& value) { return value.atan(); }

// Constants namespace
namespace Constants {
    // Math constants
    inline Math e() { return Math(math_const_e()); }
    inline Math pi() { return Math(math_const_pi()); }
    inline Math tau() { return Math(math_const_tau()); }
    inline Math phi() { return Math(math_const_phi()); }           // Golden ratio
    inline Math sqrt2() { return Math(math_const_sqrt2()); }
    inline Math sqrt3() { return Math(math_const_sqrt3()); }
    
    // Physics constants (SI units)
    inline Math speedOfLight() { return Math(math_const_speed_of_light()); }      // m/s
    inline Math planck() { return Math(math_const_planck()); }                    // J·s
    inline Math gravitational() { return Math(math_const_gravitational()); }      // m³/(kg·s²)
    inline Math boltzmann() { return Math(math_const_boltzmann()); }              // J/K
    inline Math avogadro() { return Math(math_const_avogadro()); }                // mol⁻¹
    inline Math electronMass() { return Math(math_const_electron_mass()); }       // kg
    inline Math protonMass() { return Math(math_const_proton_mass()); }           // kg
    inline Math elementaryCharge() { return Math(math_const_elementary_charge()); } // C
    
    // Aliases
    inline Math c() { return speedOfLight(); }
    inline Math h() { return planck(); }
    inline Math G() { return gravitational(); }
    inline Math k() { return boltzmann(); }
    inline Math NA() { return avogadro(); }
}

} // namespace PQMath

#endif /* PQMATH_HPP */
