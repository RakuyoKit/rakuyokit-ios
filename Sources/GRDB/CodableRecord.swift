//
//  CodableRecord.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/7.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

import GRDB
import RAKCore

public protocol CodableRecord: FetchableRecord & NamespaceProviding & PersistableRecord {
    static var database: DatabaseQueue? { get }
}
