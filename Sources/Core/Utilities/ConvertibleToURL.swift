//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

/// Used to convert certain types to URL types
///
/// For urls that are not **file types**.
public protocol ConvertibleToURL {
    /// Read the converted url through this attribute
    var url: URL? { get }
}

// MARK: - URL

extension URL: ConvertibleToURL {
    public var url: URL? { self }
}

// MARK: - URL

extension String: ConvertibleToURL {
    public var url: URL? { rak.toURL }
}
