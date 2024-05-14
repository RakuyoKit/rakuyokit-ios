//
//  NavigationControllerPopDelegateProxy.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

public class NavigationControllerPopDelegateProxy: NSObject, UIGestureRecognizerDelegate {
    public weak var navigationController: UINavigationController?
    public weak var popGestureRecognizerDelegate: UIGestureRecognizerDelegate?

    public init(navigationController: UINavigationController, popGestureRecognizerDelegate: UIGestureRecognizerDelegate) {
        self.navigationController = navigationController
        self.popGestureRecognizerDelegate = popGestureRecognizerDelegate

        super.init()
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard
            let navController = navigationController,
            let delegate = popGestureRecognizerDelegate
        else {
            return false
        }

        if navController.viewControllers.count > 1 {
            return true
        }
        return delegate.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) ?? false
    }

    // swiftlint:disable:next implicitly_unwrapped_optional
    override public func responds(to aSelector: Selector!) -> Bool {
        if let delegate = popGestureRecognizerDelegate {
            return delegate.responds(to: aSelector)
        }
        return super.responds(to: aSelector)
    }

    // swiftlint:disable:next implicitly_unwrapped_optional
    override public func forwardingTarget(for _: Selector!) -> Any? {
        popGestureRecognizerDelegate
    }
}
#endif
