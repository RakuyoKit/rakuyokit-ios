//
//  Size.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - Size

public struct Size {
    public var width: Float

    public var height: Float

    public init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
}

// MARK: - Logic

extension Size {
    public static var zero: Self {
        .init(width: 0, height: 0)
    }

    public static var greatestFiniteMagnitude: Self {
        .init(width: .greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
    }

    public var cgSize: CGSize {
        .init(width: CGFloat(width), height: CGFloat(height))
    }
}

// MARK: Hashable

extension Size: Hashable { }

// MARK: Equatable

extension Size: Equatable { }

// MARK: CustomStringConvertible

extension Size: CustomStringConvertible {
    public var description: String {
        "{ height:\(height), width:\(width) }"
    }
}
