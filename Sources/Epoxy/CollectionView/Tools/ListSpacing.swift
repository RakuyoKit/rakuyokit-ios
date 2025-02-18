//
//  ListSpacing.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

import CoreGraphics.CGFunction

// MARK: - ListSpacing

/// List Spacing
public struct ListSpacing {
    /// Default Spacing: 0
    public static let `default`: Self = 0

    /// Normal Spacing: 10
    public static let normal: Self = 10
    
    /// Card Spacing: 12
    public static let card: Self = 12

    /// For group-like lists, the spacing between groups: 35
    public static let group: Self = 35

    /// Spacing
    public let spacing: CGFloat

    /// Set Custom Spacing
    ///
    /// - Parameter spacing: Custom Spacing
    public init(_ spacing: CGFloat) {
        self.spacing = spacing
    }
}

// MARK: ExpressibleByIntegerLiteral

extension ListSpacing: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(.init(value))
    }
}

// MARK: ExpressibleByFloatLiteral

extension ListSpacing: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(.init(value))
    }
}
