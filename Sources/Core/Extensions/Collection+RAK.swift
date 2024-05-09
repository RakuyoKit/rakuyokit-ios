//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

extension Collection {
    public var isNotEmpty: Bool { !isEmpty }
    
    public func toArray() -> [Element] {
        .init(self)
    }
}

extension GenericExtendable where Base: Collection {
    public func ifNotEmpty<U>(_ transform: (Base) throws -> U) rethrows -> U? {
        guard base.isNotEmpty else { return nil }
        return try transform(base)
    }
    
    @inlinable
    public func changingEach(_ body: (inout Base.Element) throws -> Void) rethrows -> [Base.Element] {
        try base.map {
            var copy = $0
            try body(&copy)
            return copy
        }
    }
    
    public func removeDuplicated<H: Hashable>(by keyPath: KeyPath<Base.Element, H>) -> [Base.Element] {
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
    
    public func removeDuplicate<H: Hashable>(_ filter: (Base.Element) -> H) -> [Base.Element] {
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
