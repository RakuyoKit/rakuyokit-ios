//
//  DecorationStyle.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

/// Decoration view styles
public enum DecorationStyle {
    /// Rounded corner styles
    public enum CornerRadiusPosition {
        /// All positions
        case all
        
        /// Bottom
        case bottom
        
        /// Top
        case top
    }
    
    /// Custom decoration view
    case custom(_ viewType: UICollectionReusableView.Type)
    
    /// White background
    case whiteBackground
    
    /// White background with 10px corner radius
    case whiteBackgroundAndCornerRadius(position: CornerRadiusPosition = .all)
}
