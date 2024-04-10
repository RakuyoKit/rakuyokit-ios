//
//  HigherOrderFunctionalizable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

import Then

public protocol HigherOrderFunctionalizable: Then { }

public extension HigherOrderFunctionalizable {
    static func `do`(_ block: (Self.Type) throws -> Void) rethrows {
        try block(Self.self)
    }
    
    static func map<T>(_ transform: (Self.Type) throws -> T) rethrows -> T {
        return try transform(Self.self)
    }
    
    func map<T>(_ transform: (Self) throws -> T) rethrows -> T {
        return try transform(self)
    }
}
