//
//  Dictionary+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

infix operator +: AdditionPrecedence
public extension Dictionary {
    /// - Note: Will keep rhs's values for duplicate keys.
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        return lhs.merging(rhs) { _, new in new }
    }
}

infix operator +=: AssignmentPrecedence
public extension Dictionary {
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        lhs.merge(rhs) { _, new in new }
    }
}
