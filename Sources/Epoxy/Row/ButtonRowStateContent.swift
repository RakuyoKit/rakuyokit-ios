//
//  ButtonRowStateContent.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/22.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import RAKCore

protocol ButtonRowStateContent {
    init(
        image: ImageRow.ImageType?,
        title: TextRow.Content?,
        titleColor: ConvertibleToColor
    )
}
