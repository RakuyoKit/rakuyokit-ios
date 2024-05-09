//
//  QueryInterfaceRequest+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/9.
//  Copyright © 2024 LenticularStickers. All rights reserved.
//

import Foundation

import GRDB
import RAKCore

// MARK: - QueryInterfaceRequest + GenericNamespaceProviding

extension QueryInterfaceRequest: GenericNamespaceProviding {
    public typealias GenericType = RowDecoder
}

// MARK: - Fetch

extension GenericExtendable where Base == QueryInterfaceRequest<Generic>, Generic: CodableRecord {
    public func fetchAll() throws -> [Generic] {
        (try Generic.database?.read { try base.fetchAll($0) }) ?? []
    }

    public func fetchOne() throws -> Generic? {
        try Generic.database?.read { try base.fetchOne($0) }
    }
}
