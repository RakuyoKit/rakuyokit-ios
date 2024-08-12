//
//  NanoID.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/8/12.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - NanoID

/// Used to create NanoID
///
/// ```swift
/// // Nano ID with default alphabet (0-9a-zA-Z_-) and length (21 chars)
/// let id = NanoID.new()
///
/// // Nano ID with default alphabet and given length
/// let id = NanoID.new(size: 12)
///
/// // Nano ID with given alphabet and length
/// let id = NanoID.new(alphabet: .uppercasedLatinLetters, size: 15)
///
/// // Nano ID with preset custom parameters
/// let nanoID = NanoID(alphabet: [.lowercasedLatinLetters, .numbers], size: 10)
/// let idFirst = nanoID.new()
/// let idSecond = nanoID.new()
/// ```
public final class NanoID {
    public enum Default {
        public static let size = 21
        public static let aphabet = [NanoID.Alphabet.urlSafe]
    }

    private var size: Int
    private var alphabet: String

    public init(alphabet: [Alphabet] = Default.aphabet, size: Int = Default.size) {
        self.size = size
        self.alphabet = Self.parse(alphabet)
    }
}

// MARK: - Public

extension NanoID {
    public static func new(alphabet: [Alphabet] = Default.aphabet, size: Int = Default.size) -> String {
        generate(from: parse(alphabet), of: size)
    }

    public func new() -> String {
        Self.generate(from: alphabet, of: size)
    }
}

// MARK: - Private

extension NanoID {
    /// Parses input alphabets into a string
    private static func parse(_ alphabets: [Alphabet]) -> String {
        alphabets.map(\.supportedChars).joined()
    }

    /// Generates a Nano ID using given parameters
    private static func generate(from alphabet: String, of length: Int) -> String {
        var nanoID = ""

        for _ in 0 ..< length {
            let randomCharacter = randomCharacter(from: alphabet)
            nanoID.append(randomCharacter)
        }

        return nanoID
    }

    /// Returns a random character from a given string
    private static func randomCharacter(from string: String) -> Character {
        let randomNum = Int.random(in: 0 ..< string.count)
        let randomIndex = string.index(string.startIndex, offsetBy: randomNum)
        return string[randomIndex]
    }
}
