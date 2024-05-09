//
//  Layout+Epoxy.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView
import RAKCore

extension Extendable where Base: Layout.Compositional {
    public static var epoxy: Extendable<Layout.Compositional> { Base.epoxy.rak }
}
#endif
