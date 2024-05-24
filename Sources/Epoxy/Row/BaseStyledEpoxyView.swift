//
//  BaseStyledEpoxyView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/24.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import EpoxyCore
import RAKBase

/// For views that follow the `StyledView` protocol, you can use this base class to simplify initialization operations.
open class BaseStyledEpoxyView<Style: Hashable>: RAKBase.BaseView, StyledView {
    public required init(style: Style) {
        super.init(frame: .zero)

        config(style: style)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Should *only* be called once
    ///
    /// *Must* call super if override
    open func config(style: Style) { // swiftformat:disable unusedArguments
        super.config()
    }

    @available(*, unavailable)
    override open func config() {
        fatalError("Use `config(style:)` instead of this method")
    }
}
