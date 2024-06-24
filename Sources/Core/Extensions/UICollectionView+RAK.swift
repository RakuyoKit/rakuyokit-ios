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
#endif
