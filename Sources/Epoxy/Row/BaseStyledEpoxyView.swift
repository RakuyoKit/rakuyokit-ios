//
//  BaseStyledEpoxyView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/24.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(visionOS)
import UIKit

import EpoxyCore
import RAKBase

/// For views that follow the `StyledView` protocol, you can use this base class to simplify initialization operations.
open class BaseStyledEpoxyView<Style: Hashable>: RAKBase.BaseView, StyledView {
    public let style: Style

    public required init(style: Style) {
        self.style = style

        super.init(frame: .zero)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Config

    override open func config() {
        super.config()

        translatesAutoresizingMaskIntoConstraints = false
    }
}
#endif
