/**
 * @file math_wrapper.h
 * @brief C/C++ wrapper for the Swift Math library
 * 
 * This header provides C-compatible functions to use the Swift Math library
 * from C and C++ code. All functions use the `math_` prefix to avoid naming conflicts.
 * 
 * @author Hanna Skairipa
 * @date 2026
 */

#ifndef PQ_MATH_H
#define PQ_MATH_H

#include <stddef.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Opaque pointer to Math object */
typedef void* MathRef;

/* Error codes */
typedef enum {
    MATH_SUCCESS = 0,
    MATH_ERROR_INVALID_INPUT = -1,
    MATH_ERROR_DIVISION_BY_ZERO = -2,
    MATH_ERROR_OUT_OF_RANGE = -3,
    MATH_ERROR_NULL_POINTER = -4,
    MATH_ERROR_CONVERSION_FAILED = -5
} MathError;

/* ============================================================================
 * MARK: - Object Lifecycle
 * ========================================================================= */

/**
 * Creates a Math object from an integer value.
 * @param value The integer value
 * @return A new MathRef object, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_create_int(long long value);

/**
 * Creates a Math object from a double value.
 * @param value The double value
 * @return A new MathRef object, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_create_double(double value);

/**
 * Creates a Math object from a string representation.
 * @param value The string value (supports arbitrary precision integers)
 * @return A new MathRef object, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_create_string(const char* value);

/**
 * Creates a copy of an existing Math object.
 * @param math The Math object to copy
 * @return A new MathRef object, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_copy(MathRef math);

/**
 * Destroys a Math object and frees its memory.
 * @param math The Math object to destroy
 */
void math_destroy(MathRef math);

/* ============================================================================
 * MARK: - Conversions
 * ========================================================================= */

/**
 * Converts a Math object to a double.
 * @param math The Math object
 * @param out_value Pointer to store the result
 * @return MATH_SUCCESS or error code
 */
MathError math_to_double(MathRef math, double* out_value);

/**
 * Converts a Math object to a long long integer.
 * @param math The Math object
 * @param out_value Pointer to store the result
 * @return MATH_SUCCESS or error code
 */
MathError math_to_int(MathRef math, long long* out_value);

/**
 * Converts a Math object to a string representation.
 * @param math The Math object
 * @param buffer Buffer to store the string
 * @param buffer_size Size of the buffer
 * @return MATH_SUCCESS or error code
 */
MathError math_to_string(MathRef math, char* buffer, size_t buffer_size);

/* ============================================================================
 * MARK: - Basic Arithmetic
 * ========================================================================= */

/**
 * Adds two Math objects.
 * @param a First operand
 * @param b Second operand
 * @return Result of a + b, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_add(MathRef a, MathRef b);

/**
 * Subtracts two Math objects.
 * @param a First operand
 * @param b Second operand
 * @return Result of a - b, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_subtract(MathRef a, MathRef b);

/**
 * Multiplies two Math objects.
 * @param a First operand
 * @param b Second operand
 * @return Result of a * b, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_multiply(MathRef a, MathRef b);

/**
 * Divides two Math objects.
 * @param a Numerator
 * @param b Denominator
 * @return Result of a / b, or NULL on failure (e.g., division by zero). Must be freed with math_destroy().
 */
MathRef math_divide(MathRef a, MathRef b);

/**
 * Computes the modulo of two Math objects.
 * @param a First operand
 * @param b Second operand
 * @return Result of a % b, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_modulo(MathRef a, MathRef b);

/**
 * Computes the absolute value.
 * @param math The Math object
 * @return Absolute value, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_abs(MathRef math);

/**
 * Negates a Math object.
 * @param math The Math object
 * @return Negated value, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_negate(MathRef math);

/* ============================================================================
 * MARK: - Power Operations
 * ========================================================================= */

/**
 * Computes a raised to the power of b (a ** b).
 * @param base The base
 * @param exponent The exponent
 * @return Result of base ** exponent, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_power(MathRef base, MathRef exponent);

/**
 * Computes the square root.
 * @param math The Math object
 * @return Square root, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_sqrt(MathRef math);

/**
 * Computes the nth root.
 * @param math The value
 * @param n The root degree
 * @return nth root, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_nth_root(MathRef math, MathRef n);

/* ============================================================================
 * MARK: - Factorials
 * ========================================================================= */

/**
 * Computes the factorial (n!).
 * @param math The Math object
 * @return Factorial, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_factorial(MathRef math);

/**
 * Computes the double factorial (n!!).
 * @param math The Math object
 * @return Double factorial, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_double_factorial(MathRef math);

/**
 * Computes the subfactorial (!n).
 * @param math The Math object
 * @return Subfactorial, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_subfactorial(MathRef math);

/* ============================================================================
 * MARK: - Trigonometric Functions
 * ========================================================================= */

