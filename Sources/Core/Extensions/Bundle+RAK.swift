//
//  CACornerMask+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

extension Extendable where Base: Bundle {
    /// Where to read Bundle from
    public enum From {
        /// From within the main App
        case app
        
        /// From the target itself
        case own
        
        fileprivate var bundle: Bundle {
            switch self {
            case .app: .rak.app
            default: .main
            }
        }
    }
    
    public static func appName(from: From = .app) -> String {
        getValue(by: "CFBundleDisplayName", from: from) ?? getValue(by: "CFBundleName", from: from) ?? ""
    }
    
    public static func shortVersionString(from: From = .app) -> String {
        getValue(by: "CFBundleShortVersionString", from: from) ?? ""
    }
    
    public static func bundleVersionString(from: From = .app) -> String {
        getValue(by: "CFBundleVersion", from: from) ?? ""
    }
    
    public static func fullVersionString(from: From = .app) -> String {
        "\(shortVersionString(from: from))（\(bundleVersionString(from: from))）"
    }
    
    public static func extensionPointIdentifier(from: From = .app) -> String {
        let extensionInfo: [String: Any]? = getValue(by: "NSExtension", from: from)
        
        let identifier = extensionInfo?["NSExtensionPointIdentifier", default: ""]
        guard let identifier = identifier as? String else { return "" }
        
        return identifier
    }
}

// MARK: - Extendable.UsageDescription

extension Extendable where Base: Bundle {
    /// Description of permissions
    public enum UsageDescription {
        /// Description for accessing camera permission
        public static var camera: String {
            getValue(by: "NSCameraUsageDescription", from: .app) ?? ""
        }
        
        /// Description for accessing photo library permission
        public static var photoLibrary: String {
            getValue(by: "NSPhotoLibraryUsageDescription", from: .app) ?? ""
        }
        
        /// Description for accessing photo library add permission
        public static var photoLibraryAdd: String {
            getValue(by: "NSPhotoLibraryAddUsageDescription", from: .app) ?? ""
        }
        
        /// Description for accessing location permission
        public static var locationWhenInUse: String {
            getValue(by: "NSLocationWhenInUseUsageDescription", from: .app) ?? ""
        }
    }
}

// MARK: - Extension Judgment

extension Extendable where Base: Bundle {
    /// Determine if the current execution environment is within a push extension.
    public static var inPushExtension: Bool {
        extensionPointIdentifier(from: .own) == "com.apple.usernotifications.service"
    }
    
    /// Determine if the current execution environment is within a widget extension.
    public static var inWidgetExtension: Bool {
        extensionPointIdentifier(from: .own) == "com.apple.widgetkit-extension"
    }
    
    /// Determine if the current execution environment is within a widget-editing extension.
    public static var inWidgetIntentsExtension: Bool {
        extensionPointIdentifier(from: .own) == "com.apple.intents-service"
    }
}

// MARK: - Tools

extension Extendable where Base: Bundle {
    /// Return the main bundle when in the app or an app extension.
    fileprivate static var app: Bundle {
        var components = Bundle.main.bundleURL.path.split(separator: "/")
        var bundle: Bundle?
        
        if let index = components.lastIndex(where: { $0.hasSuffix(".app") }) {
            components.removeLast((components.count - 1) - index)
            bundle = Bundle(path: components.joined(separator: "/"))
        }
        
        return bundle ?? .main
    }
    
    fileprivate static func getValue<T>(by key: String, from: From) -> T? {
        let value = from.bundle.object(forInfoDictionaryKey: key)
        
        guard let safeValue = value else {
            return nil
        }
        
        guard let result = safeValue as? T else {
            fatalError("After getting \(key) from info.plist, conversion to \(T.self) fails: \(safeValue)")
        }
        
        return result
    }
}
