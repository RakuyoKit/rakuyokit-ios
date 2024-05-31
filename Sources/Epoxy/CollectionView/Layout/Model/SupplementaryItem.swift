//
//  SupplementaryItem.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

// MARK: - SupplementaryItem

/// Header/Footer
public struct SupplementaryItem {
    /// Style
    public enum Style {
        /// Normal style
        case normal

        /// Sticky style
        case pin

        var pinToVisible: Bool {
            switch self {
            case .normal: false
            case .pin: true
            }
        }
    }

    public let elementKind: String

    public let style: Style

    public let alignment: NSRectAlignment

    public let size: Layout.Size

    public init(
        elementKind: String,
        style: Style,
        alignment: NSRectAlignment,
        size: Layout.Size = Self.defaultSize
    ) {
        self.elementKind = elementKind
        self.style = style
        self.alignment = alignment
        self.size = size
    }
}

// MARK: -

extension SupplementaryItem {
    public static var defaultSize: Layout.Size {
        .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
    }

    public static func header(
        style: Style = .normal,
        alignment: NSRectAlignment = .top,
        size: Layout.Size = Self.defaultSize
    ) -> Self {
        .init(
            elementKind: UICollectionView.elementKindSectionHeader,
            style: style,
            alignment: alignment,
            size: size
        )
    }

    public static func footer(
        style: Style = .normal,
        alignment: NSRectAlignment = .bottom,
        size: Layout.Size = Self.defaultSize
    ) -> Self {
        .init(
            elementKind: UICollectionView.elementKindSectionFooter,
            style: style,
            alignment: alignment,
            size: size
        )
    }
}
#endif
