//
//  Gradient+Colors.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import RAKCore

public extension Gradient {
    /// Wrapper for an array of gradient colors
    struct Colors {
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