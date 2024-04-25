//
//  NavigationController.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import RAKConfig

#if !os(watchOS)
@objc(RAKNavigationController)
public class NavigationController: UINavigationController {
    private var popDelegateProxy: NavigationControllerPopDelegateProxy?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Config.color.white
        
        if let delegate = interactivePopGestureRecognizer?.delegate {
            popDelegateProxy = NavigationControllerPopDelegateProxy(
                navigationController: self,
                popGestureRecognizerDelegate: delegate
            )
            interactivePopGestureRecognizer?.delegate = popDelegateProxy
        }
    }
}

extension NavigationController {
    override open var childForStatusBarStyle: UIViewController? { topViewController }
    
    override open var childForStatusBarHidden: UIViewController? { topViewController }
    
    override open var childForHomeIndicatorAutoHidden: UIViewController? { topViewController }
    
    override open var childViewControllerForPointerLock: UIViewController? { topViewController }
    
    override open var childForScreenEdgesDeferringSystemGestures: UIViewController? { topViewController }
    
    /// The pop-up style is managed by the sub-controller
    override open var modalPresentationStyle: UIModalPresentationStyle {
        get { topViewController?.modalPresentationStyle ?? super.modalPresentationStyle }
        set { topViewController?.modalPresentationStyle = newValue }
    }
    
    // Override the related methods of screen rotation so that
    // the screen rotation is controlled by `topViewController`
    
    override open var shouldAutorotate: Bool {
        topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        topViewController?.preferredInterfaceOrientationForPresentation ??
            super.preferredInterfaceOrientationForPresentation
    }
}

private class NavigationControllerPopDelegateProxy: NSObject, UIGestureRecognizerDelegate {
    weak var navigationController: UINavigationController?
    weak var popGestureRecognizerDelegate: UIGestureRecognizerDelegate?
    
    init(navigationController: UINavigationController, popGestureRecognizerDelegate: UIGestureRecognizerDelegate) {
        self.navigationController = navigationController
        self.popGestureRecognizerDelegate = popGestureRecognizerDelegate
        
        super.init()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
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
    override func responds(to aSelector: Selector!) -> Bool {
        if let delegate = popGestureRecognizerDelegate {
            return delegate.responds(to: aSelector)
        }
        return super.responds(to: aSelector)
    }
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    override func forwardingTarget(for _: Selector!) -> Any? {
        popGestureRecognizerDelegate
    }
}
#endif
