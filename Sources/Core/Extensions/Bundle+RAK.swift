//
//  CACornerMask+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

public extension Extendable where Base: Bundle {
    /// Where to read Bundle from
    enum From {
        /// From within the main App
        case app
        
        /// From the target itself
        case own
        
        fileprivate var bundle: Bundle {
            switch self {
            case .app: return .rak.app
            default: return .main
            }
        }
    }
    
    static func appName(from: From = .app) -> String {
        return getValue(by: "CFBundleDisplayName", from: from) ?? getValue(by: "CFBundleName", from: from) ?? ""
    }
    
    static func shortVersionString(from: From = .app) -> String {
        return getValue(by: "CFBundleShortVersionString", from: from) ?? ""
    }
    
    static func bundleVersionString(from: From = .app) -> String {
        return getValue(by: "CFBundleVersion", from: from) ?? ""
    }
    
    static func fullVersionString(from: From = .app) -> String {
        return "\(shortVersionString(from: from))（\(bundleVersionString(from: from))）"
    }
    
    static func extensionPointIdentifier(from: From = .app) -> String {
        let extensionInfo: [String: Any]? = getValue(by: "NSExtension", from: from)
        
        let identifier = extensionInfo?["NSExtensionPointIdentifier", default: ""]
        guard let identifier = identifier as? String else { return "" }
        
        return identifier
    }
}

// MARK: - Usage Description

public extension Extendable where Base: Bundle {
    /// Description of permissions
    enum UsageDescription {
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

public extension Extendable where Base: Bundle {
    /// Determine if the current execution environment is within a push extension.
    static var inPushExtension: Bool {
        extensionPointIdentifier(from: .own) == "com.apple.usernotifications.service"
    }
    
    /// Determine if the current execution environment is within a widget extension.
    static var inWidgetExtension: Bool {
        extensionPointIdentifier(from: .own) == "com.apple.widgetkit-extension"
    }
    
    /// Determine if the current execution environment is within a widget-editing extension.
    static var inWidgetIntentsExtension: Bool {
        extensionPointIdentifier(from: .own) == "com.apple.intents-service"
    }
}

// MARK: - Tools

private extension Extendable where Base: Bundle {
    /// Return the main bundle when in the app or an app extension.
    static var app: Bundle {
        var components = Bundle.main.bundleURL.path.split(separator: "/")
        var bundle: Bundle?
        
        if let index = components.lastIndex(where: { $0.hasSuffix(".app") }) {
            components.removeLast((components.count - 1) - index)
            bundle = Bundle(path: components.joined(separator: "/"))
        }
        
        return bundle ?? .main
    }
    
    static func getValue<T>(by key: String, from: From) -> T? {
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
