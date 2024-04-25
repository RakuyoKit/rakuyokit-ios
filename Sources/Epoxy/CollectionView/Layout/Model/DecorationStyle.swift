//
//  DecorationStyle.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - DecorationStyle

/// Decoration view styles
public enum DecorationStyle {
    /// Custom decoration view
    case custom(_ viewType: UICollectionReusableView.Type)
    
    /// White background
    case whiteBackground
    
    /// White background with 10px corner radius
    case whiteBackgroundAndCornerRadius(position: CornerRadiusPosition = .all)
}

// MARK: DecorationStyle.CornerRadiusPosition

extension DecorationStyle {
    /// Rounded corner styles
    public enum CornerRadiusPosition {
        /// All positions
        case all

        /// Bottom
        case bottom

        /// Top
        case top
    }
}
