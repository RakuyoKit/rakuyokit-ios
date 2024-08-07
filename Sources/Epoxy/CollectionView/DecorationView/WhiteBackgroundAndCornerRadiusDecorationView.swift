//
//  WhiteBackgroundAndCornerRadiusDecorationView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

import RAKConfig

// MARK: - WhiteBackgroundAndCornerRadiusDecorationView

// A series of views for setting white background and corner radius for UICollectionView sections

open class WhiteBackgroundAndCornerRadiusDecorationView: WhiteBackgroundDecorationView {
    override open func config() {
        super.config()
        
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
}

// MARK: - WhiteBackgroundAndTopCornerRadiusDecorationView

open class WhiteBackgroundAndTopCornerRadiusDecorationView: WhiteBackgroundAndCornerRadiusDecorationView {
    override open func config() {
        super.config()
        
        // Top left & top right corners
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
        ]
    }
}

// MARK: - WhiteBackgroundAndBottomCornerRadiusDecorationView

open class WhiteBackgroundAndBottomCornerRadiusDecorationView: WhiteBackgroundAndCornerRadiusDecorationView {
    override open func config() {
        super.config()
        
        // Bottom left & bottom right corners
        layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ]
    }
}
#endif
