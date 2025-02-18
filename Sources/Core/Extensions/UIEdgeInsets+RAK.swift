//
//  UIEdgeInsets+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

extension UIEdgeInsets: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(top)
        hasher.combine(left)
        hasher.combine(bottom)
        hasher.combine(right)
    }
}
