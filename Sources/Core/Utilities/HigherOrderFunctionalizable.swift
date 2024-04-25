//
//  HigherOrderFunctionalizable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

import Then

// MARK: - HigherOrderFunctionalizable

public protocol HigherOrderFunctionalizable: Then { }

extension HigherOrderFunctionalizable {
    public static func `do`(_ block: (Self.Type) throws -> Void) rethrows {
        try block(Self.self)
    }
    
    public static func map<T>(_ transform: (Self.Type) throws -> T) rethrows -> T {
        try transform(Self.self)
    }
    
    public func map<T>(_ transform: (Self) throws -> T) rethrows -> T {
        try transform(self)
    }
}
