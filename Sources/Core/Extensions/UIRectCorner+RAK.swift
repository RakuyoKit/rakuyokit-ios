//
//  UIRectCorner+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

extension UIRectCorner: NamespaceProviding { }

public extension Extendable where Base == UIRectCorner {
    static var top: Self {
        Base([.topLeft, .topRight]).rak
    }
    
    static var bottom: Self {
        Base([.bottomLeft, .bottomRight]).rak
    }
}
