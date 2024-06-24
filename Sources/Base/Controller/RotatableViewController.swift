//
//  RotatableViewController.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

/// Base class for view controllers that provide rotation control.
open class RotatableViewController: UIViewController {
    #if !os(tvOS)
    /// Indicates whether the interface should autorotate.
    ///
    /// This should be set to `true` so that the interface can switch to portrait mode after launching in landscape.
    /// Even when this is set to `true`, the actual rotation direction will be determined by the values
    /// in `supportedInterfaceOrientations`.
    override open var shouldAutorotate: Bool { true }
    
    /// Specifies which orientations are supported for rotation.
    ///
    /// By default, iPhone only supports portrait orientation.
    /// Please override this method in view controllers where rotation is needed.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let `default`: UIInterfaceOrientationMask = UIDevice.current.userInterfaceIdiom == .pad ? .all : .portrait
        return presentedViewController?.supportedInterfaceOrientations ?? `default`
    }
    
    #if !os(visionOS)
    /// Specifies the preferred orientation for presenting the view controller.
    ///
    /// By default, iPhone presents view controllers vertically.
    /// Please override this method in view controllers where rotation is needed.
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        Self.normalPreferredInterfaceOrientation
    }
    #endif
    #endif
}

#if !os(visionOS) && !os(tvOS)
extension RotatableViewController {
    public static var normalPreferredInterfaceOrientation: UIInterfaceOrientation {
        guard case .pad = UIDevice.current.userInterfaceIdiom else { return .portrait }
        
        switch UIDevice.current.orientation {
        case .portrait, .faceUp, .faceDown:
            return .portrait
        case .unknown:
            return .unknown
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        @unknown default:
            return .portrait
        }
    }
}
#endif
#endif
