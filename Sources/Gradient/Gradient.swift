//
//  Gradient.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

/// Gradient configuration
public struct Gradient {
    /// Starting position of the gradient
    public let startDirection: Direction
    
    /// Ending position of the gradient
    public let endDirection: Direction
    
    /// Gradient colors
    public let colors: Colors
    
    public init(start: Direction, end: Direction, colors: Colors) {
        self.startDirection = start
        self.endDirection = end
        self.colors = colors
    }
}
