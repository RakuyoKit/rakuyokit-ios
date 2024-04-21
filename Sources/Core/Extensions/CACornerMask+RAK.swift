//
//  CACornerMask+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension CACornerMask: NamespaceProviding { }

extension Extendable where Base == CACornerMask {
    public static let all: Base = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner,
    ]
    
    public var uiRectCorner: UIRectCorner {
        var result: UIRectCorner = []
        
        if base.contains(.layerMinXMinYCorner) { result.insert(.topLeft) }
        if base.contains(.layerMaxXMinYCorner) { result.insert(.topRight) }
        if base.contains(.layerMinXMaxYCorner) { result.insert(.bottomLeft) }
        if base.contains(.layerMaxXMaxYCorner) { result.insert(.bottomRight) }
        
        return result
    }
}
#endif
