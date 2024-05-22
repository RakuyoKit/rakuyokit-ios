//
//  OptionalSize.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - OptionalSize

public struct OptionalSize {
    public var width: Float?

    public var height: Float?

    public init(width: Float? = nil, height: Float? = nil) {
        self.width = width
        self.height = height
    }
}

// MARK: - Logic

extension OptionalSize {
    public static var zero: Self {
        .init(width: 0, height: 0)
    }

    public static var greatestFiniteMagnitude: Self {
        .init(width: .greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
    }

    public var cgFloatWidth: CGFloat? {
        width.flatMap { .init($0) }
    }

    public var cgFloatHeight: CGFloat? {
        height.flatMap { .init($0) }
    }
}

// MARK: Hashable

extension OptionalSize: Hashable { }

// MARK: Equatable

extension OptionalSize: Equatable { }

// MARK: CustomStringConvertible

extension OptionalSize: CustomStringConvertible {
    public var description: String {
        let desc: (Float?) -> String = { $0.flatMap { "\($0)" } ?? "nil" }
        return "{ height:\(desc(height)), width:\(desc(width)) }"
    }
}
