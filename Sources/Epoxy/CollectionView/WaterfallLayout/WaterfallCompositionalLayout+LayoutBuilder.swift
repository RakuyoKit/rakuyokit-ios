//
//  WaterfallCompositionalLayout+LayoutBuilder.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//
//  Most of the content is referenced from: https://github.com/eeshishko/WaterfallTrueCompositionalLayout
//

import UIKit

// MARK: - WaterfallCompositionalLayout.LayoutBuilder

extension WaterfallCompositionalLayout {
    final class LayoutBuilder {
        private let collectionWidth: CGFloat
        private let columnCount: CGFloat
        private let arrangementStyle: Configuration.ArrangementStyle
        private var columnHeights: [CGFloat]
        private let itemWidthProvider: ItemWidthProvider?
        private let itemHeightProvider: ItemHeightProvider
        private let interItemSpacing: CGFloat
        private let contentInsets: NSDirectionalEdgeInsets

        init(config: Configuration, collectionWidth: CGFloat) {
            self.collectionWidth = collectionWidth
            columnCount = CGFloat(config.columnCount)
            arrangementStyle = config.arrangementStyle
            columnHeights = [CGFloat](repeating: 0, count: config.columnCount)
            itemWidthProvider = config.itemWidthProvider
            itemHeightProvider = config.itemHeightProvider
            interItemSpacing = config.interItemSpacing
            contentInsets = config.contentInsets.edgeInsets
        }

        #if !os(watchOS)
        func makeLayoutItem(for row: Int) -> Layout.GroupCustomItem {
            let frame = frame(for: row)
            columnHeights[columnIndex(for: row)] = frame.maxY + interItemSpacing
            return .init(frame: frame)
        }
        #endif

        func maxColumnHeight() -> CGFloat {
            columnHeights.max() ?? 0
        }
    }
}

extension WaterfallCompositionalLayout.LayoutBuilder {
    private var columnWidth: CGFloat {
        let spacing = (columnCount - 1) * interItemSpacing + contentInsets.leading + contentInsets.trailing
        return (collectionWidth - spacing) / columnCount
    }

    fileprivate func frame(for row: Int) -> CGRect {
        let width = itemWidthProvider?(row, collectionWidth) ?? columnWidth
        let height = itemHeightProvider(row, width)
        let size = CGSize(width: width, height: height)
        let origin = itemOrigin(for: row, width: size.width)
        return .init(origin: origin, size: size)
    }

    private func itemOrigin(for row: Int, width: CGFloat) -> CGPoint {
        let index = columnIndex(for: row)
        let x = (width + interItemSpacing) * CGFloat(index)
        let y = columnHeights[index].rounded()
        return .init(x: x, y: y)
    }

    private func columnIndex(for row: Int) -> Int {
        switch arrangementStyle {
        case .inOrder:
            row % Int(columnCount)

        case .compact:
            columnHeights
                .enumerated()
                .min(by: { $0.element < $1.element })?
                .offset ?? 0
        }
    }
}
