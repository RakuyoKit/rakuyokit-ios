//
//  CGFloat+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

extension CGFloat {
    /// Get 0.5pt value
    public static var halfPoint: Self { CGFloat(1).scale }
    
    /// `self / scale`
    public var scale: Self {
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
