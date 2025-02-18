//
//  RAKInternalItemModeling.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/22.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView

/// Supplement to `InternalItemModeling` within RakuyoKit
protocol RAKInternalItemModeling: InternalItemModeling {
    func handleWillShowContextMenu(_ cell: ItemWrapperView, with metadata: ItemCellMetadata) -> UIContextMenuConfiguration?
}
#endif
