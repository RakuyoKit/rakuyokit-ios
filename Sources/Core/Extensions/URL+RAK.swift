//
//  URL+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - ExpressibleByStringInterpolation

extension URL: @retroactive ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        guard let url = value.rak.toURL else {
            fatalError("Bad string, failed to create url from: \(value)")
        }
        self = url
    }
}
