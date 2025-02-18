//
//  AnyImageContent+Accessory.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/7/8.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import RAKConfig
import RAKCore

extension AnyImageContent {
    public static func accessory() -> Self {
        .sfSymbols(
            name: "chevron.forward",
            color: Config.color.text.tertiary,
            configuration: .init(
                textStyle: .init(rawValue: "UICTFontTextStyleEmphasizedBody"),
                scale: .small
            )
        )
    }
}

#if os(iOS)
extension ImageRow.Style {
    public static func accessory() -> Self {
        .init(
            size: .init(width: 10 + .rak.halfPoint, height: 20 + .rak.halfPoint),
            contentMode: .scaleAspectFit
        )
    }
}
#endif
