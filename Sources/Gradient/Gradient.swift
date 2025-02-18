//
//  Gradient.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

/// Gradient configuration
public struct Gradient: Hashable {
    /// Starting position of the gradient
    public let startPosition: Position

    /// Ending position of the gradient
    public let endPosition: Position

    /// Gradient colors
    public let colors: Colors
    
    public init(start: Position, end: Position, colors: Colors) {
        startPosition = start
        endPosition = end
        self.colors = colors
    }

    public init(direction: Direction, colors: Colors) {
        let positions = direction.positions
        self.init(start: positions.start, end: positions.end, colors: colors)
    }
}
