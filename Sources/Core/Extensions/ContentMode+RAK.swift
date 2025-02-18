//
//  ContentMode+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/6/12.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

#if DEBUG && !os(watchOS)
extension UIView.ContentMode: @retroactive CaseIterable {
    public static var allCases: [UIView.ContentMode] {
        [
            .scaleToFill,
            .scaleAspectFit,
            .scaleAspectFill,
            .redraw,
            .center,
            .top,
            .bottom,
            .left,
            .right,
            .topLeft,
            .topRight,
            .bottomLeft,
            .bottomRight,
        ]
    }
}
#endif
