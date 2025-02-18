//
//  Gradient+Position.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - Gradient.Position

extension Gradient {
    /// Specifies the position of colors during gradient rendering.
    ///
    /// The values of this enumeration are set not according to the documentation of `startPoint`,
    /// but rather determined by **visual perception**.
    ///
    /// For example, if our color array is `[.red, .black, .green]` and the position is set to `from .top to .bottom`,
    /// the effect would be: red appears at the top of the view, and green appears at the bottom of the view.
    public struct Position: Hashable {
        public let x: CGFloat
        
        public let y: CGFloat
        
        public init(x: CGFloat, y: CGFloat) {
            self.x = x
            self.y = y
        }
    }
}

extension Gradient.Position {
    public static let top = Self(x: 0.5, y: 0.0)
    public static let bottom = Self(x: 0.5, y: 1.0)
    public static let left = Self(x: 0.0, y: 0.5)
    public static let right = Self(x: 1.0, y: 0.5)
    public static let topLeft = Self(x: 0.0, y: 0.0)
    public static let topRight = Self(x: 1.0, y: 0.0)
    public static let bottomLeft = Self(x: 0.0, y: 1.0)
    public static let bottomRight = Self(x: 1.0, y: 1.0)
}
