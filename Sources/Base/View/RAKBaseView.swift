//
//  RAKBaseView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/24.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

/// A wrapper for the frame nature of `UIView`
open class RAKBaseView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)

        config()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        config()
    }

    /// Should *only* be called once
    ///
    /// *Must* call super if override
    @objc
    open dynamic func config() {
        translatesAutoresizingMaskIntoConstraints = false
        
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
#endif
