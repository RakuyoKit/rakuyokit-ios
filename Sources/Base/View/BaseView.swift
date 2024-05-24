//
//  BaseView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/24.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

/// A wrapper for the frame nature of `UIView`
open class BaseView: UIView {
    /// Should *only* be called once
    ///
    /// *Must* call super if override
    @objc
    open dynamic func config() {
        addSubviews()
        addInitialLayout()
    }

    /// A unified entry point for adding subviews
    @objc
    open dynamic func addSubviews() { }

    /// A unified entry point for adding initial layout
    @objc
    open dynamic func addInitialLayout() { }
}
