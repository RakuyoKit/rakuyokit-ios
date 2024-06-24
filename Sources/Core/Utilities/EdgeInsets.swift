//
//  EdgeInsets.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - EdgeInsets

/// Custom edge inset packaging
///
/// Simplify initialization and support quick conversion to `UIEdgeInsets` or `NSDirectionalEdgeInsets`
public struct EdgeInsets {
    public typealias Value = CGFloat

    public var top: Value

    public var leading: Value

    public var bottom: Value

    public var trailing: Value

    public init(
        top: Value = .zero,
        leading: Value = .zero,
        bottom: Value = .zero,
        trailing: Value = .zero
    ) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
}

// MARK: Logic

extension EdgeInsets {
    public static var zero: Self {
        // Prevent the default values of parameters in future initialization methods from changing
        .init(inset: .zero)
    }

    /// Through this method, the surrounding distance is set to the same value
    public init(inset value: Value) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }

    /// When the upper margins of the axes are the same, this method can be used to simplify the initialization.
    public init(horizontal: Value, vertical: Value) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// If you only want to set horizontal spacing, use this method
    public init(horizontal: Value, top: Value = .zero, bottom: Value = .zero) {
        self.init(top: top, leading: horizontal, bottom: bottom, trailing: horizontal)
    }

    /// If you only want to set vertical spacing, use this method
    public init(vertical: Value, leading: Value = .zero, trailing: Value = .zero) {
        self.init(top: vertical, leading: leading, bottom: vertical, trailing: trailing)
    }
}

// MARK: Transform

extension EdgeInsets {
    public var uiEdgeInsets: UIEdgeInsets {
        .init(top: top, left: leading, bottom: bottom, right: trailing)
    }

    public var directionalEdgeInsets: NSDirectionalEdgeInsets {
        .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    public init(_ insets: UIEdgeInsets) {
        self.init(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
    }

    public init(_ insets: NSDirectionalEdgeInsets) {
        self.init(top: insets.top, leading: insets.leading, bottom: insets.bottom, trailing: insets.trailing)
    }
}

// MARK: Hashable

extension EdgeInsets: Hashable { }
