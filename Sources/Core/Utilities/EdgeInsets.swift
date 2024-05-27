//
//  EdgeInsets.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - EdgeInsets

///
public struct EdgeInsets: Equatable, Hashable {
    public var top: CGFloat

    public var leading: CGFloat

    public var bottom: CGFloat

    public var trailing: CGFloat

    public init(
        top: CGFloat = .zero,
        leading: CGFloat = .zero,
        bottom: CGFloat = .zero,
        trailing: CGFloat = .zero
    ) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }

    public init(horizontal: CGFloat = .zero, vertical: CGFloat = .zero) {
        top = vertical
        leading = horizontal
        bottom = vertical
        trailing = horizontal
    }

    public init(
        horizontal: CGFloat = .zero,
        top: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) {
        self.top = top
        leading = horizontal
        self.bottom = bottom
        trailing = horizontal
    }

    public init(
        leading: CGFloat = .zero,
        trailing: CGFloat = .zero,
        vertical: CGFloat = .zero
    ) {
        top = vertical
        self.leading = leading
        bottom = vertical
        self.trailing = trailing
    }
}

// MARK: -

extension EdgeInsets {
    public static var zero: Self {
        .init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
    }

    public var uiEdgeInsets: UIEdgeInsets {
        .init(top: top, left: leading, bottom: bottom, right: trailing)
    }

    public var directionalEdgeInsets: NSDirectionalEdgeInsets {
        .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
