//
//  Throttler.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - DispatchSemaphoreWrapper

public struct DispatchSemaphoreWrapper {
    private let semaphore: DispatchSemaphore
    
    public init(withValue value: Int) {
        semaphore = DispatchSemaphore(value: value)
    }
    
    public func sync<R>(execute: () throws -> R) rethrows -> R {
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        return try execute()
    }
}

// MARK: - Throttler

public final class Throttler {
    fileprivate let semaphore: DispatchSemaphoreWrapper
    
    private var maxInterval: Double
    
    private lazy var queue = DispatchQueue(label: "com.rakuyo.RakuyoKit.throttler", qos: .background)
    
    private lazy var job = DispatchWorkItem { }
    private lazy var previousRun = Date.distantPast
    
    public init(seconds: Double) {
        maxInterval = seconds
        semaphore = DispatchSemaphoreWrapper(withValue: 1)
    }
    
    public func execute(_ block: @escaping EmptyClosure) {
        semaphore.sync {
            job.cancel()
            job = DispatchWorkItem { [weak self] in
                self?.previousRun = Date()
                block()
            }
            let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
            queue.asyncAfter(deadline: .now() + delay, execute: job)
        }
    }
}

extension Date {
    fileprivate static func second(from referenceDate: Date) -> TimeInterval {
        Date().timeIntervalSince(referenceDate).rounded()
    }
}
