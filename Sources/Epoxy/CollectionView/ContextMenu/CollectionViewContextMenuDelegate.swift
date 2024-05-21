//
//  CollectionViewContextMenuDelegate.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCollectionView

// MARK: - CollectionViewContextMenuDelegate

/// Proxy events related to context menu in `CollectionView`.
public protocol CollectionViewContextMenuDelegate: AnyObject {
    func collectionView(
        _ collectionView: CollectionView,
        contextMenuConfigurationForItem item: AnyItemModel
    ) -> UIContextMenuConfiguration?

    func collectionView(
        _ collectionView: CollectionView,
        willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
        animator: UIContextMenuInteractionCommitAnimating
    )
}

extension CollectionViewContextMenuDelegate {
    public func collectionView(
        _: CollectionView,
        willPerformPreviewActionForMenuWith _: UIContextMenuConfiguration,
        animator _: UIContextMenuInteractionCommitAnimating
    ) { }
}
