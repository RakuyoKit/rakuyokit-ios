//
//  UIScreen+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension Extendable where Base: UIScrollView {
    /// Check if the current `UIScrollView` is scrolled to the top.
    var isScrolledTop: Bool {
        ceil(base.contentOffset.y) == -ceil(base.adjustedContentInset.top)
    }
    
    /// Check if it is at the bottom.
    var isAtBottom: Bool {
        abs(base.contentSize.height - base.frame.height - base.contentOffset.y) < 1
    }
    
    /// Scroll to the top.
    ///
    /// - Parameter animated: Whether to animate the scrolling.
    func scrollToTop(animated: Bool) {
        guard !isScrolledTop else { return }
        
        base.setContentOffset(
            .init(x: base.contentOffset.x, y: -base.adjustedContentInset.top),
            animated: animated
        )
    }
    
    /// Reset the `contentOffset` of the `UIScrollView`.
    ///
    /// - Parameter animated: Whether to update with animation.
    func resetContentOffset(animated: Bool) {
        let inset = base.adjustedContentInset
        base.setContentOffset(.init(x: -inset.left, y: -inset.top), animated: animated)
    }
}
#endif
