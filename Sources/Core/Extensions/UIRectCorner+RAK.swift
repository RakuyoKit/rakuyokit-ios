//
//  UIRectCorner+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

// MARK: - UIRectCorner + NamespaceProviding

extension UIRectCorner: NamespaceProviding { }

extension Extendable where Base == UIRectCorner {
    public static var top: Self {
        Base([.topLeft, .topRight]).rak
    }
    
    public static var bottom: Self {
        Base([.bottomLeft, .bottomRight]).rak
    }
}
