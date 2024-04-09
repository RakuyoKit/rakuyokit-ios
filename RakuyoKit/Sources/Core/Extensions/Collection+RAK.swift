//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

public extension Extendable where Base: Collection {
    var isNotEmpty: Bool { !base.isEmpty }
    
    func ifNotEmpty<U>(_ transform: (Base) throws -> U) rethrows -> U? {
        guard isNotEmpty else { return nil }
        return try transform(base)
    }
    
    func toArray() -> [Base.Element] {
        return .init(base)
    }
    
    @inlinable
    func changingEach(_ body: (inout Base.Element) throws -> Void) rethrows -> [Base.Element] {
        return try base.map {
            var copy = $0
            try body(&copy)
            return copy
        }
    }
    
    func removeDuplicated<H: Hashable>(by keyPath: KeyPath<Base.Element, H>) -> [Base.Element] {
        var result = [Base.Element]()
        var map = [H: Base.Element]()
        for ele in base {
            let key = ele[keyPath: keyPath]
            if map[key] == nil {
                map[key] = ele
                result.append(ele)
            }
        }
        return result
    }
    
    func removeDuplicate<H: Hashable>(_ filter: (Base.Element) -> H) -> [Base.Element] {
        var result = [Base.Element]()
        var map = [H: Base.Element]()
        for ele in base {
            let key = filter(ele)
            if map[key] == nil {
                map[key] = ele
                result.append(ele)
            }
        }
        return result
    }
}
