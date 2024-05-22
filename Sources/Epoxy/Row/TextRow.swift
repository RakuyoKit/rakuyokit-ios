//
//  TextRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCore
import RAKCore

// MARK: - TextRow

/// Replace `UILabel` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `TextRow.Style` and `TextRow.Content`.
public final class TextRow: UILabel {
    private lazy var size: OptionalSize? = nil
}

// MARK: - Life cycle

extension TextRow {
    override public var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        guard let size else { return superSize }

        return .init(
            width: size.cgFloatWidth ?? superSize.width,
            height: size.cgFloatHeight ?? superSize.height
        )
    }
}

// MARK: StyledView

extension TextRow: StyledView {
    public struct Style: Hashable {
        public let size: OptionalSize?
        public let font: UIFont
        public let color: UIColor
        public let alignment: NSTextAlignment
        public let numberOfLines: Int
        public let lineBreakMode: NSLineBreakMode

        public init(
            size: OptionalSize? = nil,
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
    }

    public convenience init(style: Style) {
        self.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        size = style.size
        font = style.font
        textColor = style.color
        textAlignment = style.alignment
        numberOfLines = style.numberOfLines
        lineBreakMode = style.lineBreakMode
    }
}

// MARK: ContentConfigurableView

extension TextRow: ContentConfigurableView {
    public enum Content: Equatable, ExpressibleByStringLiteral {
        case text(String?)
        case attributedText(NSAttributedString?)

        public init(stringLiteral value: String) {
            self = .text(value)
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        switch content {
        case .text(let value):
            text = value

        case .attributedText(let value):
            attributedText = value
        }
    }
}

// MARK: BehaviorsConfigurableView

extension TextRow: BehaviorsConfigurableView { }