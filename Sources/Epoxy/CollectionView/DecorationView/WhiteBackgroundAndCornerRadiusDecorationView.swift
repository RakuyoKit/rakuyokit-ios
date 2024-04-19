//
//  WhiteBackgroundAndCornerRadiusDecorationView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import RAKConfig

// MARK: - WhiteBackgroundAndCornerRadiusDecorationView

// A series of views for setting white background and corner radius for UICollectionView sections

open class WhiteBackgroundAndCornerRadiusDecorationView: WhiteBackgroundDecorationView {
    override open func config() {
        super.config()
        
        layer.cornerRadius = 10
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
