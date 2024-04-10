//
//  Gradient+Direction.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

public extension Gradient {
    /// Specifies the direction of colors during gradient rendering.
    ///
    /// The values of this enumeration are set not according to the documentation of `startPoint`, 
    /// but rather determined by **visual perception**.
    ///
    /// For example, if our color array is `[.red, .black, .green]` and the direction is set to `from .top to .bottom`,
    /// the effect would be: red appears at the top of the view, and green appears at the bottom of the view.
    struct Direction {
        public let x: CGFloat
        
        public let y: CGFloat
        
        public init(x: CGFloat, y: CGFloat) {
            self.x = x
            self.y = y
        }
    }
}

public extension Gradient.Direction {
    static var top: Self { .init(x: 0.5, y: 0.0) }
    static var bottom: Self { .init(x: 0.5, y: 1.0) }
    static var left: Self { .init(x: 0.0, y: 0.5) }
    static var right: Self { .init(x: 1.0, y: 0.5) }
    static var topLeft: Self { .init(x: 0.0, y: 0.0) }
    static var topRight: Self { .init(x: 1.0, y: 0.0) }
    static var bottomLeft: Self { .init(x: 0.0, y: 1.0) }
    static var bottomRight: Self { .init(x: 1.0, y: 1.0) }
}
