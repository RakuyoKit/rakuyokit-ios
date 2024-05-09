//
//  Epoxy+Spacer.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

import EpoxyCollectionView

private let _spacerDataID = "com.rakuyo.RakuyoKit.epoxy-spacer"

extension ItemModel {
    public static func spacer(style: SpacerRow.Style = .default) -> ItemModel<SpacerRow> {
        SpacerRow.itemModel(dataID: _spacerDataID, style: style)
    }
}

extension SectionModel {
    public static func spacer(style: SpacerRow.Style = .default) -> SectionModel {
        let item = ItemModel.spacer(style: style)
        return .init(dataID: _spacerDataID, items: [item]).layout(.list())
    }
}
#endif
