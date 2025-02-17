//
//  CGPoint+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - CGPoint + ExpressibleByStringLiteral

extension CGPoint: @retroactive ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = NSCoder.cgPoint(for: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self = NSCoder.cgPoint(for: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self = NSCoder.cgPoint(for: value)
    }
}

// MARK: - Extendable

extension Extendable where Base == CGPoint {
    public var halfX: CGFloat {
        get { base.x * 0.5 }
        set { base.x = newValue * 2 }
    }
    
    public var halfY: CGFloat {
        get { base.y * 0.5 }
        set { base.y = newValue * 2 }
    }
}
