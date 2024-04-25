//
//  Encryptable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

import CryptoSwift
import RaLog

// MARK: - EncryptResult

/// Encryption result.
public enum EncryptResult {
    /// Encryption failed.
    case encryptFailure
    
    /// Encryption succeeded, and conversion to base64 succeeded.
    case success(result: String)
}

// MARK: - Encryptable

/// Provides encryption capability.
public protocol Encryptable {
    /// The AES instance for encryption.
    var aes: AES { get set }
    
    /// Encrypts `content` and returns a base64 string.
    ///
    /// - Parameter content: The content to be encrypted.
    /// - Returns: The encryption result. See `EncryptResult` for details.
    func encrypt(_ content: some Codable) -> EncryptResult
}

extension Encryptable {
    public func encrypt(_ content: some Codable) -> EncryptResult {
        do {
            let data = try JSONEncoder().encode(content)
            let result = try aes.encrypt(data.bytes).toBase64()
            
            return .success(result: result)
            
        } catch {
            Log.error("\(content) encountered an error during encryption: \(error)")
            return .encryptFailure
        }
    }
}
