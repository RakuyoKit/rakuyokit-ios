//
//  OptionalSize+CG.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/24.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

public typealias OptionalCGSize = OptionalSize<CGFloat>

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

extension OptionalCGSize {
    public var cgSize: CGSize {
        .init(width: width ?? 0, height: height ?? 0)
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

extension OptionalSize where T == Double {
    public init(_ size: CGSize) {
        self.init(width: .init(size.width), height: .init(size.height))
    }
}

extension OptionalSize where T == Float {
    public init(_ size: CGSize) {
        self.init(width: .init(size.width), height: .init(size.height))
    }
}
