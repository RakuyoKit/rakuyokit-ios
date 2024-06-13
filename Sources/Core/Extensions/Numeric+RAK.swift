//
//  Numeric+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

extension Extendable where Base: Numeric {
    /// `float / scale`
    ///
    /// For use within the framework only
    var _scale: CGFloat {
        #if os(watchOS)
        return 1
        #else
        return UIScreen.rak.scale
        #endif
    }
}
