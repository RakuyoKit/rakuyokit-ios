//
//  UIPopoverArrowDirection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension UIPopoverArrowDirection: NamespaceProviding { }

public extension Extendable where Base == UIPopoverArrowDirection {
    /// default direction
    static let `default`: Base = [.up, .down]
}
#endif

