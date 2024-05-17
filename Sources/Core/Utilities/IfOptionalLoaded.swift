//
//  IfOptionalLoaded.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/16.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - IfOptionalLoaded

///  When you want to determine "whether this property/variable has been set",
///  you can use this type to wrap your real type to achieve your needs.
///
///  - Note: If you need to wrap **non-Optional** types, use `IfLoaded`.
///
///  Example:
///  ```swift
///  let b = IfOptionalLoaded<String?>.loaded(nil)
///  let count/*: Int?*/ = b.count // nil
///  ```
@dynamicMemberLookup
public enum IfOptionalLoaded<OptionalWrapped: OptionalProtocol> {
    case loaded(OptionalWrapped)
    case notYet

    public var value: OptionalWrapped {
        switch self {
        case .loaded(let wrapped):
            wrapped
        case .notYet:
            nil
        }
    }

    public subscript<P>(dynamicMember keyPath: KeyPath<OptionalWrapped.Wrapped, P>) -> P? {
        value.wrapped?[keyPath: keyPath]
    }

    public subscript<P: ExpressibleByNilLiteral>(dynamicMember keyPath: KeyPath<OptionalWrapped.Wrapped, P>) -> P {
        value.wrapped?[keyPath: keyPath] ?? nil
    }
}

// MARK: Equatable

extension IfOptionalLoaded: Equatable where OptionalWrapped: Equatable { }

// MARK: Hashable

extension IfOptionalLoaded: Hashable where OptionalWrapped: Hashable { }

// MARK: Decodable

extension IfOptionalLoaded: Decodable where OptionalWrapped: Decodable { }

// MARK: - OptionalProtocol

public protocol OptionalProtocol: ExpressibleByNilLiteral {
    associatedtype Wrapped

    var wrapped: Wrapped? { get }

    func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?

    func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?
}

// MARK: - Optional + OptionalProtocol

extension Optional: OptionalProtocol {
    public var wrapped: Wrapped? { self }
}
