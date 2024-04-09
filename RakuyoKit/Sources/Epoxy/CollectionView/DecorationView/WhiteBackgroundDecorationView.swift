//
//  WhiteBackgroundDecorationView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import RAKConfig

/// Set a white background View for UICollectionView Section
open class WhiteBackgroundDecorationView: BaseDecorationView {
    open override func config() {
        super.config()
        
        backgroundColor = Config.color.white
    }
}
