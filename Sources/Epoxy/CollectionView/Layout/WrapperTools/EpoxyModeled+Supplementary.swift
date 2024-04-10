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

public extension EpoxyModeled where Self: SupplementaryItemsProviding {
    func header(_ value: () -> SupplementaryItemModeling) -> Self {
        return supplementaryItems(ofKind: UICollectionView.elementKindSectionHeader, [value()])
    }
    
    func footer(_ value: () -> SupplementaryItemModeling) -> Self {
        return supplementaryItems(ofKind: UICollectionView.elementKindSectionFooter, [value()])
    }
}
