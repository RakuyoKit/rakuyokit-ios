//
//  WaterfallCompositionalLayout+Config.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//
//  Most of the content is referenced from: https://github.com/eeshishko/WaterfallTrueCompositionalLayout
//

import UIKit

extension WaterfallCompositionalLayout {
    public typealias ItemWidthProvider = (_ index: Int, _ collectionWidth: CGFloat) -> CGFloat
    public typealias ItemHeightProvider = (_ index: Int, _ itemWidth: CGFloat) -> CGFloat
    public typealias ItemCountProvider = () -> Int

    public struct Configuration {
        /// The arrangement of elements in the collection view
        public enum ArrangementStyle {
            /// Arrange in order of list
            ///
            ///   +------------------+
            ///   |   +---+   +---+  |
            ///   |   |   |   | 2 |  |
            ///   |   | 1 |   +---+  |
            ///   |   |   |          |
            ///   |   +---+   +---+  |
            ///   |           | 4 |  |
            ///   |   +---+   +---+  |
            ///   |   | 3 |          |
            ///   |   |   |          |
            ///   |   +---+          |
            ///   +------------------+
            case inOrder

            /// Consider the height of the Item, and arrange the elements in the list as
            /// compactly and aligned as possible to avoid excessive height differences.
            ///
            ///   +------------------+
            ///   |   +---+   +---+  |
            ///   |   |   |   | 2 |  |
            ///   |   | 1 |   +---+  |
            ///   |   |   |          |
            ///   |   +---+   +---+  |
            ///   |           | 3 |  |
            ///   |   +---+   |   |  |
            ///   |   | 4 |   +---+  |
            ///   |   +---+          |
            ///   +------------------+
            case compact
        }

        public let columnCount: Int
        public let arrangementStyle: ArrangementStyle
        public let interItemSpacing: CGFloat
        public let contentInsets: SectionEdgeInsets?
        public let itemCountProvider: ItemCountProvider
        public let itemWidthProvider: ItemWidthProvider?
        public let itemHeightProvider: ItemHeightProvider

        /// Initialization for configuration of waterfall compositional layout section
        ///
        /// - Parameters:
        ///   - columnCount: A number of columns
        ///   - arrangementStyle: The arrangement of elements in the collection view
        ///   - interItemSpacing: A spacing between columns and rows
        ///   - contentInsets: Spacing around Section
        ///   - itemCountProvider: Closure providing a number of items in a section
        ///   - itemHeightProvider: Closure for providing an item height at a specific index
        public init(
            columnCount: Int,
            arrangementStyle: ArrangementStyle,
            interItemSpacing: CGFloat = 0,
            contentInsets: SectionEdgeInsets? = nil,
            itemCountProvider: @escaping ItemCountProvider,
            itemWidthProvider: ItemWidthProvider? = nil,
            itemHeightProvider: @escaping ItemHeightProvider
        ) {
            self.columnCount = columnCount
            self.arrangementStyle = arrangementStyle
            self.interItemSpacing = interItemSpacing
            self.contentInsets = contentInsets
            self.itemCountProvider = itemCountProvider
            self.itemWidthProvider = itemWidthProvider
            self.itemHeightProvider = itemHeightProvider
        }
    }
}
