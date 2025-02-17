//
//  Epoxy+Spacer.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView

extension Layout {
    public static let spacerDataID = "com.rakuyo.RakuyoKit.epoxy-spacer"
}

extension ItemModel {
    public static func spacer(
        dataID: String = Layout.spacerDataID,
        style: SpacerRow.Style = .default
    ) -> ItemModel<SpacerRow> {
        SpacerRow.itemModel(dataID: dataID, style: style)
    }
}

extension SectionModel {
    public static func spacer(
        dataID: String = Layout.spacerDataID,
        style: SpacerRow.Style = .default
    ) -> SectionModel {
        let item = ItemModel.spacer(dataID: dataID, style: style)
        return .init(dataID: item.dataID, items: [item]).layout(.list())
    }
}
#endif
