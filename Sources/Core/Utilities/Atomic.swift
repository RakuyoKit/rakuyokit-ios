//
//  Atomic.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

@propertyWrapper
public final class Atomic<Value> {
    private var lock = NSRecursiveLock()
    
    private var value: Value
    
    public var wrappedValue: Value {
        get {
            lock.lock(); defer { lock.unlock() }
            return value
        }
        set {
            lock.lock(); defer { lock.unlock() }
            value = newValue
        }
    }
    
    public init(wrappedValue value: Value) {
        self.value = value
    }
}
