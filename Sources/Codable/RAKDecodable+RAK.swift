//
//  RAKDecodable+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

import RAKCore

// MARK: - Extendable + RAKDecodable

extension Extendable: RAKDecodable where Base: Decodable {
    public typealias DecodeType = Base
}

// MARK: - GenericExtendable + RAKDecodable

extension GenericExtendable: RAKDecodable where Base: Decodable {
    public typealias DecodeType = Base
}

extension GenericExtendable where Base: Collection & Decodable, Generic == Base.Element, Generic: Decodable {
    public static func decodeJSON(from jsonString: String?, designatedPath: String? = nil) -> [Generic?]? {
        guard
            let data = jsonString?.data(using: .utf8),
            let jsonData = getInnerObject(inside: data, by: designatedPath),
            let _jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let jsonObject = _jsonObject as? [Any]
        else {
            return nil
        }
        return decodeJSON(from: jsonObject)?.toArray()
    }
}

extension GenericExtendable where Base: Collection & Decodable, Generic == Base.Element, Generic: Decodable & NamespaceProviding {
    public static func decodeJSON(from array: [Any]?) -> [Generic?]? {
        array?.map { Generic.rak.decodeJSON(from: $0) }
    }
}

extension GenericExtendable where Base: Collection & Decodable, Generic == Base.Element,
    Generic: Decodable & GenericNamespaceProviding
{
    public static func decodeJSON(from array: [Any]?) -> [Generic?]? {
        array?.map { Generic.rak.decodeJSON(from: $0) }
    }
}
