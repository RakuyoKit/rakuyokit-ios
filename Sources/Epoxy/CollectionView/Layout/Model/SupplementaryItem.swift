//
//  SupplementaryItem.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

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

    public struct Data {
        public let style: Style

        public let alignment: NSRectAlignment

        public let size: Layout.Size

        public init(
            style: Style,
            alignment: NSRectAlignment,
            size: Layout.Size = SupplementaryItem.defaultSize
        ) {
            self.style = style
            self.alignment = alignment
            self.size = size
        }
    }

    /// Header
    let header: Data?

    /// Footer
    let footer: Data?

    /// Configure Supplementary Item
    ///
    /// - Parameters:
    ///   - header: Section header
    ///   - footer: Section footer
    public init(header: Data?, footer: Data?) {
        self.header = header
        self.footer = footer
    }

    /// Configure Supplementary Item
    ///
    /// Probably one of the more common ways to initialize
    ///
    /// - Parameters:
    ///   - header: Section header style
    ///   - footer: Section footer style
    public init(header: Style? = nil, footer: Style? = nil) {
        self.init(
            header: header.flatMap { .header(style: $0) },
            footer: footer.flatMap { .footer(style: $0) }
        )
    }
}

extension SupplementaryItem {
    public static var defaultSize: Layout.Size {
        .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
    }
}

extension SupplementaryItem.Data {
    public static func header(
        style: SupplementaryItem.Style,
        size: Layout.Size = SupplementaryItem.defaultSize
    ) -> Self {
        .init(style: style, alignment: .top, size: size)
    }

    public static func footer(
        style: SupplementaryItem.Style,
        size: Layout.Size = SupplementaryItem.defaultSize
    ) -> Self {
        .init(style: style, alignment: .bottom, size: size)
    }
}
