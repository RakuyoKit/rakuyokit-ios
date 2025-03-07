//
//  ButtonRowStateContent.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/22.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import RAKCore

/// Used to indicate what data corresponds to each UIButton state.
///
/// Used internally to simplify the creation of `ButtonRow.Content` in `.normal` state.
public protocol ButtonRowStateContent {
    associatedtype ImageContent

    init(
        image: ImageContent?,
        title: TextRow.Content?,
        titleColor: ConvertibleToColor
    )

    init(
        image: (some ButtonImageContentProviding)?,
        title: TextRow.Content?,
        titleColor: ConvertibleToColor
    )
}
#endif
