//
//  ImageRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if os(iOS)
import UIKit

import EpoxyCore
import RAKCore

// MARK: - ImageRow

/// Replace `UIImageView` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `ImageRow.Style`, `ImageRow.Content` and `ImageRow.Behaviors`.
public final class ImageRow: UIImageView {
    /// Self-size
    private lazy var size: OptionalCGSize? = nil
}

// MARK: Life cycle

extension ImageRow {
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

extension ImageRow: StyledView {
    public struct Style: Hashable, RowConfigureApplicable {
        /// Image row size
        ///
        /// When a side value is `UIView.noIntrinsicMetric`, adaptive size will be used on that side
        public let size: OptionalCGSize?

        /// The tint color.
        public let tintColor: UIColor?

        /// The content mode determines the layout of the image when its size does
        /// not precisely match the size that the element is assigned.
        public let contentMode: UIView.ContentMode

        /// iOS 14 added support for Image Descriptions using VoiceOver. This is not always appropriate.
        /// Set this to `true` to prevent VoiceOver from describing the displayed image.
        public let blockAccessibilityDescription: Bool

        public init(
            size: OptionalCGSize? = nil,
            tintColor: UIColor? = nil,
            contentMode: UIView.ContentMode = .scaleToFill,
            blockAccessibilityDescription: Bool = false
        ) {
            self.size = size
            self.tintColor = tintColor
            self.contentMode = contentMode
            self.blockAccessibilityDescription = blockAccessibilityDescription
        }

        public func apply(to row: UIImageView) {
            row.tintColor = tintColor
            row.contentMode = contentMode

            if blockAccessibilityDescription {
                // Seting `isAccessibilityElement = false` isn't enough here, VoiceOver is very aggressive in finding images to discribe.
                // We need to explicitly remove the `.image` trait.
                row.accessibilityTraits = .none
            }
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

extension ImageRow: ContentConfigurableView {
    /// Usage example:
    /// ```swift
    /// ImageRow.groupItem(
    ///     dataID: DefaultDataID.noneProvided,
    ///     content: .init(UIImage()),
    ///     style: .init())
    /// ```
    ///
    /// There are also some convenience methods provided in ``FastImageContentProviding``:
    /// ```swift
    /// ImageRow.groupItem(
    ///     dataID: DefaultDataID.noneProvided,
    ///     content: .sfSymbols(name: ""),
    ///     style: .init())
    /// ```
    ///
    /// You can implement your own data provider via the ``ImageContentProviding`` protocol
    public typealias Content = AnyImageContent<ImageRow>

    public func setContent(_ content: Content, animated _: Bool) {
        weak var this = self
        content.setForView(this)
    }
}

// MARK: BehaviorsConfigurableView

extension ImageRow: BehaviorsConfigurableView { }
#endif
