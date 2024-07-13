//
//  SectionEdgeInsets.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import RAKCore

// MARK: - SectionEdgeInsets

/// Spacing around the section.
public enum SectionEdgeInsets {
    // swiftlint:disable sorted_enum_cases

    /// Only at the top.
    case top(CGFloat)

    /// Only at the bottom.
    case bottom(CGFloat)

    /// Both top and bottom with the same size.
    case vertical(CGFloat)

    /// Both sides with the same size.
    case horizontal(CGFloat)

    /// Custom spacing for all four sides.
    case allInOne(CGFloat)

    /// Custom spacing, equal spacing on coaxes
    case allWithCoaxes(vertical: CGFloat, horizontal: CGFloat)

    /// Custom spacing for all four sides.
    case all(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat)

    /// Same spacing as `.insetGrouped` style `UITableView`
    ///
    /// (top: 0, leading: 20, bottom: 35, trailing: 20)
    case groupCard(horizontal: CGFloat = 20, bottom: CGFloat = 35)

    /// Fully customized using `EdgeInsets`.
    case custom(RAKCore.EdgeInsets)

    // swiftlint:enable sorted_enum_cases
}

extension SectionEdgeInsets {
    public var edgeInsets: NSDirectionalEdgeInsets {
        switch self {
        case .top(let value):
            .init(top: value, leading: 0, bottom: 0, trailing: 0)

        case .bottom(let value):
            .init(top: 0, leading: 0, bottom: value, trailing: 0)

        case .vertical(let value):
            .init(top: value, leading: 0, bottom: value, trailing: 0)

        case .horizontal(let value):
            .init(top: 0, leading: value, bottom: 0, trailing: value)

        case .allInOne(let value):
            .init(top: value, leading: value, bottom: value, trailing: value)

        case .allWithCoaxes(let vertical, let horizontal):
            .init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)

        case .all(let top, let leading, let bottom, let trailing):
            .init(top: top, leading: leading, bottom: bottom, trailing: trailing)

        case .groupCard(let horizontal, let bottom):
            .init(top: 0, leading: horizontal, bottom: bottom, trailing: horizontal)

        case .custom(let edge):
            edge.directionalEdgeInsets
        }
    }
}

extension SectionEdgeInsets? {
    public var edgeInsets: NSDirectionalEdgeInsets {
        switch self {
        case .none:
            .zero
        case .some(let wrapped):
            wrapped.edgeInsets
        }
    }
}
