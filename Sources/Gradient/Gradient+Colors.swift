//
//  Gradient+Colors.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

import RAKCore

extension Gradient {
    /// Wrapper for an array of gradient colors
    public struct Colors: Hashable {
        /// Array of colors
        public let colors: [UIColor]
        
        public init(_ colors: [ConvertibleToColor]) {
            self.colors = colors.map(\.color)
        }
        
        public init(_ colors: [UIColor]) {
            self.colors = colors
        }
    }
}
