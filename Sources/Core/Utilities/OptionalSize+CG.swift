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

extension OptionalCGSize {
    #if !os(watchOS)
    public static var noIntrinsicMetric: Self {
        .init(size: UIView.noIntrinsicMetric)
    }
    #endif

    public init(_ cgSize: CGSize) {
        self.init(width: cgSize.width, height: cgSize.height)
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
