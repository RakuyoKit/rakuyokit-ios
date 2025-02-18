//
//  TwoGenericExtendable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - TwoGenericExtendable

public struct TwoGenericExtendable<Base, OG, TG>: HigherOrderFunctionalizable {
    /// Base object to extend.
    public var base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) { self.base = base }
}

// MARK: - TwoGenericNamespaceProviding

/// A type that has `TwoGenericExtendable` extensions.
public protocol TwoGenericNamespaceProviding {
    /// Extended type
    associatedtype CompatibleType

    /// Generic type contained in `CompatibleType`
    associatedtype OneGenericType

    /// Generic type contained in `CompatibleType`
    associatedtype TowGenericType

    /// `DictionaryExtendable` extensions.
    static var rak: TwoGenericExtendable<CompatibleType, OneGenericType, TowGenericType>.Type { get set }

    /// `DictionaryExtendable` extensions.
    var rak: TwoGenericExtendable<CompatibleType, OneGenericType, TowGenericType> { get set }
}

extension TwoGenericNamespaceProviding {
    /// `DictionaryExtendable` extensions.
    public static var rak: TwoGenericExtendable<Self, OneGenericType, TowGenericType>.Type {
        get { TwoGenericExtendable<Self, OneGenericType, TowGenericType>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `TwoGenericExtendable` to "mutate" base type */ }
    }
    
    /// `DictionaryExtendable` extensions.
    public var rak: TwoGenericExtendable<Self, OneGenericType, TowGenericType> {
        get { TwoGenericExtendable(self) }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `TwoGenericExtendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `rak` proxy.

// swiftformat:disable all
import struct Swift.Dictionary
extension Dictionary: TwoGenericNamespaceProviding {
    public typealias OneGenericType = Key
    public typealias TowGenericType = Value
}
// swiftformat:enable all
