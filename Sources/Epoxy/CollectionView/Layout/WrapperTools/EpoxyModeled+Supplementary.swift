//
//  EpoxyModeled+Supplementary.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import EpoxyCollectionView
import EpoxyCore

extension EpoxyModeled where Self: SupplementaryItemsProviding {
    public func header(_ value: () -> SupplementaryItemModeling) -> Self {
        supplementaryItems(ofKind: UICollectionView.elementKindSectionHeader, [value()])
    }
    
    public func footer(_ value: () -> SupplementaryItemModeling) -> Self {
        supplementaryItems(ofKind: UICollectionView.elementKindSectionFooter, [value()])
    }
}
