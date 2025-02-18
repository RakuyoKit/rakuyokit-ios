//
//  SwitchRow.swift
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

// MARK: - SwitchRow

/// Replace `UISwitch` in Epoxy component
///
/// If you want to extend, consider building your own view with
/// the help of `SwitchRow.Style`, `SwitchRow.Content` and `SwitchRow.Behaviors`.
public final class SwitchRow: UISwitch {
    private lazy var didChange: Behaviors.SwitchValueCallback? = nil

    private lazy var cancellable = Set<AnyCancellable>()
}

// MARK: Action

extension SwitchRow {
    @objc
    private func switchViewDidChange(_ switch: UISwitch) {
        didChange?(`switch`.isOn)
    }
}

// MARK: StyledView

extension SwitchRow: StyledView {
    public struct Style: Hashable, RowConfigureApplicable {
        public let scale: CGFloat
        public let onTintColor: UIColor?
        public let thumbTintColor: UIColor?
        public let onImage: UIImage?
        public let offImage: UIImage?

        public init(
            scale: CGFloat = 1,
            onTintColor: ConvertibleToColor? = nil,
            thumbTintColor: ConvertibleToColor? = nil,
            onImage: UIImage? = nil,
            offImage: UIImage? = nil
        ) {
            self.scale = scale
            self.onTintColor = onTintColor?.color
            self.thumbTintColor = thumbTintColor?.color
            self.onImage = onImage
            self.offImage = offImage
        }

        public func apply(to row: UISwitch) {
            row.transform = { CGAffineTransform(scaleX: $0, y: $0) }(scale)
            row.onTintColor = onTintColor
            row.thumbTintColor = thumbTintColor
            row.onImage = onImage
            row.offImage = offImage
        }
    }

    public convenience init(style: Style) {
        self.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        style.apply(to: self)

        addTarget(self, action: #selector(switchViewDidChange(_:)), for: .valueChanged)
    }
}

// MARK: ContentConfigurableView

extension SwitchRow: ContentConfigurableView {
    public struct Content: Equatable, ExpressibleByBooleanLiteral, RowConfigureApplicable {
        public let isOn: Bool
        public let isEnabled: Bool

        public init(isOn: Bool, isEnabled: Bool = true) {
            self.isOn = isOn
            self.isEnabled = isEnabled
        }

        public init(booleanLiteral value: Bool) {
            self.init(isOn: value)
        }

        public func apply(to row: UISwitch) {
            row.isOn = isOn
            row.isEnabled = isEnabled
        }
    }

    public func setContent(_ content: Content, animated _: Bool) {
        content.apply(to: self)
    }
}

// MARK: BehaviorsConfigurableView

extension SwitchRow: BehaviorsConfigurableView {
    public struct Behaviors: HigherOrderFunctionalizable {
        public typealias ContentPublisher = AnyPublisher<Bool, Never>
        public typealias SwitchValueCallback = (Bool) -> Void

        public let bindContent: ContentPublisher?
        public let didChange: SwitchValueCallback?

        public init(
            bindContent: ContentPublisher? = nil,
            didChange: SwitchValueCallback? = nil
        ) {
            self.bindContent = bindContent
            self.didChange = didChange
        }
    }

    public func setBehaviors(_ behaviors: Behaviors?) {
        for item in cancellable { item.cancel() }

        didChange = behaviors?.didChange

        behaviors?.bindContent?
            .removeDuplicates()
            .sink { [weak self] in
                self?.isOn = $0
            }
            .store(in: &cancellable)
    }
}
#endif
