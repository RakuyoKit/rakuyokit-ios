//
//  Layout+SectionModel.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import EpoxyCollectionView

extension SectionModel {
    public func layout(_ wrapper: SectionProviderWrapper) -> Self {
        compositionalLayoutSectionProvider(wrapper.provider)
    }
}
