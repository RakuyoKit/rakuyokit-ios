//
//  UINavigationBar+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension Extendable where Base: UINavigationBar {
    /// Shadow view on navigation bar
    public var shadowImageView: UIImageView? {
        let backgroundView = base.subviews.first {
            NSStringFromClass(type(of: $0)).contains("UIBarBackground")
        }

        return backgroundView?.subviews.compactMap { $0 as? UIImageView }.first
    }

    /// Whether the navigation bar shadow is hidden
    ///
    /// https://stackoverflow.com/a/38745391
    public var isShadowHidden: Bool {
        get {
            guard let hidesShadow = base.value(forKey: "hidesShadow") as? Bool else {
                return false
            }
            return hidesShadow
        }
        set { base.setValue(newValue, forKey: "hidesShadow") }
    }

    /// Large title view on navigation bar
    public var largeTitleView: UIView? {
        base.subviews.first {
            NSStringFromClass(type(of: $0)).contains("UINavigationBarLargeTitleView")
        }
    }

    /// Set the large title view to multi-line mode
    public func setLargeTitleToMultilineMode() {
        guard let largeTitleView else { return }

        for subview in largeTitleView.subviews {
            guard let label = subview as? UILabel else {
                continue
            }

            let originalHeight = label.bounds.height

            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.sizeToFit()

            let heightIncrement = label.bounds.height - originalHeight

            if heightIncrement > 0 {
                base.frame.size.height = heightIncrement + label.bounds.height
            }

            break
        }
    }
}
#endif
