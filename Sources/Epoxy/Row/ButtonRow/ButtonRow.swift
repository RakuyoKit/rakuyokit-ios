//
//  ButtonRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(tvOS) && !os(watchOS) && !os(visionOS)
import UIKit

import EpoxyCore
import RAKCore

// MARK: - ButtonRow

/// Replace `UIButton` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `ButtonRow.Style`, `ButtonRow.ButtonContent` and `ButtonRow.ButtonBehaviors`.
public final class ButtonRow: UIButton {
    private lazy var size: OptionalCGSize? = nil

    /// Closure for `.touchDown` event.
    private lazy var didTouchDown: ButtonClosure? = nil

    /// Closure for `.touchUpInside` event.
    private lazy var didTap: ButtonClosure? = nil

    /// Closure for `.menuActionTriggered` event. Only available on iOS 14.
    private lazy var didTriggerMenuAction: ButtonClosure? = nil
}

// MARK: - Life cycle

extension ButtonRow {
    override public var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        guard let size else { return superSize }

        return .init(
            width: size.width ?? superSize.width,
            height: size.height ?? superSize.height
        )
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

    @objc
    private func buttonDidTriggerMenuAction(_ button: UIButton) {
        didTriggerMenuAction?(button)
    }
}

// MARK: StyledView

extension ButtonRow: StyledView {
    public struct Style: Hashable {
        /// button size
        ///
        /// When a side value is `UIView.noIntrinsicMetric`, adaptive size will be used on that side
        public let size: OptionalCGSize?

        /// The tint color.
        public let tintColor: UIColor?

        /// The button type.
        public let type: UIButton.ButtonType

        /// `imageView`'s `contentMode`
        public let imageContentModel: UIView.ContentMode?

        /// The title style.
        ///
        /// The `color` property will be ignored.
        /// Please use `ButtonRow.Content` to set the text color for different states.
        public let titleStyle: TextRow.Style?

        public init(
            size: OptionalCGSize? = nil,
            tintColor: UIColor? = nil,
            type: UIButton.ButtonType = .system,
            imageContentModel: UIView.ContentMode? = nil,
            titleStyle: TextRow.Style? = nil
        ) {
            self.size = size
            self.tintColor = tintColor
            self.type = type
            self.imageContentModel = imageContentModel
            self.titleStyle = titleStyle
        }
    }

    public convenience init(style: Style) {
        self.init(type: style.type)

        translatesAutoresizingMaskIntoConstraints = false

        size = style.size
        tintColor = style.tintColor

        if let imageContentModel = style.imageContentModel {
            imageView?.contentMode = imageContentModel
        }

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

        if #available(iOS 14.0, tvOS 14.0, *) {
            addTarget(self, action: #selector(buttonDidTriggerMenuAction(_:)), for: .menuActionTriggered)
        }
    }
}

// MARK: ContentConfigurableView

extension ButtonRow: ContentConfigurableView {
    public typealias Content = ButtonContent<ButtonRow>

    /// UIButton's `image`, `title`, and `titleColor` have different values in different states.
    ///
    /// Considering that Epoxy will use `Style` as an identifier for reuse,
    /// some states of UIButton are not suitable to be placed in `Style`.
    ///
    /// So here, `Content` is designed as an enum, and the state and the content in that state are set at the same time.
    public enum ButtonContent<T>: Equatable, ButtonRowStateContent {
        /// Usage example:
        /// ```swift
        /// ButtonRow.groupItem(
        ///     dataID: DefaultDataID.noneProvided,
        ///     content: .init(UIImage()),
        ///     style: .init())
        /// ```
        ///
        /// There are also some convenience methods provided in ``FastImageContentProviding``:
        /// ```swift
        /// ButtonRow.groupItem(
        ///     dataID: DefaultDataID.noneProvided,
        ///     content: .sfSymbols(name: ""),
        ///     style: .init())
        /// ```
        ///
        /// You can implement your own data provider via the ``ButtonImageContentProviding`` protocol
        public typealias ImageContent = AnyButtonImageContent<T>

        ///
        public struct StateContent: Equatable, ButtonRowStateContent {
            public let image: ImageContent?
            public let title: TextRow.Content?
            public let titleColor: UIColor

            public init(
                image: ImageContent? = nil,
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
        public init(
            image: ImageContent? = nil,
            title: TextRow.Content? = nil,
            titleColor: ConvertibleToColor = UIColor.label
        ) {
            self = .normal(.init(image: image, title: title, titleColor: titleColor))
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        func _set(with stateContent: Content.StateContent, for state: UIControl.State) {
            if let image = stateContent.image {
                weak var this = self
                image.setForView(this, state: state)
            } else {
                setImage(nil, for: state)
            }

            switch stateContent.title {
            case .text(let value):
                setTitle(value, for: state)

            case .attributedText(let value):
                setAttributedTitle(value, for: state)

            case .none:
                setTitle(nil, for: state)
                setAttributedTitle(nil, for: state)
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
    public typealias Behaviors = ButtonBehaviors<ButtonRow>

    /// For a custom Row inherited from `UIControl`, you can also use this type to set the control behavior,
    /// and use the generic T to access the custom `UIImageView` that may exist in the control.
    public struct ButtonBehaviors<T> {
        /// Closure for touch down event.
        public let didTouchDown: ButtonClosure?

        /// Closure for tap event.
        public let didTap: ButtonClosure?

        /// Closure for `.menuActionTriggered` event. Only available on iOS 14.
        public let didTriggerMenuAction: ButtonClosure?

        public init(
            didTouchDown: ButtonClosure? = nil,
            didTap: ButtonClosure? = nil,
            didTriggerMenuAction: ButtonClosure? = nil
        ) {
            self.didTouchDown = didTouchDown
            self.didTap = didTap
            self.didTriggerMenuAction = didTriggerMenuAction
        }
    }

    public func setBehaviors(_ behaviors: Behaviors?) {
        didTouchDown = behaviors?.didTouchDown
        didTap = behaviors?.didTap

        if
            #available(iOS 14.0, *),
            let _didTriggerMenuAction = behaviors?.didTriggerMenuAction
        {
            didTriggerMenuAction = _didTriggerMenuAction
        } else {
            didTriggerMenuAction = nil
        }
    }
}
#endif
