//
//  NSCollectionLayoutDimension+QLCD.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension Layout.Size {
    /// A simplified version of `.init(widthDimension:heightDimension:)`.
    ///
    /// - Parameters:
    ///   - width: The width dimension. Default is `.fractionalWidth(1)`.
    ///   - height: The height dimension. Default is `.fractionalHeight(1)`.
    public convenience init(
        width: Layout.Dimension = .fractionalWidth(1),
        height: Layout.Dimension = .fractionalHeight(1)
    ) {
        self.init(widthDimension: width, heightDimension: height)
    }
}
#endif
