//
//  LocalCache+Storage.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

import RAKCore

// MARK: - LocalCache.Storage

extension LocalCache {
    /// `UserDefaults` manager
    ///
    /// All `UserDefaults` in the project are operated through `LocalCache.Storage`
    public enum Storage { }
}

// MARK: - LocalCache.Storage + HigherOrderFunctionalizable

extension LocalCache.Storage: HigherOrderFunctionalizable { }
