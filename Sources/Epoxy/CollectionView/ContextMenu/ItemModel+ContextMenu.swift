//
//  ItemModel+ContextMenu.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCollectionView

// MARK: - ItemModel + ContextMenuProviding

extension ItemModel: ContextMenuProviding { }

// MARK: - ItemModel + RAKInternalItemModeling

extension ItemModel: RAKInternalItemModeling {
    public func handleWillShowContextMenu(
        _ cell: ItemWrapperView,
        with metadata: ItemCellMetadata
    ) -> UIContextMenuConfiguration? {
        willShowContextMenu?(.init(view: viewForCell(cell), metadata: metadata))
    }
}

// MARK: - Tools

extension ItemModel {
    private func viewForCell(_ cell: ItemWrapperView) -> View {
        guard let cellView = cell.view else {
            let view = makeView()
            cell.setViewIfNeeded(view: view)
            return view
        }

        let view: View
        if let cellView = cellView as? View {
            view = cellView
        } else {
            assertionFailure("""
                Overriding existing view \(cellView) on cell \(cell), which is not of expected type \
                \(View.self). This is programmer error.
                """)
            view = makeView()
        }
        cell.setViewIfNeeded(view: view)
        return view
    }
}
