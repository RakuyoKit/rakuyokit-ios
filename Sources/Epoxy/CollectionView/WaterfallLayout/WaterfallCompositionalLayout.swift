//
//  WaterfallCompositionalLayout.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//
//  Most of the content is referenced from: https://github.com/eeshishko/WaterfallTrueCompositionalLayout
//

import UIKit

import Then

/// Waterfall like layout
///
/// Most of the content is referenced from: https://github.com/eeshishko/WaterfallTrueCompositionalLayout
public enum WaterfallCompositionalLayout {
    #if !os(watchOS)
    /// Creates `NSCollectionLayoutSection` instance for `WaterfallCompositionalLayout`
    ///
    /// - Parameters:
    ///   - environment: environment which is accessible on provider closure for `UICollectionView`
    ///   - config: Parameters describing your desired layout
    /// - Returns: waterfall layout
    public static func makeLayoutSection<T: Layout.Section>(environment: Layout.Environment, config: Configuration) -> T {
        let itemProvider = LayoutBuilder(
            config: config,
            collectionWidth: environment.container.effectiveContentSize.width
        )

        let items = (0 ..< config.itemCountProvider()).map {
            itemProvider.makeLayoutItem(for: $0)
        }

        let group = Layout.Group.custom(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(itemProvider.maxColumnHeight())
            ),
            itemProvider: { _ in items }
        )

        return .init(group: group).then {
            $0.contentInsets = config.contentInsets.edgeInsets
        }
    }
    #endif
}
