//
//  MathWrapper.swift
//  CMathWrapper
//
//  Created by Hanna Skairipa on 2/5/26.
//

import Foundation
import Math

// MARK: - Helper to manage Math objects as opaque pointers

private class MathBox {
    var value: Math
    
    init(_ value: Math) {
        self.value = value
    }
}

private func toMathBox(_ ref: UnsafeMutableRawPointer?) -> MathBox? {
    guard let ref = ref else { return nil }
    return Unmanaged<MathBox>.fromOpaque(ref).takeUnretainedValue()
}

private func fromMath(_ math: Math) -> UnsafeMutableRawPointer {
    let box = MathBox(math)
    return Unmanaged.passRetained(box).toOpaque()
}

// MARK: - Object Lifecycle

@_cdecl("math_create_int")
public func math_create_int(_ value: Int64) -> UnsafeMutableRawPointer? {
    let math = Math(integerLiteral: Int(value))
    return fromMath(math)
}

@_cdecl("math_create_double")
public func math_create_double(_ value: Double) -> UnsafeMutableRawPointer? {
    let math = Math(floatLiteral: value)
    return fromMath(math)
}

@_cdecl("math_create_string")
public func math_create_string(_ value: UnsafePointer<CChar>?) -> UnsafeMutableRawPointer? {
    guard let value = value else { return nil }
    let str = String(cString: value)
    let math = Math(stringLiteral: str)
    return fromMath(math)
}

@_cdecl("math_copy")
public func math_copy(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    return fromMath(box.value)
}

@_cdecl("math_destroy")
public func math_destroy(_ math: UnsafeMutableRawPointer?) {
    guard let math = math else { return }
    Unmanaged<MathBox>.fromOpaque(math).release()
}

// MARK: - Conversions

@_cdecl("math_to_double")
public func math_to_double(_ math: UnsafeMutableRawPointer?, _ outValue: UnsafeMutablePointer<Double>?) -> Int32 {
    guard let box = toMathBox(math), let outValue = outValue else {
        return -4 // MATH_ERROR_NULL_POINTER
    }
    
    guard let doubleValue = box.value.asDouble else {
        return -5 // MATH_ERROR_CONVERSION_FAILED
    }
    
    outValue.pointee = doubleValue
    return 0 // MATH_SUCCESS
}

@_cdecl("math_to_int")
public func math_to_int(_ math: UnsafeMutableRawPointer?, _ outValue: UnsafeMutablePointer<Int64>?) -> Int32 {
    guard let box = toMathBox(math), let outValue = outValue else {
        return -4 // MATH_ERROR_NULL_POINTER
    }
    
    guard let intValue = box.value.asInt else {
        return -5 // MATH_ERROR_CONVERSION_FAILED
    }
    
    outValue.pointee = Int64(intValue)
    return 0 // MATH_SUCCESS
}

@_cdecl("math_to_string")
public func math_to_string(_ math: UnsafeMutableRawPointer?, _ buffer: UnsafeMutablePointer<CChar>?, _ bufferSize: Int) -> Int32 {
    guard let box = toMathBox(math), let buffer = buffer, bufferSize > 0 else {
        return -4 // MATH_ERROR_NULL_POINTER
    }
    
    let str = "\(box.value)"
    guard let cString = str.cString(using: .utf8), cString.count <= bufferSize else {
        return -3 // MATH_ERROR_OUT_OF_RANGE
    }
    
    cString.withUnsafeBufferPointer { ptr in
        buffer.update(from: ptr.baseAddress!, count: min(ptr.count, bufferSize))
    }
    
    return 0 // MATH_SUCCESS
}

// MARK: - Basic Arithmetic

@_cdecl("math_add")
public func math_add(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let aBox = toMathBox(a), let bBox = toMathBox(b) else { return nil }
    let result = aBox.value + bBox.value
    return fromMath(result)
}

@_cdecl("math_subtract")
public func math_subtract(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let aBox = toMathBox(a), let bBox = toMathBox(b) else { return nil }
    let result = aBox.value - bBox.value
    return fromMath(result)
}

@_cdecl("math_multiply")
public func math_multiply(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let aBox = toMathBox(a), let bBox = toMathBox(b) else { return nil }
    let result = aBox.value * bBox.value
    return fromMath(result)
}

@_cdecl("math_divide")
public func math_divide(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let aBox = toMathBox(a), let bBox = toMathBox(b) else { return nil }
    
    // Check for division by zero
    if let zero = bBox.value.asDouble, zero == 0.0 {
        return nil
    }
    if let zero = bBox.value.asInt, zero == 0 {
        return nil
    }
    
    let result = aBox.value / bBox.value
    return fromMath(result)
}

@_cdecl("math_modulo")
public func math_modulo(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let aBox = toMathBox(a), let bBox = toMathBox(b) else { return nil }
    let result = aBox.value % bBox.value
    return fromMath(result)
}

