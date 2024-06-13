//
//  Character+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/6/13.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

extension Extendable where Base == Character {
    /// An emoji is either a 2-byte unicode character or a regular UTF8 character with the emoji modifier attached, like 3️⃣.
    /// `0x203C` is the first instance of a UTF16 emoji that doesn't require a modifier.
    ///
    /// `Unicode.Scalar.Properties.isEmoji` returns `true` for any character that can be turned into an emoji by adding a modifier
    /// (such as the number "3").
    /// To avoid this situation, we will first check whether it is greater than `0x203C`.
    public var isEmoji: Bool {
        guard let scalar = base.unicodeScalars.first else { return false }
        return (scalar.value >= 0x203C || base.unicodeScalars.count > 1) && scalar.properties.isEmoji
    }
}
