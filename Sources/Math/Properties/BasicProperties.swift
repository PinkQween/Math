//
//  BasicProperties.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Basic Number Properties

public extension Math {

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
