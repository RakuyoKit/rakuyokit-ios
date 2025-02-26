//
//  RAKBaseNavigationController.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import RAKConfig

open class RAKBaseNavigationController: UINavigationController {
    #if !os(tvOS)
    private var popDelegateProxy: NavigationControllerPopDelegateProxy? = nil
    #endif

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Config.color.white
        
        #if !os(tvOS)
        if let delegate = interactivePopGestureRecognizer?.delegate {
            popDelegateProxy = NavigationControllerPopDelegateProxy(
                navigationController: self,
                popGestureRecognizerDelegate: delegate
            )
            interactivePopGestureRecognizer?.delegate = popDelegateProxy
        }
        #endif
    }
}

extension RAKBaseNavigationController {
    #if !os(tvOS)
    override open var childForStatusBarStyle: UIViewController? { topViewController }
    
    override open var childForStatusBarHidden: UIViewController? { topViewController }
    
    override open var childForHomeIndicatorAutoHidden: UIViewController? { topViewController }
    
    override open var childViewControllerForPointerLock: UIViewController? { topViewController }
    
    override open var childForScreenEdgesDeferringSystemGestures: UIViewController? { topViewController }
    #endif

    /// The pop-up style is managed by the sub-controller
    override open var modalPresentationStyle: UIModalPresentationStyle {
        get { topViewController?.modalPresentationStyle ?? super.modalPresentationStyle }
        set { topViewController?.modalPresentationStyle = newValue }
    }
    
    #if !os(tvOS)
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
    #endif
}
#endif
