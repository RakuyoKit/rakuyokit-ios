//
//  TextFieldRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/20.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import Combine
import EpoxyCore
import RAKCore

// MARK: - TextFieldRow

/// Replace `UITextField` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `TextFieldRow.Style`, `TextFieldRow.Content` and `TextFieldRow.Behaviors`.
public final class TextFieldRow: UITextField {
    private lazy var placeholderColor: UIColor? = nil

    private lazy var didEndEditing: Behaviors.TextFieldCallback? = nil

    private lazy var didTextChange: Behaviors.TextFieldValueCallback? = nil

    private lazy var cancellable = Set<AnyCancellable>()
}

// MARK: Action

extension TextFieldRow {
    @objc
    private func textFieldEditingChanged(_ textField: UITextField) {
        guard textField.markedTextRange == nil else { return }
        didTextChange?(textField.text)
    }
}

// MARK: StyledView

extension TextFieldRow: StyledView {
    public struct Style: Hashable, RowConfigureApplicable {
        public let font: UIFont
        public let textColor: UIColor
        public let placeholderColor: UIColor
        public let alignment: NSTextAlignment
        public let clearButtonMode: UITextField.ViewMode
        public let keyboardType: UIKeyboardType
        public let keyboardAppearance: UIKeyboardAppearance
        public let autocapitalizationType: UITextAutocapitalizationType
        public let autocorrectionType: UITextAutocorrectionType
        public let spellCheckingType: UITextSpellCheckingType
        public let textContentType: UITextContentType?
        public let returnKeyType: UIReturnKeyType
        public let enablesReturnKeyAutomatically: Bool

        public init(
            font: UIFont = .systemFont(ofSize: UIFont.labelFontSize),
            textColor: ConvertibleToColor = UIColor.label,
            placeholderColor: ConvertibleToColor = UIColor.placeholderText,
            alignment: NSTextAlignment = .left,
            clearButtonMode: UITextField.ViewMode = .never,
            keyboardType: UIKeyboardType = .default,
            keyboardAppearance: UIKeyboardAppearance = .default,
            autocapitalizationType: UITextAutocapitalizationType = .sentences,
            autocorrectionType: UITextAutocorrectionType = .default,
            spellCheckingType: UITextSpellCheckingType = .default,
            textContentType: UITextContentType? = nil,
            returnKeyType: UIReturnKeyType = .default,
            enablesReturnKeyAutomatically: Bool = false
        ) {
            self.font = font
            self.textColor = textColor.color
            self.placeholderColor = placeholderColor.color
            self.alignment = alignment
            self.clearButtonMode = clearButtonMode
            self.keyboardType = keyboardType
            self.keyboardAppearance = keyboardAppearance
            self.autocapitalizationType = autocapitalizationType
            self.autocorrectionType = autocorrectionType
            self.spellCheckingType = spellCheckingType
            self.textContentType = textContentType
            self.returnKeyType = returnKeyType
            self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        }

        public func apply(to row: UITextField) {
            row.font = font
            row.textColor = textColor
            row.textAlignment = alignment
            row.clearButtonMode = clearButtonMode
            row.keyboardType = keyboardType
            row.keyboardAppearance = keyboardAppearance
            row.autocapitalizationType = autocapitalizationType
            row.autocorrectionType = autocorrectionType
            row.spellCheckingType = spellCheckingType
            row.textContentType = textContentType
            row.returnKeyType = returnKeyType
            row.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        }
    }

    public convenience init(style: Style) {
        self.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        placeholderColor = style.placeholderColor

        style.apply(to: self)

        addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
}

// MARK: ContentConfigurableView

extension TextFieldRow: ContentConfigurableView {
    public struct Content: Equatable, ExpressibleByStringInterpolation, RowConfigureApplicable {
        public let text: String?
        public let placeholder: String?
        public let secure: Bool
        public let isEnabled: Bool

        public init(
            text: String?,
            placeholder: String? = nil,
            secure: Bool = false,
            isEnabled: Bool = true
        ) {
            self.text = text
            self.placeholder = placeholder
            self.secure = secure
            self.isEnabled = isEnabled
        }

        public init(stringLiteral value: String) {
            self.init(text: value)
        }

        public func apply(to row: UITextField) {
            row.text = text
            row.placeholder = placeholder
            row.isSecureTextEntry = secure
            row.isEnabled = isEnabled
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        content.apply(to: self)

        attributedPlaceholder = content.placeholder.flatMap {
            let placeholderColor = placeholderColor ?? textColor ?? .placeholderText
            return .init(string: $0, attributes: [.foregroundColor: placeholderColor])
        }
    }
}

// MARK: BehaviorsConfigurableView

extension TextFieldRow: BehaviorsConfigurableView {
    public struct Behaviors: HigherOrderFunctionalizable {
        public typealias ContentPublisher = AnyPublisher<String, Never>
        public typealias TextFieldCallback = (UITextField) -> Void
        public typealias TextFieldValueCallback = (String?) -> Void

        public let bindContent: ContentPublisher?
        public let didTextChange: TextFieldValueCallback?
        public let didEndEditing: TextFieldCallback?

        public init(
            bindContent: ContentPublisher? = nil,
            didTextChange: TextFieldValueCallback? = nil,
            didEndEditing: TextFieldCallback? = nil
        ) {
            self.bindContent = bindContent
            self.didTextChange = didTextChange
            self.didEndEditing = didEndEditing
        }
    }

    public func setBehaviors(_ behaviors: Behaviors?) {
        for item in cancellable { item.cancel() }

        didEndEditing = behaviors?.didEndEditing

        behaviors?.bindContent?
            .removeDuplicates()
            .sink { [weak self] in
                self?.text = $0
            }
            .store(in: &cancellable)
    }
}

// MARK: UITextFieldDelegate

extension TextFieldRow: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing?(textField)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
#endif
