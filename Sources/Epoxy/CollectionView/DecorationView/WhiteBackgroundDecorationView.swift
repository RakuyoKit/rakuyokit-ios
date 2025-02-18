//
//  WhiteBackgroundDecorationView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

import RAKConfig

// MARK: - WhiteBackgroundDecorationView

/// Set a white background View for UICollectionView Section
open class WhiteBackgroundDecorationView: BaseDecorationView {
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig(cornerRadius: nil)
    }
}

// MARK: - WhiteBackgroundAndCornerRadiusDecorationView

open class WhiteBackgroundAndCornerRadiusDecorationView: BaseDecorationView {
    /// The default rounded corners.
    /// The caller can modify this property globally to achieve the purpose of modifying the global configuration.
    public static let defaultCornerRadius: CGFloat = 12
    
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig()
    }
}

// MARK: - WhiteBackgroundAndTopCornerRadiusDecorationView

open class WhiteBackgroundAndTopCornerRadiusDecorationView: BaseDecorationView {
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig(maskedCorners: [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
        ])
    }
}

// MARK: - WhiteBackgroundAndBottomCornerRadiusDecorationView

open class WhiteBackgroundAndBottomCornerRadiusDecorationView: BaseDecorationView {
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig(maskedCorners: [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ])
    }
}

extension DecorationViewConfig {
    fileprivate static func customDecorationViewConfig(
        cornerRadius: CGFloat? = WhiteBackgroundAndCornerRadiusDecorationView.defaultCornerRadius,
        maskedCorners: CACornerMask = []
    ) -> Self {
        .init(
            backgroundColor: Config.color.backgroundGray.main,
            cornerRadius: cornerRadius,
            maskedCorners: maskedCorners
        )
    }
}
#endif
