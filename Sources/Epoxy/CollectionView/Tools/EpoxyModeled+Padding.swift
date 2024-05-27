//
//  EpoxyModeled+Padding.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/22.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(visionOS)
import UIKit

import EpoxyCore
import EpoxyLayoutGroups

extension EpoxyModeled where Self: PaddingProviding {
    public func padding(_ value: SectionEdgeInsets) -> Self {
        padding(value.edgeInsets)
    }
}
#endif
