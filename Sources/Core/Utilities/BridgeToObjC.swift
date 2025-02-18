//
//  MutableCollection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - BridgeToObjC

/// Provides methods for conversion to Objective-C types while hiding Objective-C type declarations
public protocol BridgeToObjC {
    associatedtype BridgedValue: CanBridageToObjC
    
    typealias ObjCType = BridgedValue.ObjCType
    
    /// will be converted to an object of type Objective-C
    var bridgedValue: BridgedValue { get }
    
    /// Provides methods for converting objects to Objective-C properties
    var bridgeToObjC: ObjCType { get }
}

extension BridgeToObjC {
    public var bridgeToObjC: ObjCType {
        guard let obj = bridgedValue as? ObjCType else {
            fatalError(
                "Conversion of \(bridgedValue) to \(ObjCType.self) type failed!" +
                    "Please check whether the ObjCType paradigm setting is correct"
            )
        }
        return obj
    }
}

extension BridgeToObjC where Self: CanBridageToObjC {
    public var bridgedValue: Self { self }
}

// MARK: - Extendable + BridgeToObjC

extension Extendable: BridgeToObjC where Base: CanBridageToObjC {
    public var bridgedValue: Base { base }
}

// MARK: - GenericExtendable + BridgeToObjC

extension GenericExtendable: BridgeToObjC where Base: CanBridageToObjC {
    public var bridgedValue: Base { base }
}

// MARK: - TwoGenericExtendable + BridgeToObjC

extension TwoGenericExtendable: BridgeToObjC where Base: CanBridageToObjC {
    public var bridgedValue: Base { base }
}

// MARK: - CanBridageToObjC

/// Constraints that a type can be converted to an Objective-C type
public protocol CanBridageToObjC {
    associatedtype ObjCType: NSObject
}

// MARK: - String + CanBridageToObjC

extension String: CanBridageToObjC {
    // swiftlint:disable:next legacy_objc_type
    public typealias ObjCType = NSString
}

// MARK: - Int + CanBridageToObjC

extension Int: CanBridageToObjC {
    // swiftlint:disable:next legacy_objc_type
    public typealias ObjCType = NSNumber
}

// MARK: - Float + CanBridageToObjC

extension Float: CanBridageToObjC {
    // swiftlint:disable:next legacy_objc_type
    public typealias ObjCType = NSNumber
}

// MARK: - Double + CanBridageToObjC

extension Double: CanBridageToObjC {
    // swiftlint:disable:next legacy_objc_type
    public typealias ObjCType = NSNumber
}

// MARK: - CGFloat + CanBridageToObjC

extension CGFloat: CanBridageToObjC {
    // swiftlint:disable:next legacy_objc_type
    public typealias ObjCType = NSNumber
}

// MARK: - Array + CanBridageToObjC

extension Array: CanBridageToObjC where Element: CanBridageToObjC {
    // swiftlint:disable:next legacy_objc_type
    public typealias ObjCType = NSArray
}
