//
//  UICollectionView+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension Extendable where Base: UICollectionView {
    private var orthogonalScrollViewType: String {
        "_UICollectionViewOrthogonalScrollerEmbeddedScrollView"
    }

    /// When `UICollectionViewCompositionalLayout` + `orthogonalScrollingBehavior` are used together,
    /// the first `_UICollectionViewOrthogonalScrollerEmbeddedScrollView` view inside UICollectionView
    public var orthogonalScrollView: UIScrollView? {
        base.subviews.first { "\(type(of: $0))" == orthogonalScrollViewType } as? UIScrollView
    }

    /// When `UICollectionViewCompositionalLayout` + `orthogonalScrollingBehavior` are used together,
    /// the `_UICollectionViewOrthogonalScrollerEmbeddedScrollView` view collection inside UICollectionView
    public var orthogonalScrollViews: [UIScrollView] {
        base.subviews.compactMap {
            guard orthogonalScrollViewType == "\(type(of: $0))" else { return nil }
            return $0 as? UIScrollView
        }
    }
}

extension Extendable where Base: UICollectionView {
    public func deselectRowIfNeeded(
        with transitionCoordinator: UIViewControllerTransitionCoordinator?,
        animated: Bool
    ) {
        guard let selectedIndexPaths = base.indexPathsForSelectedItems else { return }

        guard let coordinator = transitionCoordinator else {
            deselectItems(at: selectedIndexPaths, animated: animated)
            return
        }

        coordinator.animate(
            alongsideTransition: { _ in
                deselectItems(at: selectedIndexPaths, animated: true)
            },
            completion: { context in
                guard context.isCancelled else { return }

                for selectedIndexPath in selectedIndexPaths {
                    base.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
                }
            }
        )
    }

    private func deselectItems(at selectedIndexPaths: [IndexPath], animated: Bool) {
        for selectedIndexPath in selectedIndexPaths {
            base.deselectItem(at: selectedIndexPath, animated: true)
            base.delegate?.collectionView?(base, didDeselectItemAt: selectedIndexPath)
        }
    }
}
#endif
