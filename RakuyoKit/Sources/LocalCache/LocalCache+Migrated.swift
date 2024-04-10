import Foundation

import RAKCore
import RAKEncrypte
import Then

/// Cache requiring migration
public protocol NeedMigratedCache {
    /// Migration method
    static func migrate()
}

public extension NeedMigratedCache {
    static func migrateValueFromSandboxToAppGroup(_ value: NeedEncrypted<some RAKCodable>) {
        value.wrappedValue = getOldUserDefaultsValue(name: value.name)
    }
    
    static func getOldUserDefaultsValue<T: RAKCodable>(name: String) -> T? {
        let userDefaults: UserDefaults = .standard
        var encrypted: NeedEncrypted<T> = .init(name: name)
        
        defer { Encrypted.setValue(nil, to: userDefaults, with: &encrypted) }
        return Encrypted.getWrappedValue(from: userDefaults, with: &encrypted)
    }
}

public extension LocalCache {
    /// Management class for migrating local data
    enum Migrated {
        /// Indicates whether UserDefaults has been migrated
        @NeedEncrypted(name: "user default migrated")
        private static var isUserDefaultMigrated: Bool?
    }
}

// MARK: - Logic

public extension LocalCache.Migrated {
    static func migrate(_ migrateds: [NeedMigratedCache.Type]) {
        if let _isMigrated = isUserDefaultMigrated, _fastPath(_isMigrated) {
            return
        }
        defer { isUserDefaultMigrated = true }
        migrateds.forEach { $0.migrate() }
    }
}
