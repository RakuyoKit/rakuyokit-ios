//
//  GrayBackgroundDecorationView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

import RAKConfig

// MARK: - WhiteBackgroundDecorationVGray

/// Set a gray background View for UICollectionView Section
open class GrayBackgroundDecorationView: BaseDecorationView {
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig(cornerRadius: nil)
    }
}

// MARK: - GrayBackgroundAndCornerRadiusDecorationView

open class GrayBackgroundAndCornerRadiusDecorationView: BaseDecorationView {
    /// The default rounded corners.
    /// The caller can modify this property globally to achieve the purpose of modifying the global configuration.
    public static let defaultCornerRadius: CGFloat = 12
    
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig()
    }
}

// MARK: - GrayBackgroundAndTopCornerRadiusDecorationView

open class GrayBackgroundAndTopCornerRadiusDecorationView: BaseDecorationView {
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig(maskedCorners: [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
        ])
    }
}

// MARK: - GrayBackgroundAndBottomCornerRadiusDecorationView

open class GrayBackgroundAndBottomCornerRadiusDecorationView: BaseDecorationView {
    override open var decorationViewConfig: DecorationViewConfig {
        .customDecorationViewConfig(maskedCorners: [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ])
    }
}

extension DecorationViewConfig {
    fileprivate static func customDecorationViewConfig(
        cornerRadius: CGFloat? = GrayBackgroundAndCornerRadiusDecorationView.defaultCornerRadius,
        maskedCorners: CACornerMask = []
    ) -> Self {
        .init(
            backgroundColor: Config.color.white,
            cornerRadius: cornerRadius,
            maskedCorners: maskedCorners
        )
    }
}
#endif
