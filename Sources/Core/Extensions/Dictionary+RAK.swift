//
//  Dictionary+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

infix operator +: AdditionPrecedence
extension Dictionary {
    /// - Note: Will keep rhs's values for duplicate keys.
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        lhs.merging(rhs) { _, new in new }
    }
}

infix operator +=: AssignmentPrecedence
extension Dictionary {
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        lhs.merge(rhs) { _, new in new }
    }
}
