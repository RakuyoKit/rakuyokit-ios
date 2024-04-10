//
//  Decryptable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

import CryptoSwift
import RAKCore

/// Decryption result.
public enum DecryptResult<T: RAKCodable> {
    /// Decryption failed.
    case decryptFailure(error: Error)
    
    /// Decryption succeeded.
    case success(result: T)
    
    /// When decrypting Data type data, conversion to base64 Data failed.
    case toBase64DataFailure
    
    /// Decryption succeeded, but type transformation failed.
    case transformFailure
}

/// Provides decryption capability.
public protocol Decryptable {
    /// The AES instance for decryption.
    var aes: AES { get set }
    
    /// Decrypts encrypted data.
    ///
    /// - Parameter value: The encrypted data to decrypt.
    /// - Returns: The decryption result. See `DecryptResult` for details.
    func decrypt<T: RAKCodable>(_ value: String) -> DecryptResult<T>
}

public extension Decryptable {
    func decrypt<T: RAKCodable>(_ value: String) -> DecryptResult<T> {
        guard let decodedData = Data(base64Encoded: value) else {
            return .toBase64DataFailure
        }
        
        do {
            let decryptResult = try decodedData.decrypt(cipher: aes)
            
            if let result = decryptResult as? T {
                return .success(result: result)
            }
            
            if let resutl = T.rak.decodeJSON(from: decryptResult) {
                return .success(result: resutl)
            }
            
            return .transformFailure
            
        } catch {
            return .decryptFailure(error: error)
        }
    }
}
