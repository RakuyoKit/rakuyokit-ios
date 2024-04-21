//
//  NeedEncrypted.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

import CryptoSwift
import RAKConfig
import RAKCore
import RaLog

// MARK: - NeedEncrypted

/// Used to mark content that needs to be encrypted.
@propertyWrapper
public final class NeedEncrypted<T: RAKCodable>: Encryptable, Decryptable {
    public typealias DynamicKeyBlock = Encrypted.DynamicKeyBlock
    
    /// Type of key used locally.
    public enum KeyType {
        /// Use name to create key.
        case name
        
        /// Custom prefix under the premise of using name to create key.
        case customPrefix(String)
        
        /// Completely custom.
        case custom(String)
    }
    
    /// AES instance for encryption and decryption.
    public var aes: AES
    
    /// Name, used when logging.
    public let name: String
    
    /// When set to `nil`, only remove the cache from memory without removing it from local cache.
    private let isOnlyRemoveCacheFromMemoryWhenNil: Bool
    
    /// Cache key used as a basic reference in operations.
    private let cacheKey: String
    
    /// The closure to be used each time a key is used, and then concatenated at the end of the key.
    ///
    /// Even if this block returns `nil`, a string `"nil"` will be concatenated at the end of the key.
    private let dynamicKey: DynamicKeyBlock?
    
    /// Used to cache values in memory.
    private lazy var memoryCache: T? = nil
    
    /// Used to access/set memory cache.
    private var cache: T? {
        get {
            // Must read values from local storage each time in extensions, without using memory cache
            guard !inExtension else { return nil }
            return memoryCache
        }
        set {
            // Must read values from local storage each time in extensions, without using memory cache
            guard !inExtension else { return }
            memoryCache = newValue
        }
    }
    
    public var wrappedValue: T? {
        get { getWrappedValue(from: userDefaults) }
        set { setValue(newValue, to: userDefaults) }
    }
    
    public var projectedValue: NeedEncrypted<T> { self }
    
    /// Initializes the wrapper.
    ///
    /// - Parameters:
    ///   - name: The name/description of the content to be encrypted.
    ///   - keyType: The type of `key`.
    ///   - dynamicKey: The closure to be used each time a key is used, and then concatenated at the end of the key.
    ///                 Default is `nil`.
    ///   - isOnlyRemoveCacheFromMemoryWhenNil: When set to `nil`, only remove the cache from memory without removing it
    ///                                         from local cache. Default is `false`.
    public init(
        name: String,
        keyType: KeyType = .name,
        dynamicKey: DynamicKeyBlock? = nil,
        isOnlyRemoveCacheFromMemoryWhenNil: Bool = false
    ) {
        let prefix: String
        let suffix: String
        
        func createSuffix(with value: String) -> String {
            value.lowercased().replacingOccurrences(of: " ", with: "_")
        }
        
        switch keyType {
        case .name:
            prefix = Bundle.rak.appName()
            suffix = createSuffix(with: name)
            
        case .customPrefix(let value):
            prefix = value
            suffix = createSuffix(with: name)
            
        case .custom(let key):
            prefix = ""
            suffix = createSuffix(with: key)
        }
        
        // Control the length, limit it to 16 characters
        let controlLength: (String) -> String = {
            let total = suffix.count + $0.count
            
            guard total > 16 else {
                return suffix + $0 + (0 ..< (16 - total)).map { $0.isMultiple(of: 2) ? "_" : "*" }.joined()
            }
            
            let start = suffix.startIndex
            let end = suffix.index(start, offsetBy: 16 - $0.count)
            
            return suffix[start ..< end] + $0
        }
        
        let aesKey = controlLength("_key")
        let aesIV = controlLength("_iv")
        
        // swiftlint:disable:next force_try
        aes = try! AES(key: aesKey, iv: aesIV, padding: .pkcs5)
        self.name = name
        cacheKey = prefix + "_userdefaults_" + suffix
        self.dynamicKey = dynamicKey
        self.isOnlyRemoveCacheFromMemoryWhenNil = isOnlyRemoveCacheFromMemoryWhenNil
    }
}

// MARK: -

extension NeedEncrypted {
    /// Adds observer for `UserDefaults`.
    ///
    /// - Parameter observer: The observer.
    /// - Returns: The observed keys.
    public func addObserver(_ observer: NSObject) -> (String, String) {
        let key = (successfulKey, failureKey)
        
        for item in [key.0, key.1] {
            userDefaults.addObserver(observer, forKeyPath: item, options: .new, context: nil)
        }
        
        return key
    }
    
    func getWrappedValue(from userDefaults: UserDefaults) -> T? {
        get(from: userDefaults)
    }
    
    func setValue(_ value: T?, to userDefaults: UserDefaults) {
        if let newValue = value {
            save(newValue, to: userDefaults)
        } else {
            remove(from: userDefaults)
        }
    }
}

// MARK: - Private Functions

extension NeedEncrypted {
    /// Used to read `UserDefaults` object.
    private var userDefaults: UserDefaults {
        let appGroupIdentifier = Config.appGroupIdentifier
        
        if appGroupIdentifier.isEmpty { return .standard }
        return .init(suiteName: appGroupIdentifier) ?? .standard
    }
    
