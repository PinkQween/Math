//
//  NumberSpeller.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation
import BigInt

// MARK: - NumberSpeller

/// A utility for converting numeric values into their spelled-out English names,
/// supporting large numbers and different pronunciation modes.
public struct NumberSpeller {
    
    // MARK: - Pronunciation Mode
    
    /// Modes for pronouncing numbers.
    public enum PronunciationMode {
        /// Standard pronunciation.
        case normal
        /// Aviation-style pronunciation.
        case aviation
    }
    
    // MARK: - Public API
    
    /// Returns the spelled-out name of a numeric string.
    ///
    /// - Parameters:
    ///   - string: The numeric string to spell out.
    ///   - mode: The pronunciation mode. Defaults to `.normal`.
    /// - Returns: The spelled-out number as a string.
    public static func spellNumber(from string: String, mode: PronunciationMode = .normal) -> String {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "zero" }
        
        var negative = false
        var chars = trimmed
        if chars.first == "-" {
            negative = true
            chars.removeFirst()
        }
        
        let integerPart: String
        let fractionPart: String
        
        if let dotIndex = chars.firstIndex(of: ".") {
            integerPart = String(chars[..<dotIndex])
            fractionPart = String(chars[chars.index(after: dotIndex)...])
        } else {
            integerPart = chars
            fractionPart = ""
        }
        
        let groups = Self.splitIntoThreeDigitGroups(integerPart)
        let spelledInteger = Self.spellIntegerGroups(groups, mode: mode)
        
        var result = spelledInteger
        
        if !fractionPart.isEmpty {
            let fractionDecimal = Decimal(string: "0." + fractionPart) ?? 0
            let conjunction = mode == .aviation ? "point" : "and"
            let fractionSpelling = Self.pronounceFraction(fractionDecimal, mode: mode)
            result += " \(conjunction) \(fractionSpelling)"
        }
        
        if negative {
            result = "negative " + result
        }
        
