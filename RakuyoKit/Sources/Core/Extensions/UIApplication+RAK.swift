//
//  UIApplication+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension Extendable where Base: UIApplication {
    var keyWindow: UIWindow? {
        mainScene?.windows.first { $0.isKeyWindow }
    }
    
    var rootViewController: UIViewController? { keyWindow?.rootViewController }
    
    /// Get the height of the status bar
    func statusBarHeight(in view: UIView? = nil) -> CGFloat {
        let height = view?.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        guard _slowPath(height.isZero) else { return height }
        
        // During the first period of time when the app is started, the above method may return `0`,
        // so a cover-up strategy is needed.
        return base.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .compactMap(\.statusBarManager)
            .map(\.statusBarFrame)
            .map(\.height)
            .max() ?? 0
    }
}

// MARK: - Open URL

@available(iOSApplicationExtension, unavailable)
public extension Extendable where Base: UIApplication {
    /// Returns the openable form of `urlString`
    ///
    /// - Parameter urlString: The link to open
    /// - Returns: Whether the link can be opened. If possible, the corresponding URL object is returned. Otherwise return `nil`
    func openableLink(of urlString: String) -> URL? {
        guard
            let url = URL(string: urlString),
            base.canOpenURL(url)
        else {
            return nil
        }
        
        return url
    }
    
    /// Open a url
    ///
    /// - Parameter urlString: The link to open
    /// - Returns: Can it be opened successfully
    @discardableResult
    func open(_ urlString: String) -> Bool {
        guard let url = openableLink(of: urlString) else { return false }
        base.open(url)
        return true
    }
    
    /// Open settings page
    @discardableResult
    func openSettings() -> Bool {
        return open(Base.openSettingsURLString)
    }
}

// MARK: - Tools

extension Extendable where Base: UIApplication {
    /// Used instead of `UIScreen.main`
    var mainScene: UIWindowScene? {
        base.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
    }
}
#endif
