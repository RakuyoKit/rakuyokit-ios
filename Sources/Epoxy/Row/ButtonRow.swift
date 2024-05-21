//
//  ButtonRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCore
import RAKCore

// MARK: - ButtonRow

/// Replace `UIButton` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `ButtonRow.Style`, `ButtonRow.Content` and `ButtonRow.Behaviors`.
public final class ButtonRow: UIButton {
    private lazy var size: Size? = .zero
    
    /// Closure for touch down event.
    private lazy var didTouchDown: ButtonClosure? = nil

    /// Closure for tap event.
    private lazy var didTap: ButtonClosure? = nil
}

// MARK: - Life cycle

extension ButtonRow {
    override public var intrinsicContentSize: CGSize {
        size?.cgSize ?? super.intrinsicContentSize
    }
}

// MARK: Action

extension ButtonRow {
    @objc
    private func buttonDidTouchDown(_ button: UIButton) {
        didTouchDown?(button)
    }

    @objc
    private func buttonDidClick(_ button: UIButton) {
        didTap?(button)
    }
}

// MARK: StyledView

extension ButtonRow: StyledView {
    public struct Style: Hashable {
        /// button size
        ///
        /// When a side value is `greatestFiniteMagnitude`, adaptive size will be used on that side
        public let size: Size?

        /// The tint color.
        public let tintColor: UIColor?

        /// The button type.
        public let type: UIButton.ButtonType

        /// The title style.
        ///
        /// The `color` property will be ignored.
        /// Please use `ButtonRow.Content` to set the text color for different states.
        public let titleStyle: TextRow.Style?

        public init(
            size: Size? = nil,
            tintColor: UIColor? = nil,
            type: UIButton.ButtonType = .system,
            titleStyle: TextRow.Style? = nil
        ) {
            self.size = size
            self.tintColor = tintColor
            self.type = type
            self.titleStyle = titleStyle
        }
    }

    public convenience init(style: Style) {
        self.init(type: style.type)

        translatesAutoresizingMaskIntoConstraints = false

        size = style.size
        tintColor = style.tintColor

        if let titleStyle = style.titleStyle {
            titleLabel?.do {
                $0.font = titleStyle.font
                $0.textAlignment = titleStyle.alignment
                $0.numberOfLines = titleStyle.numberOfLines
                $0.lineBreakMode = titleStyle.lineBreakMode
            }
        }

        addTarget(self, action: #selector(buttonDidTouchDown(_:)), for: .touchDown)
        addTarget(self, action: #selector(buttonDidClick(_:)), for: .touchUpInside)
    }
}

// MARK: ContentConfigurableView

extension ButtonRow: ContentConfigurableView {
    /// UIButton's `image`, `title`, and `titleColor` have different values in different states.
    ///
    /// Considering that Epoxy will use `Style` as an identifier for reuse,
    /// some states of UIButton are not suitable to be placed in `Style`.
    ///
    /// So here, `Content` is designed as an enum, and the state and the content in that state are set at the same time.
    public enum Content: Equatable {
        public struct StateContent: Equatable {
            public let image: ImageRow.ImageType?
            public let title: TextRow.Content?
            public let titleColor: UIColor

            public init(
                image: ImageRow.ImageType? = nil,
                title: TextRow.Content? = nil,
                titleColor: ConvertibleToColor = UIColor.label
            ) {
                self.image = image
                self.title = title
                self.titleColor = titleColor.color
            }
        }

        case normal(StateContent)
        case disabled(StateContent)
        case selected(StateContent)
        case highlighted(StateContent)

        /// Conveniently set styles in `.normal` state
        public init(normal content: StateContent) {
            self = .normal(content)
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        func _set(with stateContent: Content.StateContent, for state: UIControl.State) {
            if let image = stateContent.image {
                setImage(image.image, for: state)
            }

            if let title = stateContent.title {
                switch title {
                case .text(let value):
                    setTitle(value, for: state)

                case .attributedText(let value):
                    setAttributedTitle(value, for: state)
                }
            }

            setTitleColor(stateContent.titleColor, for: state)
        }

        switch content {
        case .normal(let stateContent):
            isEnabled = true
            isSelected = false
            isHighlighted = false

            _set(with: stateContent, for: .normal)

        case .disabled(let stateContent):
            isEnabled = false
            isSelected = false
            isHighlighted = false

            _set(with: stateContent, for: .disabled)

        case .selected(let stateContent):
            isSelected = true
            isHighlighted = false

            _set(with: stateContent, for: .selected)

        case .highlighted(let stateContent):
            isSelected = false
            isHighlighted = true

            _set(with: stateContent, for: .highlighted)
        }
    }
}

// MARK: BehaviorsConfigurableView

extension ButtonRow: BehaviorsConfigurableView {
    /// For a custom Row inherited from `UIControl`, you can also use this type to set the control behavior,
    /// and use the generic T to access the custom `UIImageView` that may exist in the control.
    public struct Behaviors<T: UIImageView> {
        /// Asynchronously updates the image.
        public let updateImage: ImageRow.Behaviors<T>?

        /// Closure for touch down event.
        public let didTouchDown: ButtonClosure?

        /// Closure for tap event.
        public let didTap: ButtonClosure?

        public init(
            updateImage: ImageRow.Behaviors<T>? = nil,
            didTouchDown: ButtonClosure? = nil,
            didTap: ButtonClosure? = nil
        ) {
            self.updateImage = updateImage
            self.didTouchDown = didTouchDown
            self.didTap = didTap
        }
    }

    public func setBehaviors(_ behaviors: Behaviors<UIImageView>?) {
        if let updateImage = behaviors?.updateImage {
            if let asyncUpdateImage = updateImage.asyncUpdateImage {
                asyncUpdateImage { [weak self] in self?.imageView?.image = $0 }
            }

            if let concurrencyUpdateImage = updateImage.concurrencyUpdateImage {
                Task {
                    let _image = await concurrencyUpdateImage()
                    await MainActor.run { imageView?.image = _image }
                }
            }

            if let customUpdateImage = updateImage.customUpdateImage {
                weak var imageView = imageView
                customUpdateImage(imageView)
            }
        }

        didTouchDown = behaviors?.didTouchDown
        didTap = behaviors?.didTap
    }
}
