//
//  DictionaryExtendable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - DictionaryExtendable

public struct DictionaryExtendable<Key, Value>: HigherOrderFunctionalizable where Key: Hashable {
    /// Base object to extend.
    public var base: [Key: Value]
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: [Key: Value]) { self.base = base }
}

// MARK: - DictionaryExtendableCompatible

/// A type that has `DictionaryExtendable` extensions.
public protocol DictionaryExtendableCompatible {
    /// Extended type
    associatedtype Key: Hashable
    associatedtype Value
    
    /// `DictionaryExtendable` extensions.
    static var rak: DictionaryExtendable<Key, Value>.Type { get set }
    
    /// `DictionaryExtendable` extensions.
    var rak: DictionaryExtendable<Key, Value> { get set }
}

extension DictionaryExtendableCompatible {
    /// `DictionaryExtendable` extensions.
    public static var rak: DictionaryExtendable<Key, Value>.Type {
        get { DictionaryExtendable<Key, Value>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `DictionaryExtendable` to "mutate" base type */ }
    }
    
    /// `DictionaryExtendable` extensions.
    public var rak: DictionaryExtendable<Key, Value> {
        get {
            guard let this = self as? [Key: Value] else {
                return DictionaryExtendable([:])
            }
            return DictionaryExtendable(this)
        }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `DictionaryExtendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `rak` proxy.

import struct Swift.Dictionary

// MARK: - Dictionary + DictionaryExtendableCompatible

extension Dictionary: DictionaryExtendableCompatible { }
