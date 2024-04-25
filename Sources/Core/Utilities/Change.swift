//
//  Change.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

import Then

extension Then where Self: Any {
    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///     CGRect().change {
    ///        $0.origin.x = 10
    ///        $0.size.width = 100
    ///     }
    @inlinable
    public func change(_ block: (inout Self) throws -> Void) rethrows {
        var copy = self
        try block(&copy)
    }
}
