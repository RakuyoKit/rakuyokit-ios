//
//  SectionEdgeInsets.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

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
    
    /// Spacing for card type: 0 at top, 16 at leading and trailing, 16 at bottom.
    case card(bottom: CGFloat = ListSpacing.normal.spacing)
    
    /// Custom spacing for all four sides.
    case all(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat)
    
    /// Fully customized using `NSDirectionalEdgeInsets`.
    case custom(NSDirectionalEdgeInsets)
    
    // swiftlint:enable sorted_enum_cases
}

public extension SectionEdgeInsets {
    var edgeInsets: NSDirectionalEdgeInsets {
        switch self {
        case .top(let value):
            return .init(top: value, leading: 0, bottom: 0, trailing: 0)
            
        case .bottom(let value):
            return .init(top: 0, leading: 0, bottom: value, trailing: 0)
            
        case .topBottom(let value):
            return .init(top: value, leading: 0, bottom: value, trailing: 0)
            
        case .bothSides(let value):
            return .init(top: 0, leading: value, bottom: 0, trailing: value)
            
        case .card(let value):
            return .init(top: 0, leading: 16, bottom: value, trailing: 16)
            
        case let .all(top, leading, bottom, trailing):
            return .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
            
        case .custom(let edge):
            return edge
        }
    }
}

public extension Optional where Wrapped == SectionEdgeInsets {
    var edgeInsets: NSDirectionalEdgeInsets {
        switch self {
        case .none:
            return .zero
        case .some(let wrapped):
            return wrapped.edgeInsets
        }
    }
}
