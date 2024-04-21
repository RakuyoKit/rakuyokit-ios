//
//  Extendable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - Extendable

public struct Extendable<Base>: HigherOrderFunctionalizable {
    /// Base object to extend.
    public var base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) { self.base = base }
}

// MARK: - NamespaceProviding

/// A type that has `Extendable` extensions.
public protocol NamespaceProviding {
    /// Extended type
    associatedtype CompatibleType
    
    /// `Extendable` extensions.
    static var rak: Extendable<CompatibleType>.Type { get set }
    
    /// `Extendable` extensions.
    var rak: Extendable<CompatibleType> { get set }
}

extension NamespaceProviding {
    /// `Extendable` extensions.
    public static var rak: Extendable<Self>.Type {
        get { Extendable<Self>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `Extendable` to "mutate" base type */ }
    }
    
    /// `Extendable` extensions.
    public var rak: Extendable<Self> {
        get { Extendable(self) }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `Extendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `rak` proxy.

// swiftlint:disable colon duplicate_imports
// swiftformat:disable all
import struct Swift.String;             extension String            : NamespaceProviding { }
import struct Swift.Character;          extension Character         : NamespaceProviding { }
import struct Swift.Bool;               extension Bool              : NamespaceProviding { }
import struct Swift.Int;                extension Int               : NamespaceProviding { }
import struct Swift.Double;             extension Double            : NamespaceProviding { }
import struct Swift.Float;              extension Float             : NamespaceProviding { }
import struct Swift.Array;              extension Array             : NamespaceProviding { }
import struct Swift.ContiguousArray;    extension ContiguousArray   : NamespaceProviding { }
import struct Swift.Set;                extension Set               : NamespaceProviding { }
import struct Swift.Dictionary;         extension Dictionary        : NamespaceProviding { }
import class  Foundation.NSObject;      extension NSObject          : NamespaceProviding { }
import struct Foundation.Date;          extension Date              : NamespaceProviding { }
import struct Foundation.URL;           extension URL               : NamespaceProviding { }
import struct Foundation.Data;          extension Data              : NamespaceProviding { }
import struct UIKit.CGPoint;            extension CGPoint           : NamespaceProviding { }
import struct UIKit.CGSize;             extension CGSize            : NamespaceProviding { }
import struct UIKit.CGRect;             extension CGRect            : NamespaceProviding { }
// swiftlint:enable colon duplicate_imports
// swiftformat:enable all
