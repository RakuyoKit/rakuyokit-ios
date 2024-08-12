//
//  NanoID+Alphabet.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/8/12.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

extension NanoID {
    public enum Alphabet {
        case urlSafe
        case uppercasedLatinLetters
        case lowercasedLatinLetters
        case numbers

        public var supportedChars: String {
            switch self {
            case .uppercasedLatinLetters:
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            case .lowercasedLatinLetters:
                "abcdefghijklmnopqrstuvwxyz"
            case .numbers:
                "1234567890"
            case .urlSafe:
                [
                    Self.uppercasedLatinLetters,
                    Self.lowercasedLatinLetters,
                    Self.numbers,
                ].map(\.supportedChars).joined() + "-_"
            }
        }
    }
}
