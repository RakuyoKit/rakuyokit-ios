//
//  Layout+Style.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/6/9.
//  Copyright © 2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import RAKCore

extension Layout {
    /// Styles
    public enum Style {
        /// Similar to the flow layout of the past CollectionView
        case flow(
            itemSize: Size,
            scrollingBehavior: ScrollingBehavior = .none,
            itemContentInsets: Layout.EdgeInsets = .zero,
            interItemSpacing: Layout.ItemSpacing? = nil,
            customGroup: CustomGroupFactory? = nil
        )
        
        /// Similar to the vertical list layout of UITableView
        case list
    }
}
#endif