/**
 * Computes the sine.
 * @param math The angle (respects global angle mode setting)
 * @return sin(math), or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_sin(MathRef math);

/**
 * Computes the cosine.
 * @param math The angle (respects global angle mode setting)
 * @return cos(math), or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_cos(MathRef math);

/**
 * Computes the tangent.
 * @param math The angle (respects global angle mode setting)
 * @return tan(math), or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_tan(MathRef math);

/**
 * Computes the arcsine.
 * @param math The value
 * @return asin(math), or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_asin(MathRef math);

/**
 * Computes the arccosine.
 * @param math The value
 * @return acos(math), or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_acos(MathRef math);

/**
 * Computes the arctangent.
 * @param math The value
 * @return atan(math), or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_atan(MathRef math);

/* ============================================================================
 * MARK: - Number Properties
 * ========================================================================= */

/**
 * Checks if a number is even.
 * @param math The Math object
 * @return true if even, false otherwise
 */
bool math_is_even(MathRef math);

/**
 * Checks if a number is odd.
 * @param math The Math object
 * @return true if odd, false otherwise
 */
bool math_is_odd(MathRef math);

/**
 * Checks if a number is prime.
 * @param math The Math object
 * @return true if prime, false otherwise
 */
bool math_is_prime(MathRef math);

/**
 * Checks if a number is a perfect number.
 * @param math The Math object
 * @return true if perfect, false otherwise
 */
bool math_is_perfect(MathRef math);

/**
 * Checks if a number is a Fibonacci number.
 * @param math The Math object
 * @return true if Fibonacci, false otherwise
 */
bool math_is_fibonacci(MathRef math);

/**
 * Checks if a number is a palindrome.
 * @param math The Math object
 * @return true if palindrome, false otherwise
 */
bool math_is_palindrome(MathRef math);

/**
 * Finds the next prime number.
 * @param math The Math object
 * @return Next prime, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_next_prime(MathRef math);

/**
 * Finds the previous prime number.
 * @param math The Math object
 * @return Previous prime, or NULL on failure. Must be freed with math_destroy().
 */
MathRef math_previous_prime(MathRef math);

/* ============================================================================
 * MARK: - Comparison
 * ========================================================================= */

/**
 * Compares two Math objects.
 * @param a First operand
 * @param b Second operand
 * @return -1 if a < b, 0 if a == b, 1 if a > b
 */
int math_compare(MathRef a, MathRef b);

/**
 * Checks if two Math objects are equal.
 * @param a First operand
 * @param b Second operand
 * @return true if equal, false otherwise
 */
bool math_equals(MathRef a, MathRef b);

/* ============================================================================
 * MARK: - Settings
 * ========================================================================= */

/**
 * Sets the angle mode for trigonometric functions.
 * @param use_radians true for radians, false for degrees
 */
void math_set_angle_mode_radians(bool use_radians);

/**
 * Gets the current angle mode.
 * @return true if radians, false if degrees
 */
bool math_get_angle_mode_radians(void);

/**
 * Sets the precision for calculations.
 * @param precision Number of decimal places
 */
void math_set_precision(int precision);

/**
 * Gets the current precision.
 * @return Current precision value
 */
int math_get_precision(void);

/* ============================================================================
 * MARK: - Pronunciation
 * ========================================================================= */

/**
 * Spells out a number in English.
 * @param math The Math object
 * @param buffer Buffer to store the spelled-out text
 * @param buffer_size Size of the buffer
 * @return MATH_SUCCESS or error code
 */
MathError math_spelled_out(MathRef math, char* buffer, size_t buffer_size);

/**
 * Spells out a number in aviation pronunciation.
 * @param math The Math object
 * @param buffer Buffer to store the spelled-out text
 * @param buffer_size Size of the buffer
 * @return MATH_SUCCESS or error code
 */
MathError math_spelled_aviation(MathRef math, char* buffer, size_t buffer_size);

/* ============================================================================
 * MARK: - Constants
 * ========================================================================= */

/* Math Constants */
MathRef math_const_e(void);           /* Euler's number (≈2.718) */
MathRef math_const_pi(void);          /* Pi (≈3.14159) */
MathRef math_const_tau(void);         /* Tau (2π ≈ 6.283) */
MathRef math_const_phi(void);         /* Golden ratio (≈1.618) */
MathRef math_const_sqrt2(void);       /* √2 (≈1.414) */
MathRef math_const_sqrt3(void);       /* √3 (≈1.732) */

/* Physics Constants (values in SI units) */
MathRef math_const_speed_of_light(void);          /* c ≈ 299792458 m/s */
MathRef math_const_planck(void);                  /* h ≈ 6.626×10⁻³⁴ J·s */
MathRef math_const_gravitational(void);           /* G ≈ 6.674×10⁻¹¹ m³/(kg·s²) */
MathRef math_const_boltzmann(void);               /* k ≈ 1.381×10⁻²³ J/K */
MathRef math_const_avogadro(void);                /* N_A ≈ 6.022×10²³ mol⁻¹ */
MathRef math_const_electron_mass(void);           /* m_e ≈ 9.109×10⁻³¹ kg */
MathRef math_const_proton_mass(void);             /* m_p ≈ 1.673×10⁻²⁷ kg */
MathRef math_const_elementary_charge(void);       /* e ≈ 1.602×10⁻¹⁹ C */

#ifdef __cplusplus
}
#endif

#endif /* MATH_WRAPPER_H */
