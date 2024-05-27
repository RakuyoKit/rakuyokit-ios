//
//  ButtonRowStateContent.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/22.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import RAKCore

/// Used to indicate what data corresponds to each UIButton state.
///
/// Used internally to simplify the creation of `ButtonRow.Content` in `.normal` state.
protocol ButtonRowStateContent {
    associatedtype ImageContent

    init(
        image: ImageContent?,
        title: TextRow.Content?,
        titleColor: ConvertibleToColor
    )
}
#endif
