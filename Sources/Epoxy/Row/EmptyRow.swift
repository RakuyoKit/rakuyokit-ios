//
//  EmptyRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/6/18.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCore
import RAKBase
import RAKCore

// MARK: - EmptyRow

/// Blank View
///
/// It is not recommended that you inherit from this class
public final class EmptyRow: BaseStyledEpoxyView<EmptyRow.Style> { }

// MARK: Life cycle

extension EmptyRow {
    override public var intrinsicContentSize: CGSize {
        lazy var superSize = super.intrinsicContentSize
        guard let size = style.size else { return superSize }

        return .init(
            width: size.width ?? superSize.width,
            height: size.height ?? superSize.height
        )
    }
}

// MARK: Config

extension EmptyRow {
    override public func config() {
        super.config()

        backgroundColor = style.backgroundColor

        layer.cornerRadius = style.cornerRadius
        layer.masksToBounds = style.masksToBounds
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor?.cgColor
    }
}

// MARK: StyledView

extension EmptyRow {
    public struct Style: Hashable {
        public let size: OptionalCGSize?
        public let backgroundColor: UIColor?

        public let cornerRadius: CGFloat
        public let masksToBounds: Bool

        public let borderWidth: CGFloat
        public let borderColor: UIColor?
    }
}

// MARK: ContentConfigurableView

extension EmptyRow: ContentConfigurableView { }

// MARK: BehaviorsConfigurableView

extension EmptyRow: BehaviorsConfigurableView { }
#endif
