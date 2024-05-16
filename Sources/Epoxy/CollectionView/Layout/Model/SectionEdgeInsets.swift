//
//  SectionEdgeInsets.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - SectionEdgeInsets

/// Spacing around the section.
public enum SectionEdgeInsets {
    // swiftlint:disable sorted_enum_cases
    
    /// Only at the top.
    case top(CGFloat)
    
    /// Only at the bottom.
    case bottom(CGFloat)
    
    /// Both top and bottom with the same size.
    case topBottom(CGFloat)
    
    /// Both sides with the same size.
    case bothSides(CGFloat)
    
    /// Custom spacing for all four sides.
    case all(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat)
    
    /// Fully customized using `NSDirectionalEdgeInsets`.
    case custom(NSDirectionalEdgeInsets)
    
    // swiftlint:enable sorted_enum_cases
}

extension SectionEdgeInsets {
    public var edgeInsets: NSDirectionalEdgeInsets {
        switch self {
        case .top(let value):
            .init(top: value, leading: 0, bottom: 0, trailing: 0)
            
        case .bottom(let value):
            .init(top: 0, leading: 0, bottom: value, trailing: 0)
            
        case .topBottom(let value):
            .init(top: value, leading: 0, bottom: value, trailing: 0)
            
        case .bothSides(let value):
            .init(top: 0, leading: value, bottom: 0, trailing: value)
            
        case .all(let top, let leading, let bottom, let trailing):
            .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
            
        case .custom(let edge):
            edge
        }
    }
}

extension SectionEdgeInsets? {
    public var edgeInsets: NSDirectionalEdgeInsets {
        switch self {
        case .none:
            .zero
        case .some(let wrapped):
            wrapped.edgeInsets
        }
    }
}
