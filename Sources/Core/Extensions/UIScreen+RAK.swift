//
//  UIScreen+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

#if !os(watchOS)
import UIKit

#if !os(visionOS)
public extension Extendable where Base: UIScreen {
    /// Used instead of `UIScreen.main`
    @available(iOSApplicationExtension, unavailable, message: "This method is NS_EXTENSION_UNAVAILABLE.")
    static var main: UIScreen? {
        UIApplication.shared.rak.mainScene?.screen
    }
    
    /// Used instead of `UIScreen.main.bounds`
    @available(iOSApplicationExtension, unavailable, message: "This method is NS_EXTENSION_UNAVAILABLE.")
    static var mainBounds: CGRect {
        main?.bounds ?? .zero
    }
}
#endif

public extension Extendable where Base: UIScreen {
    /// Used instead of `UIScreen.main.scale`
    static var scale: CGFloat { UITraitCollection.current.displayScale }
}
#endif
