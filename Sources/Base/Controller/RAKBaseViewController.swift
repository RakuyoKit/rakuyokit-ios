//
//  RAKBaseViewController.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import Combine

import RaLog

/// Base class for view controllers.
open class RAKBaseViewController: RAKRotatableViewController {
    #if !os(tvOS)
    /// Default status bar style: black.
    public static let statusBarStyle = UIStatusBarStyle.default
    #endif

    /// Cancellable bindings.
    open lazy var cancellable = Set<AnyCancellable>()
    
    /// Indicates whether it's the first time entering this view controller.
    private lazy var isFirstEnter = true
    
    deinit { logDeinit() }
}

// MARK: - Life cycle

extension RAKBaseViewController {
    #if !os(tvOS)
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        Self.statusBarStyle
    }
    #endif

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppear(animated, isFirstEnter: isFirstEnter)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewDidAppear(animated, isFirstEnter: isFirstEnter)
        
        if isFirstEnter {
            isFirstEnter = false
        }
        
        logAppear()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logDisappear()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        Log.warning("\(self) encountered a memory warning!")
    }
}

// MARK: - Life cycle extension

extension RAKBaseViewController {
    @objc // swiftformat:disable:next unusedArguments
    open func viewWillAppear(_ animated: Bool, isFirstEnter: Bool) { }

    @objc // swiftformat:disable:next unusedArguments
    open func viewDidAppear(_ animated: Bool, isFirstEnter: Bool) { }
}

// MARK: - Log

extension RAKBaseViewController {
    @objc
    open func logDeinit() { Log.deinit(self) }
    
    @objc
    open func logAppear() { Log.appear(self) }
    
    @objc
    open func logDisappear() { Log.disappear(self) }
}
#endif
