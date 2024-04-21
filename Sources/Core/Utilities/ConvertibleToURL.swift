//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - ConvertibleToURL

/// Used to convert certain types to URL types
///
/// For urls that are not **file types**.
public protocol ConvertibleToURL {
    /// Read the converted url through this attribute
    var url: URL? { get }
}

// MARK: - URL + ConvertibleToURL

extension URL: ConvertibleToURL {
    public var url: URL? { self }
}

// MARK: - String + ConvertibleToURL

extension String: ConvertibleToURL {
    public var url: URL? { rak.toURL }
}
