//
//  ImageRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCore
import RAKCore

// MARK: - ImageRow

/// Replace `UIImageView` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `ImageRow.Style`, `ImageRow.Content` and `ImageRow.Behaviors`.
public final class ImageRow: UIImageView {
    private lazy var size: Size? = .zero
}

// MARK: - Life cycle

extension ImageRow {
    override public var intrinsicContentSize: CGSize {
        size?.cgSize ?? super.intrinsicContentSize
    }
}

// MARK: StyledView

extension ImageRow: StyledView {
    public struct Style: Hashable {
        /// Image row size
        ///
        /// When a side value is `greatestFiniteMagnitude`, adaptive size will be used on that side
        public let size: Size?

        /// The tint color.
        public let tintColor: UIColor?

        /// The content mode determines the layout of the image when its size does
        /// not precisely match the size that the element is assigned.
        public let contentMode: ContentMode

        /// iOS 14 added support for Image Descriptions using VoiceOver. This is not always appropriate.
        /// Set this to `true` to prevent VoiceOver from describing the displayed image.
        public let blockAccessibilityDescription: Bool

        public init(
            size: Size? = nil,
            tintColor: UIColor? = nil,
            contentMode: ContentMode = .scaleToFill,
            blockAccessibilityDescription: Bool = false
        ) {
            self.size = size
            self.tintColor = tintColor
            self.contentMode = contentMode
            self.blockAccessibilityDescription = blockAccessibilityDescription
        }
    }

    public convenience init(style: Style) {
        self.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        size = style.size
        tintColor = style.tintColor
        contentMode = style.contentMode

        if style.blockAccessibilityDescription {
            // Seting `isAccessibilityElement = false` isn't enough here, VoiceOver is very aggressive in finding images to discribe.
            // We need to explicitly remove the `.image` trait.
            accessibilityTraits = .none
        }
    }
}

// MARK: ContentConfigurableView

extension ImageRow: ContentConfigurableView {
    public typealias Content = ImageType?

    public enum ImageType: Equatable {
        case image(UIImage?)
        case asset(String, bundle: Bundle = .main)
        case data(Data)
        case file(String)
        case sfSymbols(String)

        public var image: UIImage? {
            switch self {
            case .image(let image):
                image

            case .asset(let name, let bundle):
                .init(named: name, in: bundle, with: nil)

            case .data(let data):
                .init(data: data)

            case .file(let path):
                .init(contentsOfFile: path)

            case .sfSymbols(let name):
                .init(systemName: name)
            }
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        image = content?.image
    }
}

// MARK: BehaviorsConfigurableView

extension ImageRow: BehaviorsConfigurableView {
    public struct Behaviors<T: UIImageView> {
        public typealias AsyncUpdateImage = ((UIImage?) -> Void) -> Void

        public typealias ConcurrencyUpdateImage = () async -> UIImage?

        public typealias CustomUpdateImage = (T?) -> Void

        /// Update asynchronously
        public let asyncUpdateImage: AsyncUpdateImage?

        /// Use coroutine to update
        public let concurrencyUpdateImage: ConcurrencyUpdateImage?

        /// Returns the view itself, which can be customized to update the view
        ///
        /// This view has a weak reference
        public let customUpdateImage: CustomUpdateImage?

        public init(
            asyncUpdateImage: AsyncUpdateImage? = nil,
            concurrencyUpdateImage: ConcurrencyUpdateImage? = nil,
            customUpdateImage: CustomUpdateImage? = nil
        ) {
            self.asyncUpdateImage = asyncUpdateImage
            self.concurrencyUpdateImage = concurrencyUpdateImage
            self.customUpdateImage = customUpdateImage
        }
    }

    public func setBehaviors(_ behaviors: Behaviors<ImageRow>?) {
        if let asyncUpdateImage = behaviors?.asyncUpdateImage {
            asyncUpdateImage { [weak self] in self?.image = $0 }
        }

        if let concurrencyUpdateImage = behaviors?.concurrencyUpdateImage {
            Task {
                let _image = await concurrencyUpdateImage()
                await MainActor.run { image = _image }
            }
        }

        if let customUpdateImage = behaviors?.customUpdateImage {
            weak var this = self
            customUpdateImage(this)
        }
    }
}
