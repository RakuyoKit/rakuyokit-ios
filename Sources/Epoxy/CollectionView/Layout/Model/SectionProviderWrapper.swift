//
//  SectionProviderWrapper.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import EpoxyCollectionView

/// Used to simplify layout settings
public struct SectionProviderWrapper {
    public let provider: CompositionalLayoutSectionProvider
    
    public init(layoutSectionProvider: @escaping CompositionalLayoutSectionProvider) {
        provider = layoutSectionProvider
    }
}
#endif
