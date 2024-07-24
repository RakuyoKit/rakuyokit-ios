//
//  Database+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/7/24.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

/// The following code is copied from the [GRDB](https://github.com/groue/GRDB.swift) repository.
///
/// The purpose of this document is to make available the encryption functionality provided by GRDB
/// by relying on the [SQLCipher binary package](https://github.com/Tencent/sqlcipher).
///
/// To avoid conflicts, I've added the following to the `rak` namespace.
/// Other than that, I've tried to keep the following code as consistent as possible with the GRDB codebase.

import Foundation

import GRDB
import RAKCore
import sqlcipher

// swiftformat:disable all
// swiftlint:disable all

extension Database: NamespaceProviding { }

// MARK: - Validate

extension Extendable where Base: Database {
    public func validateSQLCipher() throws {
        // https://discuss.zetetic.net/t/important-advisory-sqlcipher-with-xcode-8-and-new-sdks/1688
        //
        // > In order to avoid situations where SQLite might be used
        // > improperly at runtime, we strongly recommend that
        // > applications institute a runtime test to ensure that the
        // > application is actually using SQLCipher on the active
        // > connection.
        if try String.fetchOne(base, sql: "PRAGMA cipher_version") == nil {
            throw DatabaseError(resultCode: .SQLITE_MISUSE, message: """
                GRDB is not linked against SQLCipher. \
                Check https://discuss.zetetic.net/t/important-advisory-sqlcipher-with-xcode-8-and-new-sdks/1688
                """)
        }
    }
}

// MARK: - Erase

extension Extendable where Base: Database {
    public func erase() throws {
        // SQLCipher does not support the backup API:
        // https://discuss.zetetic.net/t/using-the-sqlite-online-backup-api/2631
        // So we'll drop all database objects one after the other.

        // Prevent foreign keys from messing with drop table statements
        let foreignKeysEnabled = try Bool.fetchOne(base, sql: "PRAGMA foreign_keys")!
        if foreignKeysEnabled {
            try base.execute(sql: "PRAGMA foreign_keys = OFF")
        }

        try throwingFirstError(
            execute: {
                // Remove all database objects, one after the other
                try base.inTransaction {
                    let sql = "SELECT type, name FROM sqlite_master WHERE name NOT LIKE 'sqlite_%'"
                    while let row = try Row.fetchOne(base, sql: sql) {
                        let type: String = row["type"]
                        let name: String = row["name"]
                        try base.execute(sql: "DROP \(type) \(name.quotedDatabaseIdentifier)")
                    }
                    return .commit
                }
            },
            finally: {
                // Restore foreign keys if needed
                if foreignKeysEnabled {
                    try base.execute(sql: "PRAGMA foreign_keys = ON")
                }
            }
        )
    }
}

// MARK: - Encryption

extension Extendable where Base: Database {
    /// Sets the passphrase used to crypt and decrypt an SQLCipher database.
    ///
    /// Call this method from `Configuration.prepareDatabase`,
    /// as in the example below:
    ///
    ///     var config = Configuration()
    ///     config.prepareDatabase { db in
    ///         try db.usePassphrase("secret")
    ///     }
    public func usePassphrase(_ passphrase: String) throws {
        guard var data = passphrase.data(using: .utf8) else {
            throw DatabaseError(message: "invalid passphrase")
        }
        defer {
            data.resetBytes(in: 0 ..< data.count)
        }
        try usePassphrase(data)
    }

    /// Sets the passphrase used to crypt and decrypt an SQLCipher database.
    ///
    /// Call this method from `Configuration.prepareDatabase`,
    /// as in the example below:
    ///
    ///     var config = Configuration()
    ///     config.prepareDatabase { db in
    ///         try db.usePassphrase(passphraseData)
    ///     }
    public func usePassphrase(_ passphrase: Data) throws {
        let code = passphrase.withUnsafeBytes {
            sqlite3_key(base.sqliteConnection, $0.baseAddress, CInt($0.count))
        }
        guard code == SQLITE_OK else {
            throw DatabaseError(resultCode: .SQLITE_OK, message: String(cString: sqlite3_errmsg(base.sqliteConnection)))
        }
    }

    /// Changes the passphrase used by an SQLCipher encrypted database.
    public func changePassphrase(_ passphrase: String) throws {
        guard var data = passphrase.data(using: .utf8) else {
            throw DatabaseError(message: "invalid passphrase")
        }
        defer {
            data.resetBytes(in: 0 ..< data.count)
        }
        try changePassphrase(data)
    }

    /// Changes the passphrase used by an SQLCipher encrypted database.
    public func changePassphrase(_ passphrase: Data) throws {
        // FIXME: sqlite3_rekey is discouraged.
        //
        // https://github.com/ccgus/fmdb/issues/547#issuecomment-259219320
        //
        // > We (Zetetic) have been discouraging the use of sqlite3_rekey in
        // > favor of attaching a new database with the desired encryption
        // > options and using sqlcipher_export() to migrate the contents and
        // > schema of the original db into the new one:
        // > https://discuss.zetetic.net/t/how-to-encrypt-a-plaintext-sqlite-database-to-use-sqlcipher-and-avoid-file-is-encrypted-or-is-not-a-database-errors/
        let code = passphrase.withUnsafeBytes {
            sqlite3_rekey(base.sqliteConnection, $0.baseAddress, CInt($0.count))
        }
        guard code == SQLITE_OK else {
            throw DatabaseError(resultCode: .SQLITE_OK, message: base.lastErrorMessage)
        }
    }
}

// MARK: - Tools

private func throwingFirstError<T>(execute: () throws -> T, finally: () throws -> Void) throws -> T {
    var result: T?
    var firstError: Error?
    do {
        result = try execute()
    } catch {
        firstError = error
    }
    do {
        try finally()
    } catch {
        if firstError == nil {
            firstError = error
        }
    }
    if let firstError {
        throw firstError
    }
    return result!
}

// swiftlint:enable all
// swiftformat:enable all
