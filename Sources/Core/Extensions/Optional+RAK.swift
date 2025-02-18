//
//  Optional+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/23.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
    public var isEmpty: Bool {
        self?.isEmpty ?? true
    }
    
    public var isNotEmpty: Bool { !isEmpty }
}

extension GenericExtendable where Base == Generic? {
    /// If the value is `nil`, returns the `"nil"` string. Otherwise the string interpolation of the value itself is returned.
    public var safeDescription: String {
        base.flatMap { "\($0)" } ?? "nil"
    }
}