        return result
    }
    
    // MARK: - Private Helpers
    
    /// Splits a numeric string into groups of three digits from right to left.
    private static func splitIntoThreeDigitGroups(_ numberString: String) -> [String] {
        var groups: [String] = []
        var current = numberString
        
        while !current.isEmpty {
            let endIndex = current.index(current.endIndex, offsetBy: -3, limitedBy: current.startIndex) ?? current.startIndex
            let group = String(current[endIndex..<current.endIndex])
            groups.insert(group, at: 0)
            current = String(current[..<endIndex])
        }
        
        return groups.map { String(repeating: "0", count: 3 - $0.count) + $0 }
    }
    
    /// Spells out integer groups with appropriate large number suffixes.
    private static func spellIntegerGroups(_ groups: [String], mode: PronunciationMode) -> String {
        var spelledParts: [String] = []
        
        for (index, groupStr) in groups.enumerated() {
            guard let groupNum = Int(groupStr), groupNum > 0 else { continue }
            let groupName = spellThreeDigits(groupNum, mode: mode)
            let positionFromRight = groups.count - 1 - index
            
            let suffix: String
            switch mode {
            case .aviation:
                switch positionFromRight {
                case 0: suffix = ""
                case 1: suffix = " thousand"
                case 2: suffix = " million"
                case 3: suffix = " billion"
                default:
                    suffix = " " + LargeNumber.name(forIndex: Math(integerLiteral: positionFromRight))
                }
            case .normal:
                switch positionFromRight {
                case 0: suffix = ""
                case 1: suffix = " thousand"
                default:
                    suffix = " " + LargeNumber.name(forIndex: Math(integerLiteral: positionFromRight))
                }
            }
            
            spelledParts.append(groupName + suffix)
        }
        
        return spelledParts.joined(separator: " ")
    }
    
    /// Spells out a three-digit number according to the pronunciation mode.
    private static func spellThreeDigits(_ number: Int, mode: PronunciationMode) -> String {
        guard number > 0 else { return "" }
        var n = number
        var parts: [String] = []
        
        let aviationMap: [Int: String] = [
            0: "zero", 1: "one", 2: "two", 3: "tree", 4: "four",
            5: "fife", 6: "six", 7: "seven", 8: "eight", 9: "niner"
        ]
        
        switch mode {
        case .normal:
            if n >= 100 {
                let hundreds = n / 100
                if let hundredsStr = SmallNumbers.names[hundreds] {
                    parts.append("\(hundredsStr) hundred")
                }
                n %= 100
            }
            
            if n >= 20 {
                let tens = (n / 10) * 10
                if let tensStr = TensNumbers.names[tens] {
                    parts.append(tensStr)
                }
                n %= 10
            }
            
            if n > 0, let unitsStr = SmallNumbers.names[n] {
                parts.append(unitsStr)
            }
            
        case .aviation:
            if n >= 100 {
                let hundreds = n / 100
                let hundredsStr = aviationMap[hundreds] ?? "\(hundreds)"
                parts.append("\(hundredsStr) hundred")
                n %= 100
            }
            
            if n > 0 {
                for digitChar in String(n) {
                    if let digit = Int(String(digitChar)) {
                        parts.append(aviationMap[digit] ?? "\(digit)")
                    }
                }
            }
        }
        
        return parts.joined(separator: " ")
    }
    
    /// Pronounces the fractional part of a decimal number.
    private static func pronounceFraction(_ fraction: Decimal, mode: PronunciationMode) -> String {
        let fractionString = fraction.description.dropFirst(2) // Remove "0."
        guard !fractionString.isEmpty else { return "" }
        
        switch mode {
        case .aviation:
            let aviationMap: [Character: String] = [
                "0": "zero", "1": "one", "2": "two", "3": "tree",
                "4": "four", "5": "fife", "6": "six", "7": "seven",
                "8": "eight", "9": "niner"
            ]
            return fractionString.map { aviationMap[$0] ?? String($0) }.joined(separator: " ")
            
        case .normal:
            let numeratorStr = String(fractionString)
            let numeratorName = spellNumber(from: numeratorStr, mode: .normal)
            let denominatorPower = fractionString.count
            let denominatorName = fractionDenominatorName(forPower: denominatorPower)
            let pluralSuffix = numeratorStr != "1" ? "s" : ""
            
            return "\(numeratorName) \(denominatorName)\(pluralSuffix)"
        }
    }
    
    /// Returns the denominator name for a fractional power of ten.
    private static func fractionDenominatorName(forPower power: Int) -> String {
        switch power {
        case 1: return "tenth"
        case 2: return "hundredth"
        case 3: return "thousandth"
        case 4: return "ten-thousandth"
        case 5: return "hundred-thousandth"
        case 6: return "millionth"
        case 7: return "ten-millionth"
        case 8: return "hundred-millionth"
        case 9: return "billionth"
        case 10: return "ten-billionth"
        case 11: return "hundred-billionth"
        case 12: return "trillionth"
        default:
            let illionIndex = Math(integerLiteral: ((power - 3) / 3))
            let remainder = (power - 3) % 3
            
            let base = LargeNumber.name(forIndex: illionIndex + 1) // million = 10^6
            let prefix: String
            switch remainder {
            case 0: prefix = ""
            case 1: prefix = "ten-"
            case 2: prefix = "hundred-"
            default: prefix = ""
            }
            return "\(prefix)\(base)th"
        }
    }
    
    // MARK: - Nested Types
    
    private struct SmallNumbers {
        static let names: [Int: String] = [
            0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five",
            6: "six", 7: "seven", 8: "eight", 9: "nine", 10: "ten",
            11: "eleven", 12: "twelve", 13: "thirteen", 14: "fourteen", 15: "fifteen",
            16: "sixteen", 17: "seventeen", 18: "eighteen", 19: "nineteen"
        ]
    }
    
    private struct TensNumbers {
        static let names: [Int: String] = [
            20: "twenty", 30: "thirty", 40: "forty", 50: "fifty",
            60: "sixty", 70: "seventy", 80: "eighty", 90: "ninety"
        ]
    }
    
    /// Provides names for large number groups (illions).
    public struct LargeNumber {
        
        private static let irregulars: [Int: String] = [
            1: "million", 2: "billion", 3: "trillion", 4: "quadrillion",
            5: "quintillion", 6: "sextillion", 7: "septillion", 8: "octillion",
            9: "nonillion", 10: "decillion"
        ]
        
        private static let unitsMap: [Int: String] = [
            1: "un", 2: "duo", 3: "tre", 4: "quattuor", 5: "quin",
            6: "sex", 7: "septen", 8: "octo", 9: "novem"
        ]
        
        private static let tensMap: [Int: String] = [
            10: "dec", 20: "vigint", 30: "trigint", 40: "quadragint",
            50: "quinquagint", 60: "sexagint", 70: "septuagint",
            80: "octogint", 90: "nonagint"
        ]
        
        private static let hundredsMap: [Int: String] = [
            100: "cent", 200: "ducent", 300: "trecent", 400: "quadringent",
            500: "quingent", 600: "sescent", 700: "septingent", 800: "octingent",
            900: "nongent"
        ]
        
        /// Returns the illion name for a given index.
        ///
        /// - Parameter index: The illion index (1 = million, 2 = billion, etc.)
        /// - Returns: The illion name as a string.
        public static func name(forIndex index: Math) -> String {
            guard index > 0 else { return "" }
            if let irregular = irregulars[index.asInt ?? Int.max] { return irregular }
            
            let unitsPart = index % 10
            let tensPart = (index % 100) / 10 * 10
            let hundredsPart = (index / 100) * 100 % 1000
            
            var parts: [String] = []
            if hundredsPart != 0, let hundreds = hundredsMap[index.asInt ?? Int.max] {
                parts.append(hundreds)
            }
            if tensPart != 0, let tens = tensMap[index.asInt ?? Int.max] {
                parts.append(tens)
            }
            if unitsPart != 0, let units = unitsMap[index.asInt ?? Int.max] {
                parts.append(units)
            }
            
            return parts.joined() + "illion"
        }
    }
}

// MARK: - NumericConvertible Protocol

/// A protocol representing a numeric value that can be split into integer and fractional parts.
public protocol NumericConvertible {
    var integerPart: Decimal { get }
    var fractionalPart: Decimal { get }
}

extension Int: NumericConvertible {
    public var integerPart: Decimal { Decimal(self) }
    public var fractionalPart: Decimal { 0 }
}

extension Double: NumericConvertible {
    public var integerPart: Decimal { Decimal(Int(self)) }
    public var fractionalPart: Decimal { Decimal(self) - Decimal(Int(self)) }
}

extension Decimal: NumericConvertible {
    public var integerPart: Decimal {
        var rounded = Decimal()
        var original = self
        NSDecimalRound(&rounded, &original, 0, .down)
        return rounded
    }
    
    public var fractionalPart: Decimal { self - integerPart }
}

extension BigInt: NumericConvertible {
    public var integerPart: Decimal {
        Decimal(string: description) ?? 0
    }
    public var fractionalPart: Decimal { 0 }
}
