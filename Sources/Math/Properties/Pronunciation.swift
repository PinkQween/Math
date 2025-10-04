//
//  Pronunciation.swift
//  Math
//
//  Created by Hanna Skairipa on 10/3/25.
//

import Foundation

// MARK: - Number Pronunciation

public extension Math {

    /// Returns the spelled-out English name of this number.
    ///
    /// - Parameter mode: The pronunciation mode (`.normal` or `.aviation`).
    /// - Returns: The number spelled out in English.
    ///
    /// # Examples
    ///
    /// ```swift
    /// Math(42).spelled()              // "forty two"
    /// Math(1234).spelled()            // "one thousand two hundred thirty four"
    /// Math(3.14).spelled()            // "three and fourteen hundredths"
    /// Math(42).spelled(.aviation)     // "four two"
    /// ```
    func spelled(mode: NumberSpeller.PronunciationMode = .normal) -> String {
        return NumberSpeller.spellNumber(from: self, mode: mode)
    }

    /// Returns the spelled-out English name of this number in normal pronunciation.
    var spelledOut: String {
        return spelled(mode: .normal)
    }

    /// Returns the spelled-out English name of this number in aviation pronunciation.
    ///
    /// Aviation pronunciation uses distinct digit names to avoid confusion:
    /// - "tree" for 3
    /// - "fife" for 5
    /// - "niner" for 9
    var spelledAviation: String {
        return spelled(mode: .aviation)
    }
}
