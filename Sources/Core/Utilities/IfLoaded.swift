//
//  IfLoaded.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/16.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

// MARK: - IfLoaded

///  When you want to determine "whether this property/variable has been set",
///  you can use this type to wrap your real type to achieve your needs.
///
///  - Note: If you need to wrap **Optional** type, use `IfOptionalLoaded`.
///
///  Example:
///  ```swift
///  struct Test {
///    var str: String?
///    let num: Int
///  }
///
///  let a = IfLoaded<Test>.loaded(.init(str: "a", num: 0))
///
///  let num/*: Int?*/ = a.num // 0
///  let str/*: String?*/ = a.str // "a"
///  ```
@dynamicMemberLookup
public enum IfLoaded<Wrapped> {
    case loaded(Wrapped)
    case notYet

    public var value: Wrapped? {
        switch self {
        case .loaded(let wrapped):
            wrapped
        case .notYet:
            nil
        }
    }

    public subscript<P>(dynamicMember keyPath: KeyPath<Wrapped, P>) -> P? {
        value?[keyPath: keyPath]
    }

    public subscript<P: ExpressibleByNilLiteral>(dynamicMember keyPath: KeyPath<Wrapped, P>) -> P {
        value?[keyPath: keyPath] ?? nil
    }
}

// MARK: Equatable

extension IfLoaded: Equatable where Wrapped: Equatable { }

// MARK: Hashable

extension IfLoaded: Hashable where Wrapped: Hashable { }

// MARK: Decodable

extension IfLoaded: Decodable where Wrapped: Decodable { }
