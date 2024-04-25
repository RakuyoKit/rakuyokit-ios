//
//  Encrypted.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - Encrypted

public enum Encrypted {
    public typealias DynamicKeyBlock = () -> String?
}

// MARK: - Get

extension Encrypted {
    public static func getWrappedValue<T: Codable>(
        from userDefaults: UserDefaults,
        with needEncrypted: inout NeedEncrypted<T>
    ) -> T? {
        needEncrypted.getWrappedValue(from: userDefaults)
    }
    
    public static func getWrappedValue<T: Codable>(
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

extension Encrypted {
    public static func setValue<T: Codable>(
        _ value: T?,
        to userDefaults: UserDefaults,
        with needEncrypted: inout NeedEncrypted<T>
    ) {
        needEncrypted.setValue(value, to: userDefaults)
    }
    
    public static func setValue<T: Codable>(
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
