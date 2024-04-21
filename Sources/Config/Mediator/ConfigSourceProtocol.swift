//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - ConfigSourceProtocol

/// Data source protocol.
///
/// Config types of different App clients need to follow this protocol and implement the following methods.
public protocol ConfigSourceProtocol {
    /// Color configuration.
    var color: ColorConfig { get }
    
    /// App’s Apple ID on App Store Connect.
    var appStoreConnectAppleID: String { get }
    
    /// App's AppGroups identifier
    var appGroupIdentifier: String { get }
}

// MARK: - Default value

extension ConfigSourceProtocol {
    public var color: ColorConfig { .placeholder }
    
    public var appStoreConnectAppleID: String { "" }
    
    public var appGroupIdentifier: String { "" }
}

// MARK: - Public Tools

extension ConfigSourceProtocol {
    /// App download link.
    ///
    /// - Parameter area: Default is `cn` (China)
    /// - Returns: download link.
    public func appDownloadURL(with area: String = "cn") -> URL? {
        let baseURLString = "https://itunes.apple.com/\(area)/app/id"
        let urlString = baseURLString + appStoreConnectAppleID
        
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
