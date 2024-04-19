import Foundation

import RAKCore
import RAKEncrypte
import Then

// MARK: - NeedMigratedCache

/// Cache requiring migration
public protocol NeedMigratedCache {
    /// Migration method
    static func migrate()
}

extension NeedMigratedCache {
    public static func migrateValueFromSandboxToAppGroup(_ value: NeedEncrypted<some RAKCodable>) {
        value.wrappedValue = getOldUserDefaultsValue(name: value.name)
    }
    
    public static func getOldUserDefaultsValue<T: RAKCodable>(name: String) -> T? {
        let userDefaults: UserDefaults = .standard
        var encrypted: NeedEncrypted<T> = .init(name: name)
        
        defer { Encrypted.setValue(nil, to: userDefaults, with: &encrypted) }
        return Encrypted.getWrappedValue(from: userDefaults, with: &encrypted)
    }
}

// MARK: - LocalCache.Migrated

extension LocalCache {
    /// Management class for migrating local data
    public enum Migrated {
        /// Indicates whether UserDefaults has been migrated
        @NeedEncrypted(name: "user default migrated")
        private static var isUserDefaultMigrated: Bool?
    }
}

// MARK: - Logic

extension LocalCache.Migrated {
    public static func migrate(_ migrateds: [NeedMigratedCache.Type]) {
        if let _isMigrated = isUserDefaultMigrated, _fastPath(_isMigrated) {
            return
        }
        defer { isUserDefaultMigrated = true }
        for migrated in migrateds { migrated.migrate() }
    }
}
