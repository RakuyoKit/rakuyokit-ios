//
//  CollectionView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView

// MARK: - CollectionView

/// Supplement to `EpoxyCollectionView.CollectionView`
open class CollectionView: EpoxyCollectionView.CollectionView {
    /// Proxy events related to context menu in `CollectionView`.
    public weak var contextMenuDelegate: CollectionViewContextMenuDelegate? = nil

    override public init(layout: UICollectionViewLayout, configuration: CollectionViewConfiguration = .shared) {
        super.init(layout: layout, configuration: configuration)

        autoDeselectItems = false
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionView {
    public func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point _: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard
            let item = item(at: indexPath),
            let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        else {
            return nil
        }

        let _config = item.handleWillShowContextMenu(
            cell,
            with: .init(traitCollection: traitCollection, state: cell.state, animated: false)
        )

        if let config = _config { return config }
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
#endif
