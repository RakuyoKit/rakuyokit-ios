//
//  ContextMenuProviding.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCore

// MARK: - ContextMenuProviding

///
public protocol ContextMenuProviding { }

// MARK: - CallbackContextEpoxyModeled

extension CallbackContextEpoxyModeled where Self: ContextMenuProviding {
    ///
    public typealias WillShowContextMenu = (_ context: CallbackContext) -> UIContextMenuConfiguration?

    ///
    public var willShowContextMenu: WillShowContextMenu? {
        get { self[willShowContextMenuProperty] }
        set { self[willShowContextMenuProperty] = newValue }
    }

    private var willShowContextMenuProperty: EpoxyModelProperty<WillShowContextMenu?> {
        .init(keyPath: \Self.willShowContextMenu, defaultValue: nil, updateStrategy: .replace)
    }

    ///
    public func willShowContextMenu(_ value: WillShowContextMenu?) -> Self {
        copy(updating: willShowContextMenuProperty, to: value)
    }
}
#endif
