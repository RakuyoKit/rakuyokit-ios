//
//  AnyImageProviding.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - AnyImageProviding

public protocol AnyImageProviding: Equatable {
    associatedtype Value

    /// Storing the original object.
    var value: Value? { get }

    /// Used to implement `Equatable`.
    ///
    /// When using this type, you do not need to care about the specifics of the value.
    var equals: (Value?) -> Bool { get }
}

// MARK: - Equatable

extension AnyImageProviding {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.equals(rhs.value)
    }
}
