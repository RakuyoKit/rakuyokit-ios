//
//  OptionalSize.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - OptionalSize

public struct OptionalSize<T: FloatingPoint> {
    public var width: T?

    public var height: T?

    public init(width: T? = nil, height: T? = nil) {
        self.width = width
        self.height = height
    }

    public init(size: T?) {
        self.init(width: size, height: size)
    }

    public init(_ size: T?) {
        self.init(size: size)
    }
}

// MARK: - Logic

extension OptionalSize {
    public static var zero: Self {
        .init(0)
    }

    public static var greatestFiniteMagnitude: Self {
        .init(.greatestFiniteMagnitude)
    }
}

// MARK: Hashable

extension OptionalSize: Hashable { }

// MARK: Equatable

extension OptionalSize: Equatable { }

// MARK: CustomStringConvertible

extension OptionalSize: CustomStringConvertible {
    public var description: String {
        "{ height:\(height.rak.safeDescription), width:\(width.rak.safeDescription) }"
    }
}
