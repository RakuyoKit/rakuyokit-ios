//
//  CGFloat+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

extension Extendable where Base == CGFloat {
    /// Get 0.5pt value
    public static var halfPoint: Base { Base(1).rak.scale }

    /// `float / scale`
    public var scale: Base {
        let _scale: Base = {
            #if os(watchOS)
            return 1
            #else
            return UIScreen.rak.scale
            #endif
        }()
        return base / _scale
    }

    /// Align floating point values to the pixels of the current device
    ///
    /// - Parameter rule: A rule for rounding a floating-point number
    /// - Returns: The result after alignment
    public func alignPixel(with rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Base {
        { (base * $0).rounded(rule) / $0 }(scale)
    }
}
