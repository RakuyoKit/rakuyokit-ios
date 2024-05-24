//
//  Extendable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - GenericExtendable

public struct GenericExtendable<Base, Generic>: HigherOrderFunctionalizable {
    /// Base object to extend.
    public var base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) { self.base = base }
}

// MARK: - GenericNamespaceProviding

/// A type that has `GenericExtendable` extensions.
public protocol GenericNamespaceProviding {
    /// Extended type
    associatedtype CompatibleType

    /// Generic type contained in `CompatibleType`
    associatedtype GenericType

    /// `GenericExtendable` extensions.
    static var rak: GenericExtendable<CompatibleType, GenericType>.Type { get set }

    /// `GenericExtendable` extensions.
    var rak: GenericExtendable<CompatibleType, GenericType> { get set }
}

extension GenericNamespaceProviding {
    /// `GenericExtendable` extensions.
    public static var rak: GenericExtendable<Self, GenericType>.Type {
        get { GenericExtendable<Self, GenericType>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `Extendable` to "mutate" base type */ }
    }

    /// `GenericExtendable` extensions.
    public var rak: GenericExtendable<Self, GenericType> {
        get { GenericExtendable(self) }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `Extendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `rak` proxy.

// swiftformat:disable all
import enum Swift.Optional
extension Optional: GenericNamespaceProviding {
    public typealias GenericType = Wrapped
}

import struct Swift.Array
extension Array: GenericNamespaceProviding {
    public typealias GenericType = Element
}

import struct Swift.ContiguousArray
extension ContiguousArray: GenericNamespaceProviding {
    public typealias GenericType = Element
}

import struct Swift.Set
extension Set: GenericNamespaceProviding {
    public typealias GenericType = Element
}
// swiftformat:enable all
