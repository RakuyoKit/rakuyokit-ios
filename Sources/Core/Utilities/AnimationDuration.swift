//
//  AnimationDuration.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - AnimationDuration

/// Some preset animation durations
///
/// Helps you unify the timing of animations in your project
/// For example, use `UIView.rak.animate(withDuration: .short) { ... }`
public enum AnimationDuration {
    case short

    case slightlyShort

    case normal

    case slightlyLong

    case long

    /// Customization of the duration is allowed, but please think carefully before using it:
    /// **Do you need to customize this time instead of using other preset durations?**
    case custom(RawValue)
}

// MARK: RawRepresentable

extension AnimationDuration: RawRepresentable {
    public typealias RawValue = TimeInterval

    public var rawValue: RawValue {
        switch self {
        case .short: 0.15
        case .slightlyShort: 0.2
        case .normal: 0.3
        case .slightlyLong: 0.4
        case .long: 0.5
        case .custom(let value):
            value
        }
    }

    public init(rawValue: RawValue) {
        switch rawValue {
        case Self.short.rawValue:
            self = .short
        case Self.slightlyShort.rawValue:
            self = .slightlyShort
        case Self.normal.rawValue:
            self = .normal
        case Self.slightlyLong.rawValue:
            self = .slightlyLong
        case Self.long.rawValue:
            self = .long
        default:
            self = .custom(rawValue)
        }
    }
}
