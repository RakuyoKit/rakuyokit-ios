//
//  Encodable+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

import RaLog

extension Extendable where Base: RAKEncodable {
    /// Convert to binary JSON data.
    public func toJSONData() throws -> Data {
        do {
            return try JSONEncoder().encode(base)
            
        } catch {
            Log.error("Failed to convert \(base) to binary JSON: \(error)")
            throw error
        }
    }
    
    /// Convert to JSON object.
    public func toJSONObject() throws -> Any {
        do {
            let data = try toJSONData()
            return try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
            
        } catch {
            Log.error("Failed to convert \(base) to JSON object: \(error)")
            throw error
        }
    }
    
    /// Convert to JSON string.
    public func toJSONString() throws -> String? {
        do {
            let data = try toJSONData()
            return String(data: data, encoding: .utf8)
            
        } catch {
            Log.error("Failed to convert \(base) to JSON string: \(error)")
            throw error
        }
    }
    
    ///
    public func encode() -> [String: Any?] {
        guard let encoded = try? toJSONObject() else {
            return [:]
        }
        
        guard let result = encoded as? [String: Any?] else {
            Log.error("Failed to convert \(base) to type \([String: Any?].self)")
            return [:]
        }
        
        return result
    }
}
