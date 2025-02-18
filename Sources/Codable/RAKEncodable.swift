//
//  RAKEncodable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

import RaLog

// MARK: - RAKEncodable

/// For extending `Encodable`
public protocol RAKEncodable {
    associatedtype EncodeType: Encodable

    ///
    var encodeValue: EncodeType { get }

    /// Convert to binary JSON data.
    func toJSONData() throws -> Data

    /// Convert to JSON object.
    func toJSONObject() throws -> Any

    /// Convert to JSON string.
    func toJSONString() throws -> String?

    ///
    func encode() -> [String: Any?]
}

// MARK: - Default

extension RAKEncodable {
    /// Convert to binary JSON data.
    public func toJSONData() throws -> Data {
        do {
            return try JSONEncoder().encode(encodeValue)

        } catch {
            Log.error("Failed to convert \(encodeValue) to binary JSON: \(error)")
            throw error
        }
    }

    /// Convert to JSON object.
    public func toJSONObject() throws -> Any {
        do {
            let data = try toJSONData()
            return try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])

        } catch {
            Log.error("Failed to convert \(encodeValue) to JSON object: \(error)")
            throw error
        }
    }

    /// Convert to JSON string.
    public func toJSONString() throws -> String? {
        do {
            let data = try toJSONData()
            return String(data: data, encoding: .utf8)

        } catch {
            Log.error("Failed to convert \(encodeValue) to JSON string: \(error)")
            throw error
        }
    }

    ///
    public func encode() -> [String: Any?] {
        guard let encoded = try? toJSONObject() else {
            return [:]
        }

        guard let result = encoded as? [String: Any?] else {
            Log.error("Failed to convert \(self) to type \([String: Any?].self)")
            return [:]
        }

        return result
    }
}
