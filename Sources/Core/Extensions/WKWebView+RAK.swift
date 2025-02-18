//
//  WKWebView+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/18.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

#if canImport(WebKit)
import WebKit

extension Extendable where Base: WKWebView {
    // MARK: Cache Cleaning
    
    /// Removes web views' in-memory cache.
    ///
    /// - Parameters:
    ///   - date: Data cached after this date will be removed. Use the default value `nil` to
    ///     remove cache of all time.
    public static func removeMemoryCache(since date: Date? = nil, completion: EmptyClosure? = nil) {
        removeData(of: [WKWebsiteDataTypeMemoryCache], since: date, completion: completion)
    }
    
    /// Removes web views' disk cache.
    ///
    /// - Parameters:
    ///   - date: Data cached after this date will be removed. Use the default value `nil` to
    ///     remove cache of all time.
    public static func removeDiskCache(since date: Date? = nil, completion: EmptyClosure? = nil) {
        removeData(of: [WKWebsiteDataTypeDiskCache], since: date, completion: completion)
    }
    
    /// Removes both in-memory and disk cache of web views.
    ///
    /// - Parameters:
    ///   - date: Data cached after this date will be removed. Use the default value `nil` to
    ///     remove cache of all time.
    public static func removeMemoryAndDiskCache(since date: Date? = nil, completion: EmptyClosure? = nil) {
        removeData(
            of: [WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeDiskCache],
            since: date,
            completion: completion
        )
    }
    
    private static func removeData(of types: Set<String>, since date: Date?, completion: EmptyClosure?) {
        WKWebsiteDataStore.default().removeData(
            ofTypes: types,
            modifiedSince: date ?? Date(timeIntervalSince1970: 0),
            completionHandler: completion ?? { }
        )
    }
}
#endif
