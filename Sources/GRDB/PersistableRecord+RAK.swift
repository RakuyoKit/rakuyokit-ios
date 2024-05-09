//
//  PersistableRecord+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/7.
//  Copyright © 2024 LenticularStickers. All rights reserved.
//

import Foundation

import GRDB
import RAKCore

// MARK: - Insert

extension Extendable where Base: CodableRecord {
    public func save(onConflict conflictResolution: Database.ConflictResolution? = nil) throws {
        try Base.database?.write { try base.save($0, onConflict: conflictResolution) }
    }

    public func insert(onConflict conflictResolution: Database.ConflictResolution? = nil) throws {
        try Base.database?.write { try base.insert($0, onConflict: conflictResolution) }
    }
}

// MARK: - Update

extension Extendable where Base: CodableRecord {
    public func update(onConflict conflictResolution: Database.ConflictResolution? = nil) throws {
        try Base.database?.write { try base.update($0, onConflict: conflictResolution) }
    }

    public func update(
        onConflict conflictResolution: Database.ConflictResolution? = nil,
        columns: some Sequence<String>
    ) throws {
        try Base.database?.write { try base.update($0, onConflict: conflictResolution, columns: columns) }
    }
}

// MARK: - Fetch

extension Extendable where Base: CodableRecord {
    public static func fetchAll() throws -> [Base] {
        (try Base.database?.read { try Base.fetchAll($0) }) ?? []
    }

    public static func fetchAll(_ request: some FetchRequest) throws -> [Base] {
        (try Base.database?.read { try Base.fetchAll($0, request) }) ?? []
    }

    public static func fetchOne() throws -> Base? {
        try Base.database?.read { try Base.fetchOne($0) }
    }

    public static func fetchOne(_ request: some FetchRequest) throws -> Base? {
        try Base.database?.read { try Base.fetchOne($0, request) }
    }
}
