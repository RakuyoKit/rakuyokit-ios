//
//  WhiteBackgroundDecorationView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

import RAKConfig

/// Set a white background View for UICollectionView Section
open class WhiteBackgroundDecorationView: BaseDecorationView {
    override open func config() {
        super.config()
        
        backgroundColor = Config.color.white
    }
}
#endif
