//
//  SupplementaryItem.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

/// Header/Footer
public struct SupplementaryItem {
    /// Style
    public enum Style {
        /// Normal style
        case normal
        
        /// Sticky style
        case pin
    }
    
    /// Header
    let header: Style?
    
    /// Footer
    let footer: Style?
    
    /// Configure Supplementary Item
    ///
    /// - Parameters:
    ///   - header: Section header
    ///   - footer: Section footer
    public init(header: Style? = nil, footer: Style? = nil) {
        self.header = header
        self.footer = footer
    }
}
