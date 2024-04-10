//
//  UINavigationController+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension Extendable where Base: UINavigationController {
    /// Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
    func pushViewController(_ viewController: UIViewController, animated: Bool, complete: @escaping EmptyClosure) {
        CATransaction.setCompletionBlock(complete)
        CATransaction.begin()
        base.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    /// Returns the popped controller
    @discardableResult
    func popViewController(animated: Bool, complete: @escaping EmptyClosure) -> UIViewController? {
        let poppedViewController: UIViewController?
        
        CATransaction.setCompletionBlock(complete)
        CATransaction.begin()
        poppedViewController = base.popViewController(animated: animated)
        CATransaction.commit()
        
        return poppedViewController
    }
    
    /// Pops view controllers until the one specified is on top. Returns the popped controllers.
    @discardableResult
    func popToViewController(
        _ viewController: UIViewController,
        animated: Bool,
        complete: @escaping EmptyClosure
    ) -> [UIViewController]? {
        let viewControllers: [UIViewController]?
        
        CATransaction.setCompletionBlock(complete)
        CATransaction.begin()
        viewControllers = base.popToViewController(viewController, animated: animated)
        CATransaction.commit()
        
        return viewControllers
    }
    
    /// Pops until there's only a single view controller left on the stack. Returns the popped controllers.
    @discardableResult
    func popToRootViewController(animated: Bool, complete: @escaping EmptyClosure) -> [UIViewController]? {
        let viewControllers: [UIViewController]?
        
        CATransaction.setCompletionBlock(complete)
        CATransaction.begin()
        viewControllers = base.popToRootViewController(animated: animated)
        CATransaction.commit()
        
        return viewControllers
    }
}
#endif
