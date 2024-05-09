//
//  SpacerRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(visionOS)
import UIKit

import EpoxyCore
import RAKConfig

// MARK: - SpacerRow

/// View used for filling spacing in CollectionView
public final class SpacerRow: UIView {
    /// Style
    private let style: Style
    
    public init(style: Style) {
        self.style = style
        
        super.init(frame: .zero)
        
        config()
    }
    
    required init?(coder: NSCoder) {
        style = .default
        
        super.init(coder: coder)
        
        config()
    }
}

// MARK: StyledView

extension SpacerRow: StyledView {
    public struct Style: Hashable {
        /// Default
        public static let `default`: Self = .init()
        
        /// Height
        public let height: CGFloat
        
        /// Background color
        public let backgroundColor: UIColor?
        
        public init(
            height: CGFloat = ListSpacing.normal.spacing,
            backgroundColor: UIColor? = Config.color.backgroundGray.main
        ) {
            self.height = height
            self.backgroundColor = backgroundColor
        }
    }
}

// MARK: ContentConfigurableView

extension SpacerRow: ContentConfigurableView { }

// MARK: BehaviorsConfigurableView

extension SpacerRow: BehaviorsConfigurableView { }

// MARK: - Life cycle

extension SpacerRow {
    override public var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: style.height)
    }
}

// MARK: - Config

extension SpacerRow {
    private func config() {
        backgroundColor = style.backgroundColor
    }
}

// MARK: - SpacerRow.Style + ExpressibleByFloatLiteral

extension SpacerRow.Style: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self.init(height: CGFloat(value))
    }
}

// MARK: - SpacerRow.Style + ExpressibleByIntegerLiteral

extension SpacerRow.Style: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(height: CGFloat(value))
    }
}
#endif
