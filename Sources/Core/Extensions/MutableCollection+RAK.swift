//
//  MutableCollection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

extension Extendable where Base: MutableCollection {
    @inlinable
    public mutating func changedEach(_ body: (inout Base.Element) throws -> Void) rethrows {
        try base.indices.forEach { try body(&base[$0]) }
    }
}
