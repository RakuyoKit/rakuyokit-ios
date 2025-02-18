//
//  DecorationStyle.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

// MARK: - DecorationStyle

/// Decoration view styles
public enum DecorationStyle {
    /// Custom decoration view
    case custom(_ viewType: UICollectionReusableView.Type)
    
    /// White background
    case whiteBackground
    
    /// White background with corner radius
    case whiteBackgroundAndCornerRadius(position: CornerRadiusPosition = .all)
    
    /// Gray background
    case grayBackground
    
    /// Gray background with corner radius
    case grayBackgroundAndCornerRadius(position: CornerRadiusPosition = .all)
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
#endif
