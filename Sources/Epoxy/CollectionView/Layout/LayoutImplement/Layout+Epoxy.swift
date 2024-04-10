//
//  Layout+Epoxy.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import EpoxyCollectionView
import RAKCore

public extension Extendable where Base: Layout.Compositional {
    static var epoxy: Extendable<Layout.Compositional> { Base.epoxy.rak }
}
