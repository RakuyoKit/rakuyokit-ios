//
//  Change.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

import Then

public extension Then where Self: Any {
    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///     CGRect().change {
    ///        $0.origin.x = 10
    ///        $0.size.width = 100
    ///     }
    @inlinable
    func change(_ block: (inout Self) throws -> Void) rethrows {
        var copy = self
        try block(&copy)
    }
}