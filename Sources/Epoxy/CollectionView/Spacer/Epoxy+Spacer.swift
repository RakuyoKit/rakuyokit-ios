//
//  Epoxy+Spacer.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import EpoxyCollectionView

private let _spacerDataID = "com.rakuyo.RakuyoKit.epoxy-spacer"

public extension ItemModel {
    static func spacer(style: SpacerRow.Style = .default) -> ItemModel<SpacerRow> {
        return SpacerRow.itemModel(dataID: _spacerDataID, style: style)
    }
}

public extension SectionModel {
    static func spacer(style: SpacerRow.Style = .default) -> SectionModel {
        let item = ItemModel.spacer(style: style)
        return .init(dataID: _spacerDataID, items: [item]).layout(.list())
    }
}
