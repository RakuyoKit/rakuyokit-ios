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
