//
//  AnyEncodable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - AnyEncodable

public struct AnyEncodable {
    private let encodable: Encodable
    
    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }
}

// MARK: Encodable

extension AnyEncodable: Encodable {
    public func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
