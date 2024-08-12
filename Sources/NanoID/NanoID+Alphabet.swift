//
//  NanoID+Alphabet.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/8/12.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - NanoID.Alphabet

extension NanoID {
    public struct Alphabet: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension NanoID.Alphabet {
    public static let uppercasedLatinLetters = Self(rawValue: 1 << 0)
    public static let lowercasedLatinLetters = Self(rawValue: 1 << 1)
    public static let numbers = Self(rawValue: 1 << 2)
    public static let symbol = Self(rawValue: 1 << 3)

    public static let urlSafe: Self = [uppercasedLatinLetters, lowercasedLatinLetters, numbers, symbol]
}

extension NanoID.Alphabet {
    public var supportedChars: String {
        var chars = ""
        lazy var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

        if contains(.uppercasedLatinLetters) {
            chars.append(letters.uppercased())
        }

        if contains(.lowercasedLatinLetters) {
            chars.append(letters.lowercased())
        }

        if contains(.numbers) {
            chars.append("1234567890")
        }

        if contains(.symbol) {
            chars.append("-_")
        }

        return chars
    }
}
