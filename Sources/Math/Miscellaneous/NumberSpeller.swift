//
//  NumberSpeller.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation


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
        
        // ✅ handle zero explicitly
        if groups.allSatisfy({ Int($0) == 0 }) && fractionPart.isEmpty {
            return negative ? "negative zero" : "zero"
        }
        
        let spelledInteger = Self.spellIntegerGroups(groups, mode: mode)
        
        var result = spelledInteger
        
        if !fractionPart.isEmpty {
            let conjunction = mode == .aviation ? "point" : "and"
            let fractionSpelling = Self.pronounceFraction(from: fractionPart, mode: mode)
            result += " \(conjunction) \(fractionSpelling)"
        }
        
        if negative {
            result = "negative " + result
        }
        
        return result
    }
    
    /// Returns the spelled-out name of a numeric string.
    ///
    /// - Parameters:
    ///   - math: The numeric string to spell out.
    ///   - mode: The pronunciation mode. Defaults to `.normal`.
    /// - Returns: The spelled-out number as a string.
    public static func spellNumber(from n: Math, mode: PronunciationMode = .normal) -> String {
        let string = n.description
        
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
        
        // ✅ handle zero explicitly
        if groups.allSatisfy({ Int($0) == 0 }) && fractionPart.isEmpty {
            return negative ? "negative zero" : "zero"
        }
        
        let spelledInteger = Self.spellIntegerGroups(groups, mode: mode)
        
        
        var result = spelledInteger
        
        if !fractionPart.isEmpty {
            let conjunction = mode == .aviation ? "point" : "and"
            let fractionSpelling = Self.pronounceFraction(from: fractionPart, mode: mode)
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

        // Pad only middle/right groups, strip leading zeros from first
        return groups.enumerated().map { index, group in
            if index == 0 {
                return group.isEmpty ? "0" : group // don't trim leading zeros
            } else {
                return String(repeating: "0", count: 3 - group.count) + group
            }
        }
    }
    
    /// Spells out integer groups with appropriate large number suffixes.
    private static func spellIntegerGroups(_ groups: [String], mode: PronunciationMode) -> String {
        var spelledParts: [String] = []

        for (index, groupStr) in groups.enumerated() {
            let groupInt = Int(groupStr) ?? 0
            guard groupInt > 0 else { continue }
            
            let groupName = spellThreeDigits(groupStr, mode: mode)
            let positionFromRight = groups.count - index - 1
            
            let suffix: String
            switch positionFromRight {
            case 0: suffix = ""
            case 1: suffix = " thousand"
            case 2: suffix = " million"
            case 3: suffix = " billion"
            case 4: suffix = " trillion"
            default: suffix = " " + LargeNumber.name(forIndex: Math(integerLiteral: positionFromRight))
            }

            spelledParts.append(groupName + suffix)
        }

        return spelledParts.joined(separator: " ").trimmingCharacters(in: .whitespaces)
    }

    private static func spellThreeDigits(_ numberStr: String, mode: PronunciationMode) -> String {
        guard !numberStr.isEmpty, numberStr != "000" else { return "" }
        
        var parts: [String] = []
        
        switch mode {
        case .normal:
            // Pad to 3 digits
            let padded = String(repeating: "0", count: 3 - numberStr.count) + numberStr
            guard padded.count == 3 else { return "" }
            
            let hundredsDigit = padded[padded.startIndex]
            let tensDigit = padded[padded.index(padded.startIndex, offsetBy: 1)]
            let unitsDigit = padded[padded.index(padded.startIndex, offsetBy: 2)]
            
            // Hundreds
            if hundredsDigit != "0", let hundredsName = SmallNumbers.names[Int(String(hundredsDigit))!] {
                parts.append("\(hundredsName) hundred")
            }
            
            // Tens + Units
            if tensDigit == "1" { // 10-19
                if let teenName = SmallNumbers.names[Int(String(tensDigit) + String(unitsDigit))!] {
                    parts.append(teenName)
                }
            } else {
                if tensDigit != "0", let tensName = TensNumbers.names[(Int(String(tensDigit)) ?? 0) * 10] {
                    parts.append(tensName)
                }
                if unitsDigit != "0", let unitsName = SmallNumbers.names[Int(String(unitsDigit))!] {
                    parts.append(unitsName)
                }
            }
            
        case .aviation:
            let aviationMap: [Character: String] = [
                "0": "zero", "1": "one", "2": "two", "3": "tree",
                "4": "four", "5": "fife", "6": "six", "7": "seven",
                "8": "eight", "9": "niner"
            ]
            for c in numberStr {
                parts.append(aviationMap[c] ?? String(c))
            }
        }
        
        return parts.joined(separator: " ")
    }
    
    private static func spellIntegerWithoutSuffix(_ numberString: String) -> String {
        // Remove leading zeros to avoid weird readings like "zero hundred"
        let trimmed = numberString.trimmingCharacters(in: CharacterSet(charactersIn: "0"))
        guard !trimmed.isEmpty else { return "zero" }
        
        let groups = splitIntoThreeDigitGroups(trimmed)
        
        // Use the existing spellThreeDigits but **don’t add thousand/million/etc suffixes**
        return groups.map { spellThreeDigits($0, mode: .normal) }.joined(separator: " ")
    }
    
    /// Pronounces the fractional part of a decimal number.
    private static func pronounceFraction(from fractionString: String, mode: PronunciationMode) -> String {
        guard !fractionString.isEmpty else { return "" }

        switch mode {
        case .aviation:
            let map: [Character: String] = ["0":"zero","1":"one","2":"two","3":"tree","4":"four","5":"fife","6":"six","7":"seven","8":"eight","9":"niner"]
            return fractionString.map { map[$0]! }.joined(separator: " ")

        case .normal:
            // Treat the fraction as a single integer
            let numeratorSpelling = spellLargeIntegerString(fractionString)
            let numeratorValue = Int(fractionString) ?? 0
            let isPlural = numeratorValue != 1
            let denominator = fractionDenominatorName(forPower: fractionString.count, plural: isPlural)
            return "\(numeratorSpelling) \(denominator)"
        }
    }

    // Spell a numeric string (any length) without losing digits
    private static func spellLargeIntegerString(_ str: String) -> String {
        let groups = splitIntoThreeDigitGroups(str)
        return spellIntegerGroups(groups, mode: .normal)
    }

    // Correct fraction denominator
    private static func fractionDenominatorName(forPower power: Int, plural: Bool = false) -> String {
        let singular: String
        switch power {
        case 1: singular = "tenth"
        case 2: singular = "hundredth"
        case 3: singular = "thousandth"
        case 4: singular = "ten-thousandth"
        case 5: singular = "hundred-thousandth"
        case 6: singular = "millionth"
        case 7: singular = "ten-millionth"
        case 8: singular = "hundred-millionth"
        case 9: singular = "billionth"
        case 10: singular = "ten-billionth"
        case 11: singular = "hundred-billionth"
        case 12: singular = "trillionth"
        default:
            let illionIndex = (power - 3) / 3
            let remainder = (power - 3) % 3

            let base = LargeNumber.name(forIndex: Math(integerLiteral: illionIndex + 1))
            let prefix: String
            switch remainder {
            case 0: prefix = ""
            case 1: prefix = "ten-"
            case 2: prefix = "hundred-"
            default: prefix = ""
            }
            singular = "\(prefix)\(base)th"
        }
        
        return plural ? singular + "s" : singular
    }
    
    private static func spellFractionalNumber(_ string: String) -> String {
        // Ensure no leading zeros in the fractional numerator
        let trimmed = string.trimmingCharacters(in: CharacterSet(charactersIn: "0"))
        guard !trimmed.isEmpty else { return "zero" }
        
        // Pad string to a multiple of 3 for proper grouping
        let padCount = (3 - (trimmed.count % 3)) % 3
        let padded = String(repeating: "0", count: padCount) + trimmed
        
        // Split into 3-digit groups
        var groups: [String] = []
        var current = padded
        while !current.isEmpty {
            let endIndex = current.index(current.startIndex, offsetBy: 3)
            let group = String(current[..<endIndex])
            groups.append(group)
            current = String(current[endIndex...])
        }
        
        // Spell each group with proper position scaling
        var parts: [String] = []
        for (i, group) in groups.enumerated() {
            let number = Math(stringLiteral: group)
            guard number > 0 else { continue }

            let groupSpelling = spellThreeDigits(String(number.asInt ?? 0), mode: .normal)
            
            // Determine suffix
            let power = groups.count - i - 1
            let suffix = power > 0 ? " " + LargeNumber.name(forIndex: Math(integerLiteral: power - 1)) : ""
            
            parts.append(groupSpelling + suffix)
        }
        
        return parts.joined(separator: " ")
    }
    
    private static func spellThreeDigitsOrLarger(_ number: Int) -> String {
        if number == 0 { return "zero" }

        var parts: [String] = []
        var n = number
        let millions = n / 1_000_000
        if millions > 0 { parts.append(spellThreeDigits(String(millions), mode: .normal) + " million"); n %= 1_000_000 }
        let thousands = n / 1_000
        if thousands > 0 { parts.append(spellThreeDigits(String(thousands), mode: .normal) + " thousand"); n %= 1_000 }
        if n > 0 { parts.append(spellThreeDigits(String(n), mode: .normal)) }

        return parts.joined(separator: " ")
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
            guard let indexInt = index.asInt else { return "" }

            if let irregular = irregulars[indexInt] { return irregular }

            let unitsPart = indexInt % 10
            let tensPart = ((indexInt % 100) / 10) * 10
            let hundredsPart = ((indexInt / 100) % 10) * 100

            var parts: [String] = []
            if hundredsPart != 0, let hundreds = hundredsMap[hundredsPart] {
                parts.append(hundreds)
            }
            if tensPart != 0, let tens = tensMap[tensPart] {
                parts.append(tens)
            }
            if unitsPart != 0, let units = unitsMap[unitsPart] {
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
