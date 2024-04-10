//
//  SectionProviderWrapper.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import EpoxyCollectionView

/// Used to simplify layout settings
public struct SectionProviderWrapper {
    public let provider: CompositionalLayoutSectionProvider
    
    public init(layoutSectionProvider: @escaping CompositionalLayoutSectionProvider) {
        self.provider = layoutSectionProvider
    }
}
