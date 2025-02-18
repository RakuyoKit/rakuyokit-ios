//
//  UIPageViewController+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/18.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

#if !os(watchOS)
extension Extendable where Base: UIPageViewController {
    public var viewController: UIViewController? {
        base.viewControllers?.first
    }
    
    public var scrollView: UIScrollView? {
        base.view.subviews.compactMap { $0 as? UIScrollView }.first
    }
}
#endif
