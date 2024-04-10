//
//  Encrypted.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

public enum Encrypted {
    public typealias DynamicKeyBlock = () -> String?
}

// MARK: - Get

public extension Encrypted {
    static func getWrappedValue<T: Codable>(
        from userDefaults: UserDefaults,
        with needEncrypted: inout NeedEncrypted<T>
    ) -> T? {
        return needEncrypted.getWrappedValue(from: userDefaults)
    }
    
    static func getWrappedValue<T: Codable>(
        from userDefaults: UserDefaults,
        name: String,
        keyType: NeedEncrypted<T>.KeyType,
        dynamicKey: DynamicKeyBlock?,
        isOnlyRemoveCacheFromMemoryWhenNil: Bool = false
    ) -> T? {
        var needEncrypted = NeedEncrypted<T>(
            name: name,
            keyType: keyType,
            dynamicKey: dynamicKey,
            isOnlyRemoveCacheFromMemoryWhenNil: isOnlyRemoveCacheFromMemoryWhenNil
        )
        return getWrappedValue(from: userDefaults, with: &needEncrypted)
    }
}

// MARK: - Set

public extension Encrypted {
    static func setValue<T: Codable>(
        _ value: T?,
        to userDefaults: UserDefaults,
        with needEncrypted: inout NeedEncrypted<T>
    ) {
        needEncrypted.setValue(value, to: userDefaults)
    }
    
    static func setValue<T: Codable>(
        _ value: T?,
        to userDefaults: UserDefaults,
        name: String,
        keyType: NeedEncrypted<T>.KeyType,
        dynamicKey: DynamicKeyBlock?,
        isOnlyRemoveCacheFromMemoryWhenNil: Bool = false
    ) {
        var needEncrypted = NeedEncrypted<T>(
            name: name,
            keyType: keyType,
            dynamicKey: dynamicKey,
            isOnlyRemoveCacheFromMemoryWhenNil: isOnlyRemoveCacheFromMemoryWhenNil
        )
        setValue(value, to: userDefaults, with: &needEncrypted)
    }
}