    /// Key used to store successfully encrypted data in `UserDefaults`.
    private var successfulKey: String {
        guard let dynamicKey else { return cacheKey }
        return cacheKey + "_" + (dynamicKey() ?? "nil")
    }
    
    /// Key used to store **failure** encrypted data in `UserDefaults`.
    private var failureKey: String {
        // To prevent cracking the package and getting the header file,
        // the value is set to `success`, but it is used to mark encryption failure.
        successfulKey + "_success"
    }
    
    /// Whether the current runtime environment is in an extension.
    private var inExtension: Bool {
        Bundle.rak.map {
            $0.inPushExtension || $0.inWidgetExtension || $0.inWidgetIntentsExtension
        }
    }
    
    /// Save encrypted data to local storage.
    ///
    /// When encryption fails, store unencrypted `content`.
    ///
    /// - Parameters:
    ///   - content: The content to be encrypted and stored.
    ///   - userDefaults: The `UserDefaults` object for storage.
    private func save(_ content: T, to userDefaults: UserDefaults) {
        // Storage method
        func _save(_ tmpCache: some RAKCodable) {
            cache = content
            
            // Encryption successful
            if let _cache = tmpCache as? String {
                userDefaults.set(_cache, forKey: successfulKey)
                Log.success("Successfully cached encrypted \(name).")
            }
            
            // Encryption failed, store original value
            else if let _cache = tmpCache as? EncrypteWrapper<T> {
                do {
                    let jsonString = try _cache.rak.toJSONString()
                    userDefaults.set(jsonString, forKey: failureKey)
                    Log.success("Successfully cached unencrypted \(name).")
                    
                } catch {
                    Log.error(
                        "When storing cache: \(tmpCache)," +
                            "failed to convert it to a JSON string," +
                            "cannot proceed with storage."
                    )
                }
            } else {
                Log.error("When storing cache: \(tmpCache), failed to convert the type, cannot proceed with storage.")
            }
        }
        
        let wrapper = EncrypteWrapper(value: content)
        
        // Encryption
        switch encrypt(wrapper) {
        case .success(let result): _save(result)
        case .encryptFailure: _save(wrapper)
        }
    }
    
    /// Get decrypted data.
    ///
    /// - Parameter userDefaults: The `UserDefaults` object for storage.
    /// - Returns: Decrypted data.
    private func get(from userDefaults: UserDefaults) -> T? {
        // Directly read the cache
        if let _cache = cache { return _cache }
        
        // Read from local cache
        let _cache: T? = {
            if let _cache = getSuccessfulEncryptionCache(from: userDefaults) {
                return _cache.value
            }
            if let _cache = getFailureEncryptionCache(from: userDefaults) {
                return _cache.value
            }
            return nil
        }()
        
        // Cache to memory again
        cache = _cache
        
        return _cache
    }
    
    /// Used to get successfully encrypted data.
    private func getSuccessfulEncryptionCache(
        from userDefaults: UserDefaults
    ) -> EncrypteWrapper<T>? {
        guard let cacheString = userDefaults.string(forKey: successfulKey) else {
            return nil
        }
        
        let decryptResult: DecryptResult<EncrypteWrapper<T>> = decrypt(cacheString)
        switch decryptResult {
        case .success(let _result):
            return _result
            
        case .toBase64DataFailure:
            Log.error("\(name) decryption failed, conversion to base64 Data failed!")
            
        case .transformFailure:
            Log.error("\(name) decryption failed, failed to convert decrypted content to \(EncrypteWrapper<T>.self) type!")
            
        case .decryptFailure(let error):
            Log.error("\(name) decryption failed: \(error)!")
        }
        
        // Remove local cache data if parsing fails
        remove(from: userDefaults)
        return nil
    }
    
    /// Used to get failure encrypted data.
    private func getFailureEncryptionCache(
        from userDefaults: UserDefaults
    ) -> EncrypteWrapper<T>? {
        guard let cacheString = userDefaults.string(forKey: failureKey) else {
            return nil
        }
        
        if let cache = EncrypteWrapper<T>.rak.decodeJSON(from: cacheString) {
            return cache
        }
        
        Log.error("Failed to parse local cached \(name) as \(EncrypteWrapper<T>.self) type, returning nil")
        
        // Remove local cache data if parsing fails
        remove(from: userDefaults)
        return nil
    }
    
    /// Clear data.
    private func remove(from userDefaults: UserDefaults) {
        cache = nil
        
        guard !isOnlyRemoveCacheFromMemoryWhenNil else { return }
        
        userDefaults.removeObject(forKey: successfulKey)
        userDefaults.removeObject(forKey: failureKey)
        
        Log.success("\(name) has been deleted!")
    }
}

// MARK: - EncrypteWrapper

/// Used to wrap data that needs to be encrypted again.
///
/// For some basic Swift data types, such as String and Int, the implementation of encode is not complete
/// and the outermost { } will be missing, leading to failure during dencode. So it needs to be wrapped in an extra layer.
private struct EncrypteWrapper<T: RAKCodable>: RAKCodable {
    let value: T
}
