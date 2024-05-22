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

// MARK: - AnyItemModel + RAKInternalItemModeling

extension AnyItemModel: RAKInternalItemModeling {
    public func handleWillShowContextMenu(
        _ cell: ItemWrapperView,
        with metadata: ItemCellMetadata
    ) -> UIContextMenuConfiguration? {
        let config = (model as? RAKInternalItemModeling)?.handleWillShowContextMenu(cell, with: metadata)
        if let view = cell.view {
            return willShowContextMenu?(.init(view: view, metadata: metadata)) ?? config
        }
        return config
    }
}
