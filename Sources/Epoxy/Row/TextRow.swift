//
//  TextRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCore
import RAKCore

// MARK: - TextRow

/// Replace `UILabel` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `TextRow.Style` and `TextRow.Content`.
public final class TextRow: UILabel {
    private lazy var size: OptionalCGSize? = nil
}

// MARK: Life cycle

extension TextRow {
    override public var intrinsicContentSize: CGSize {
        lazy var superSize = super.intrinsicContentSize
        guard let size else { return superSize }

        return .init(
            width: size.width ?? superSize.width,
            height: size.height ?? superSize.height
        )
    }
}

// MARK: StyledView

extension TextRow: StyledView {
    public struct Style: Hashable, RowConfigureApplicable {
        public let size: OptionalCGSize?
        public let font: UIFont
        public let color: UIColor
        public let alignment: NSTextAlignment
        public let numberOfLines: Int
        public let lineBreakMode: NSLineBreakMode

        public init(
            size: OptionalCGSize? = nil,
            font: UIFont = .systemFont(ofSize: UIFont.labelFontSize),
            color: ConvertibleToColor = UIColor.label,
            alignment: NSTextAlignment = .left,
            numberOfLines: Int = 0,
            lineBreakMode: NSLineBreakMode = .byTruncatingTail
        ) {
            self.size = size
            self.font = font
            self.color = color.color
            self.alignment = alignment
            self.numberOfLines = numberOfLines
            self.lineBreakMode = lineBreakMode
        }

        public func apply(to row: UILabel) {
            row.font = font
            row.textColor = color
            row.textAlignment = alignment
            row.numberOfLines = numberOfLines
            row.lineBreakMode = lineBreakMode
        }
    }

    public convenience init(style: Style) {
        self.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        size = style.size

        style.apply(to: self)
    }
}

// MARK: ContentConfigurableView

extension TextRow: ContentConfigurableView {
    public enum Content: Equatable, ExpressibleByStringInterpolation, RowConfigureApplicable {
        case text(String?)
        case attributedText(NSAttributedString?)

        public init(stringLiteral value: String) {
            self = .text(value)
        }

        public func apply(to row: UILabel) {
            switch self {
            case .text(let value):
                row.text = value

            case .attributedText(let value):
                row.attributedText = value
            }
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        content.apply(to: self)
    }
}

// MARK: BehaviorsConfigurableView

extension TextRow: BehaviorsConfigurableView { }
#endif
