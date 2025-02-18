//
//  UIRectCorner+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - UIRectCorner + NamespaceProviding

extension UIRectCorner: NamespaceProviding { }

extension Extendable where Base == UIRectCorner {
    public static var top: Base {
        .init([.topLeft, .topRight])
    }

    public static var bottom: Base {
        .init([.bottomLeft, .bottomRight])
    }
    
    #if !os(watchOS)
    public var convertedCorners: CACornerMask {
        switch base {
        case .allCorners:
            [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .bottomLeft:
            .layerMinXMaxYCorner
        case .bottomRight:
            .layerMaxXMaxYCorner
        case .topLeft:
            .layerMinXMinYCorner
        case .topRight:
            .layerMaxXMinYCorner
        default:
            []
        }
    }
    #endif
}