@_cdecl("math_abs")
public func math_abs(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = box.value.absoluteValue
    return fromMath(result)
}

@_cdecl("math_negate")
public func math_negate(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = -box.value
    return fromMath(result)
}

// MARK: - Power Operations

@_cdecl("math_power")
public func math_power(_ base: UnsafeMutableRawPointer?, _ exponent: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let baseBox = toMathBox(base), let expBox = toMathBox(exponent) else { return nil }
    let result = baseBox.value ** expBox.value
    return fromMath(result)
}

@_cdecl("math_sqrt")
public func math_sqrt(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = box.value |/ Math(2)
    return fromMath(result)
}

@_cdecl("math_nth_root")
public func math_nth_root(_ math: UnsafeMutableRawPointer?, _ n: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let mathBox = toMathBox(math), let nBox = toMathBox(n) else { return nil }
    let result = mathBox.value |/ nBox.value
    return fromMath(result)
}

// MARK: - Factorials

@_cdecl("math_factorial")
public func math_factorial(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = box.value~!
    return fromMath(result)
}

@_cdecl("math_double_factorial")
public func math_double_factorial(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = box.value~!!
    return fromMath(result)
}

@_cdecl("math_subfactorial")
public func math_subfactorial(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = ~!(box.value)
    return fromMath(result)
}

// MARK: - Trigonometric Functions

@_cdecl("math_sin")
public func math_sin(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = Math.sin(box.value)
    return fromMath(result)
}

@_cdecl("math_cos")
public func math_cos(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = Math.cos(box.value)
    return fromMath(result)
}

@_cdecl("math_tan")
public func math_tan(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = Math.tan(box.value)
    return fromMath(result)
}

@_cdecl("math_asin")
public func math_asin(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = Math.asin(box.value)
    return fromMath(result)
}

@_cdecl("math_acos")
public func math_acos(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = Math.acos(box.value)
    return fromMath(result)
}

@_cdecl("math_atan")
public func math_atan(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = Math.atan(box.value)
    return fromMath(result)
}

// MARK: - Number Properties

@_cdecl("math_is_even")
public func math_is_even(_ math: UnsafeMutableRawPointer?) -> Bool {
    guard let box = toMathBox(math) else { return false }
    return box.value.isEven
}

@_cdecl("math_is_odd")
public func math_is_odd(_ math: UnsafeMutableRawPointer?) -> Bool {
    guard let box = toMathBox(math) else { return false }
    return box.value.isOdd
}

@_cdecl("math_is_prime")
public func math_is_prime(_ math: UnsafeMutableRawPointer?) -> Bool {
    guard let box = toMathBox(math) else { return false }
    return box.value.isPrime
}

@_cdecl("math_is_perfect")
public func math_is_perfect(_ math: UnsafeMutableRawPointer?) -> Bool {
    guard let box = toMathBox(math) else { return false }
    return box.value.isPerfect
}

@_cdecl("math_is_fibonacci")
public func math_is_fibonacci(_ math: UnsafeMutableRawPointer?) -> Bool {
    guard let box = toMathBox(math) else { return false }
    return box.value.isFibonacci
}

@_cdecl("math_is_palindrome")
public func math_is_palindrome(_ math: UnsafeMutableRawPointer?) -> Bool {
    guard let box = toMathBox(math) else { return false }
    return box.value.isPalindrome
}

@_cdecl("math_next_prime")
public func math_next_prime(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    let result = box.value.nextPrime()
    return fromMath(result)
}

@_cdecl("math_previous_prime")
public func math_previous_prime(_ math: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer? {
    guard let box = toMathBox(math) else { return nil }
    guard let result = box.value.previousPrime() else { return nil }
    return fromMath(result)
}

// MARK: - Comparison

@_cdecl("math_compare")
public func math_compare(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?) -> Int32 {
    guard let aBox = toMathBox(a), let bBox = toMathBox(b) else { return 0 }
    
    if aBox.value < bBox.value {
        return -1
    } else if aBox.value > bBox.value {
        return 1
    } else {
        return 0
    }
}

@_cdecl("math_equals")
public func math_equals(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?) -> Bool {
    guard let aBox = toMathBox(a), let bBox = toMathBox(b) else { return false }
    return aBox.value == bBox.value
}

// MARK: - Settings

@_cdecl("math_set_angle_mode_radians")
public func math_set_angle_mode_radians(_ useRadians: Bool) {
    MathSettings.shared.angleMode = useRadians ? .radians : .degrees
}

@_cdecl("math_get_angle_mode_radians")
public func math_get_angle_mode_radians() -> Bool {
    return MathSettings.shared.angleMode == .radians
}

@_cdecl("math_set_precision")
public func math_set_precision(_ precision: Int32) {
    MathSettings.shared.precisionInt = Int(precision)
}

@_cdecl("math_get_precision")
public func math_get_precision() -> Int32 {
    return Int32(MathSettings.shared.precisionInt)
}
