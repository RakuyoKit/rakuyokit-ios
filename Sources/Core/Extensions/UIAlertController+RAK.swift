//
//  UIAlertController+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import Then

extension Extendable where Base: UIAlertController {
    /// Create an alert-style popup.
    public static func alert(title: String? = nil, message: String? = nil) -> Base {
        .init(title: title, message: message, preferredStyle: .alert)
    }
    
    /// Create an action sheet-style popup.
    ///
    /// - Parameters:
    ///   - title: Title.
    ///   - message: Description.
    ///   - sourceView: The view the popup is anchored to, used for iPad adaptation.
    ///   - arrowDirections: Optional arrow directions.
    /// - Returns: Created `UIAlertController` object.
    public static func actionSheet(
        title: String? = nil,
        message: String? = nil,
        on sourceView: UIView?,
        arrowDirections: UIPopoverArrowDirection = .rak.default
    ) -> Base {
        .init(title: title, message: message, preferredStyle: .actionSheet).then {
            let idiom = UIDevice.current.userInterfaceIdiom
            
            var isPad = idiom == .pad
            if #available(iOS 14.0, *) { isPad = isPad || idiom == .mac }
            
            guard isPad else { return }
            
            $0.popoverPresentationController?.do {
                $0.permittedArrowDirections = arrowDirections
                $0.sourceView = sourceView
                $0.sourceRect = sourceView?.bounds ?? .zero
            }
        }
    }
    
    /// Add action for popup buttons.
    ///
    /// - Parameters:
    ///   - title: Title.
    ///   - style: Style, default is `.default`.
    ///   - handler: Button action, default is `nil`.
    public func addAction(
        title: String,
        style: UIAlertAction.Style = .default,
        handler: EmptyClosure? = nil
    ) {
        base.addAction(.init(title: title, style: style) { _ in handler?() })
    }
}
#endif
