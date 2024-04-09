//
//  CGFloat+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

public extension CGFloat {
    /// Get 0.5pt value
    static var halfPoint: Self { CGFloat(1).scale }
    
    /// `self / scale`
    var scale: Self {
        let _scale: Self = {
#if os(watchOS)
            return 1
#else
            return UIScreen.rak.scale
#endif
        }()
        return self / _scale
    }
}
