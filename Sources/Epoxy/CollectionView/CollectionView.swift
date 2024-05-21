//
//  CollectionView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCollectionView

// MARK: - CollectionView

/// Supplement to `EpoxyCollectionView.CollectionView`
open class CollectionView: EpoxyCollectionView.CollectionView {
    /// Proxy events related to context menu in `CollectionView`.
    public weak var contextMenuDelegate: CollectionViewContextMenuDelegate? = nil
}

// MARK: - UICollectionViewDelegate

extension CollectionView {
    public func collectionView(
        _: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point _: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let item = item(at: indexPath) else { return nil }
        return contextMenuDelegate?.collectionView(self, contextMenuConfigurationForItem: item)
    }

    public func collectionView(
        _: UICollectionView,
        willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
        animator: UIContextMenuInteractionCommitAnimating
    ) {
        contextMenuDelegate?.collectionView(self, willPerformPreviewActionForMenuWith: configuration, animator: animator)
    }
}
