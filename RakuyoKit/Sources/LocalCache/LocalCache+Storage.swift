import Foundation

import RAKCore

public extension LocalCache {
    /// `UserDefaults` manager
    ///
    /// All `UserDefaults` in the project are operated through `LocalCache.Storage`
    enum Storage { }
}

// MARK: - HigherOrderFunctionalizable

extension LocalCache.Storage: HigherOrderFunctionalizable { }
