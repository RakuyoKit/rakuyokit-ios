//
//  BinaryInteger+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/6/13.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

extension BinaryInteger {
    public var isZero: Bool { self == 0 }
}

extension Extendable where Base: BinaryInteger {
    /// `float / scale`
    public var scale: CGFloat { .init(base) / _scale }

    /// Align floating point values to the pixels of the current device
    ///
    /// - Parameter rule: A rule for rounding a floating-point number
    /// - Returns: The result after alignment
    public func alignPixel(with rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGFloat {
        { (.init(base) * $0).rounded(rule) / $0 }(scale)
    }
}
