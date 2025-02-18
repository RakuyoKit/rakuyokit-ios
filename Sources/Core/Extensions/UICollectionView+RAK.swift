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
    /// Possible types of `orthogonalScrollView`
    ///
    /// It is currently uncertain which system version uses which type,
    /// so an array is used for checking.
    private var orthogonalScrollViewTypes: [String] {
        [
            "_UICollectionViewOrthogonalScrollView",
            "_UICollectionViewOrthogonalScrollerEmbeddedScrollView",
        ]
    }
    
    private func isOrthogonalScrollView(with view: UIView) -> Bool {
        orthogonalScrollViewTypes.contains("\(type(of: view))")
    }
}

extension Extendable where Base: UICollectionView {
    /// When `UICollectionViewCompositionalLayout` + `orthogonalScrollingBehavior` are used together,
    /// the first `_UICollectionViewOrthogonalScrollerEmbeddedScrollView` view inside UICollectionView
    public var orthogonalScrollView: UIScrollView? {
        base.subviews.first { isOrthogonalScrollView(with: $0) } as? UIScrollView
    }

    /// When `UICollectionViewCompositionalLayout` + `orthogonalScrollingBehavior` are used together,
    /// the `_UICollectionViewOrthogonalScrollerEmbeddedScrollView` view collection inside UICollectionView
    public var orthogonalScrollViews: [UIScrollView] {
        base.subviews.compactMap {
            guard isOrthogonalScrollView(with: $0) else { return nil }
            return $0 as? UIScrollView
        }
    }
}

extension Extendable where Base: UICollectionView {
    public func deselectRowIfNeeded(
        with transitionCoordinator: UIViewControllerTransitionCoordinator? = nil,
        animated: Bool = true,
        after deadline: DispatchTime? = nil
    ) {
        if let deadline {
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                deselectRowIfNeeded(with: transitionCoordinator, animated: animated)
            }
        } else {
            deselectRowIfNeeded(with: transitionCoordinator, animated: animated)
        }
    }

    private func deselectRowIfNeeded(
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
            completion: { [weak base] context in
                guard context.isCancelled else { return }

                for selectedIndexPath in selectedIndexPaths {
                    base?.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
                }
            }
        )
    }

    private func deselectItems(at selectedIndexPaths: [IndexPath], animated: Bool) {
        for selectedIndexPath in selectedIndexPaths {
            base.deselectItem(at: selectedIndexPath, animated: animated)
            base.delegate?.collectionView?(base, didDeselectItemAt: selectedIndexPath)
        }
    }
}
#endif
