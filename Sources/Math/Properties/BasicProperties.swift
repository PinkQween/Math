//
//  BasicProperties.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Basic Number Properties

public extension Math {
    var isInt: Bool {
        return self % 1 == 0
    }
    
    /// Returns the parity of this value.
    ///
    /// - Returns: `.even` if the value is divisible by 2, otherwise `.odd`.
    var getParity: Parity {
        return self % 2 == 0 ? .even : .odd
    }
    
    /// Returns the sign of this value.
    ///
    /// - Returns: `.positive` if greater than zero, `.negative` if less than zero, or `.zero` if equal to zero.
    var getSign: Sign {
        if self < 0 {
            return .negative
        } else if self == 0 {
            return .zero
        } else {
            return .positive
        }
    }
    
    /// Returns the absolute value of this number.
    var absoluteValue: Math {
        return self < 0 ? Math(0) - self : self
    }
    
    /// Returns the value truncated down to the nearest integer if it has a decimal part.
    var asCutOffDecimal: Math {
        return Math(integerLiteral: Int(Double(self)))
    }
    
    /// Returns the value floored to a given multiple.
    func floor(by multiple: Int) -> Math {
        let scaled = self / Math(integerLiteral: multiple)
        let floored = scaled.asCutOffDecimal
        return floored * Math(integerLiteral: multiple)
    }
    
    /// Returns the value ceiled to a given multiple.
    func ceiling(by multiple: Int) -> Math {
        let scaled = self / Math(integerLiteral: multiple)
        let ceiled = Math(floatLiteral: ceil(Double(scaled)))
        return ceiled * Math(integerLiteral: multiple)
    }
    
    /// Returns the value rounded to a given number of decimal places.
    func rounded(toDecimalPlaces places: Int) -> Math {
        guard places >= 0 else { return self }
        let multiplier = pow(10.0, Double(places))
        return Math(floatLiteral: (Double(self) * multiplier).rounded() / multiplier)
    }
    
    /// Returns `true` if this number is zero.
    var isZero: Bool {
        return self == 0
    }
    
    /// Returns `true` if this number is positive (greater than zero).
    var isPositive: Bool {
        return self > 0
    }
    
    /// Returns `true` if this number is negative (less than zero).
    var isNegative: Bool {
        return self < 0
    }
    
    /// Returns `true` if this number is even.
    var isEven: Bool {
        return self % 2 == 0
    }
    
    /// Returns `true` if this number is odd.
    var isOdd: Bool {
        return self % 2 != 0
    }
}
