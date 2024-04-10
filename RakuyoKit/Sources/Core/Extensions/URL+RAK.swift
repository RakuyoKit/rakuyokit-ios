//
//  URL+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - ExpressibleByStringLiteral

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = value.rak.toURL else {
            fatalError("Bad string, failed to create url from: \(value)")
        }
        self = url
    }
}
