//
//  OptionalSize+CG.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/24.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

public typealias OptionalCGSize = OptionalSize<CGFloat>

// MARK: - Logic

extension OptionalSize where T == CGFloat {
    public static var noIntrinsicMetric: Self {
        .init(UIView.noIntrinsicMetric)
    }
}

extension OptionalSize where T == Float {
    public var cgFloatWidth: CGFloat? {
        width.flatMap { .init($0) }
    }

    public var cgFloatHeight: CGFloat? {
        height.flatMap { .init($0) }
    }
}
