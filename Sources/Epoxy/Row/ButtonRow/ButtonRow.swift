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

    /// Expanded scope
    private lazy var expandedInsets: EdgeInsets = .zero

    /// Closure for `.touchDown` event.
    private lazy var didTouchDown: ButtonClosure? = nil

    /// Closure for `.touchUpInside` event.
    private lazy var didTap: ButtonClosure? = nil

    /// Closure for `.menuActionTriggered` event. Only available on iOS 14.
    private lazy var didTriggerMenuAction: ButtonClosure? = nil
}

// MARK: Life cycle

extension ButtonRow {
    override public var intrinsicContentSize: CGSize {
        lazy var superSize = super.intrinsicContentSize
        guard let size else { return superSize }

        return .init(
            width: size.width ?? superSize.width,
            height: size.height ?? superSize.height
        )
    }

    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard !super.point(inside: point, with: event) else { return true }

        guard !isHidden else { return false }

        let insets = expandedInsets.uiEdgeInsets

        let newRect = CGRect(
            x: bounds.origin.x - insets.left,
            y: bounds.origin.y - insets.top,
            width: bounds.size.width + insets.left + insets.right,
            height: bounds.size.height + insets.top + insets.bottom
        )

        return newRect.contains(point)
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
    public struct Style: Hashable, RowConfigureApplicable {
        /// button size
        ///
        /// When a side value is `UIView.noIntrinsicMetric`, adaptive size will be used on that side
        public let size: OptionalCGSize?

        /// Expanded scope
        ///
        /// Relative size. Increase/decrease based on the original frame.
        /// For example, `frame.y + expandedScope.top`
        public let expandedInsets: EdgeInsets

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

        /// The edge of button
        public let edgeInsets: EdgeInsets

        public init(
            size: OptionalCGSize? = nil,
            expandedInsets: EdgeInsets = .zero,
            tintColor: UIColor? = nil,
            type: UIButton.ButtonType = .system,
            imageContentModel: UIView.ContentMode? = nil,
            titleStyle: TextRow.Style? = nil,
            edgeInsets: EdgeInsets = .zero
        ) {
            self.size = size
            self.expandedInsets = expandedInsets
            self.tintColor = tintColor
            self.type = type
            self.imageContentModel = imageContentModel
            self.titleStyle = titleStyle
            self.edgeInsets = edgeInsets
        }

        public func apply(to row: UIButton) {
            row.tintColor = tintColor
            row.contentEdgeInsets = edgeInsets.uiEdgeInsets

            if let imageContentModel {
                row.imageView?.contentMode = imageContentModel
            }

            if let titleStyle {
                row.titleLabel?.do {
                    $0.font = titleStyle.font
                    $0.textAlignment = titleStyle.alignment
                    $0.numberOfLines = titleStyle.numberOfLines
                    $0.lineBreakMode = titleStyle.lineBreakMode
                }
            }
        }
    }

    public convenience init(style: Style) {
        self.init(type: style.type)

        translatesAutoresizingMaskIntoConstraints = false

        size = style.size
        expandedInsets = style.expandedInsets

        style.apply(to: self)

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
    public enum ButtonContent<T>: Equatable, ButtonRowStateContent, RowConfigureApplicable {
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

            public init(
                image: (some ButtonImageContentProviding)? = nil,
                title: TextRow.Content? = nil,
                titleColor: ConvertibleToColor = UIColor.label
            ) {
                self.init(image: .init(image), title: title, titleColor: titleColor)
            }

            public func apply(to row: UIButton, for state: UIControl.State) {
                if let image {
                    weak var button = row
                    image.setForView(button, state: state)
                } else {
                    row.setImage(nil, for: state)
                }

                switch title {
                case .text(let value):
                    row.setTitle(value, for: state)

                case .attributedText(let value):
                    row.setAttributedTitle(value, for: state)

                case .none:
                    row.setTitle(nil, for: state)
                    row.setAttributedTitle(nil, for: state)
                }

                row.setTitleColor(titleColor, for: state)
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

        /// Conveniently set styles in `.normal` state
        public init(
            image: (some ButtonImageContentProviding)? = nil,
            title: TextRow.Content? = nil,
            titleColor: ConvertibleToColor = UIColor.label
        ) {
            self.init(image: .init(image), title: title, titleColor: titleColor)
        }

        public func apply(to row: UIButton) {
            switch self {
            case .normal(let stateContent):
                row.isEnabled = true
                row.isSelected = false
                row.isHighlighted = false

                stateContent.apply(to: row, for: .normal)

            case .disabled(let stateContent):
                row.isEnabled = false
                row.isSelected = false
                row.isHighlighted = false

                stateContent.apply(to: row, for: .disabled)

            case .selected(let stateContent):
                row.isSelected = true
                row.isHighlighted = false

                stateContent.apply(to: row, for: .selected)

            case .highlighted(let stateContent):
                row.isSelected = false
                row.isHighlighted = true

                stateContent.apply(to: row, for: .highlighted)
            }
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        content.apply(to: self)
    }
}

// MARK: BehaviorsConfigurableView

extension ButtonRow: BehaviorsConfigurableView {
    public typealias Behaviors = ButtonBehaviors<ButtonRow>

    /// For a custom Row inherited from `UIControl`, you can also use this type to set the control behavior,
    /// and use the generic T to access the custom `UIImageView` that may exist in the control.
    public struct ButtonBehaviors<T>: HigherOrderFunctionalizable {
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
