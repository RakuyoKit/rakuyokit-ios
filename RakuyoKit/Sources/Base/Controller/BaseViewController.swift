//
//  BaseViewController.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import Combine

import RaLog

#if !os(watchOS)
/// Base class for view controllers.
///
/// Renamed with `@objc` to resolve symbol redefinition issues encountered in the `XXModule-swift.h` file
/// when inheriting `SwissArmyKnife.BaseViewController` to implement its own `BaseViewController`.
@objc(RAKBaseViewController)
open class BaseViewController: RotatableViewController {
    /// Default status bar style: black.
    public static let statusBarStyle: UIStatusBarStyle = .default
    
    /// Cancellable bindings.
    open lazy var cancellable = Set<AnyCancellable>()
    
    /// Indicates whether it's the first time entering this view controller.
    private lazy var isFirstEnter = true
    
    deinit { logDeinit() }
}

// MARK: - Life cycle

extension BaseViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        Self.statusBarStyle
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppear(animated, isFirstEnter: isFirstEnter)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewDidAppear(animated, isFirstEnter: isFirstEnter)
        
        if isFirstEnter {
            isFirstEnter = false
        }
        
        logAppear()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logDisappear()
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        Log.warning("\(self) encountered a memory warning!")
    }
}

// MARK: - Life cycle extension

extension BaseViewController {
    @objc
    open func viewWillAppear(_ animated: Bool, isFirstEnter: Bool) { }
    
    @objc
    open func viewDidAppear(_ animated: Bool, isFirstEnter: Bool) { }
}

// MARK: - Log

extension BaseViewController {
    @objc
    open func logDeinit() { Log.deinit(self) }
    
    @objc
    open func logAppear() { Log.appear(self) }
    
    @objc
    open func logDisappear() { Log.disappear(self) }
}
#endif
