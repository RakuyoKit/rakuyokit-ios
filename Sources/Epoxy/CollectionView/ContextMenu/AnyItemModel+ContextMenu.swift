//
//  AnyItemModel+ContextMenu.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCollectionView

// MARK: - AnyItemModel + ContextMenuProviding

extension AnyItemModel: ContextMenuProviding { }

// MARK: InternalItemModeling

extension AnyItemModel {
    public func handleWillShowContextMenu(
        _ cell: ItemWrapperView,
        with metadata: ItemCellMetadata
    ) -> UIContextMenuConfiguration? {
        let config = model.handleWillShowContextMenu(cell, with: metadata)
        if let view = cell.view {
            return willShowContextMenu?(.init(view: view, metadata: metadata)) ?? config
        }
        return config
    }
}
