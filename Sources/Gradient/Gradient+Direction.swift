//
//  Gradient+Direction.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/7/23.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - Gradient.Direction

extension Gradient {
    /// This type can be said to be a further abstraction of `Gradient.Position`
    ///
    /// `Gradient.Position` represents a specific point or position.
    /// The type `Gradient.Direction` represents the direction, including the starting point and the end point.
    public enum Direction: Hashable {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
        case topLeftToBottomRight
        case topRightToBottomLeft
        case bottomLeftToTopRight
        case bottomRightToTopLeft
        case custom(from: Position, to: Position)
    }
}

extension Gradient.Direction {
    /// The starting and ending points corresponding to the direction
    public var positions: (start: Gradient.Position, end: Gradient.Position) {
        switch self {
        case .topToBottom:
            (.top, .bottom)
        case .bottomToTop:
            (.bottom, .top)
        case .leftToRight:
            (.left, .right)
        case .rightToLeft:
            (.right, .left)
        case .topLeftToBottomRight:
            (.topLeft, .bottomRight)
        case .topRightToBottomLeft:
            (.topRight, .bottomLeft)
        case .bottomLeftToTopRight:
            (.bottomLeft, .topRight)
        case .bottomRightToTopLeft:
            (.bottomRight, .topLeft)
        case .custom(let from, let to):
            (from, to)
        }
    }
}
