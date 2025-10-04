//
//  MathStorage.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation


// MARK: - Internal Storage

/// Represents numeric values internally.
public enum MathStorage: Sendable, Hashable {
    case int(Int)
    case double(Double)
    case bigInt(BigInt)
    case bigDecimal(BigInt, scale: Int)
}

// MARK: - Number Protocol

/// Protocol conformance for numeric behaviors Math supports.
public protocol NumberProtocol: Equatable, Comparable, ExpressibleByIntegerLiteral,
                                ExpressibleByFloatLiteral, ExpressibleByStringLiteral, Sendable, Strideable, Hashable {}
