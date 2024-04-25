//
//  Decodable+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

extension Extendable where Base: RAKDecodable {
    /// Convert JSON string to object or array.
    public static func decodeJSON(from string: String?, designatedPath: String? = nil) -> Base? {
        guard
            let data = string?.data(using: .utf8),
            let jsonData = getInnerObject(inside: data, by: designatedPath)
        else {
            return nil
        }
        return try? JSONDecoder().decode(Base.self, from: jsonData)
    }
    
    /// Convert binary JSON to object or array.
    public static func decodeJSON(from data: Data?, designatedPath _: String? = nil) -> Base? {
        guard let jsonData = data else { return nil }
        return try? JSONDecoder().decode(Base.self, from: jsonData)
    }
    
    /// Convert jsonObject to object or array.
    public static func decodeJSON(from jsonObject: Any?, designatedPath: String? = nil) -> Base? {
        if let jsonString = jsonObject as? String {
            return decodeJSON(from: jsonString, designatedPath: designatedPath)
        }
        
        if let jsonData = jsonObject as? Data {
            return decodeJSON(from: jsonData, designatedPath: designatedPath)
        }
        
        guard
            let jsonObject,
            JSONSerialization.isValidJSONObject(jsonObject),
            let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
            let jsonData = getInnerObject(inside: data, by: designatedPath)
        else {
            return nil
        }
        
        return try? JSONDecoder().decode(Base.self, from: jsonData)
    }
}

// MARK: - internal

extension Extendable where Base: RAKDecodable {
    /// Borrowed from HandyJSON, this method retrieves data within the designatedPath from an object.
    ///
    /// - Parameters:
    ///   - jsonData: The JSON data.
    ///   - designatedPath: The designated path within the JSON object.
    /// - Returns: The data, possibly a JSON object.
    static func getInnerObject(inside jsonData: Data?, by designatedPath: String?) -> Data? {
        // Ensure jsonData is not nil and designatedPath is valid
        guard
            let _jsonData = jsonData,
            let paths = designatedPath?.components(separatedBy: "."),
            paths.isNotEmpty
        else {
            return jsonData
        }
        
        // Retrieve the jsonObject specified by designatedPath from jsonObject
        let jsonObject = try? JSONSerialization.jsonObject(with: _jsonData, options: .allowFragments)
        var result: Any? = jsonObject
        var abort = false
        var next = jsonObject as? [String: Any]
        
        for path in paths {
            if path.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty || abort {
                continue
            }
            
            guard let _next = next?[path] else {
                abort = true
                continue
            }
            
            result = _next
            next = _next as? [String: Any]
        }
        
        // Conditions to ensure correct result is returned: ensure no abortion, ensure conversion to Data type from jsonObject
        guard
            !abort,
            let resultJsonObject = result,
            let data = try? JSONSerialization.data(withJSONObject: resultJsonObject, options: [])
        else {
            return nil
        }
        
        return data
    }
}
