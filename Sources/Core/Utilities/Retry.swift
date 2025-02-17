//
//  Retry.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

public enum Retry {
    /// Allows retrying a task executed within `task`
    ///
    /// - Parameters:
    ///   - maxAttempts: Maximum number of retry attempts
    ///   - delay: Delay for each retry, default is one second
    ///   - useExponentialBackoff: Whether to use "exponential backoff" to increase the interval between retries. Defaults to `false`, meaning a fixed interval
    ///   - task: The task to be executed
    /// - Returns: The result of the task
    @discardableResult
    public static func run<T>(
        maxAttempts: Int,
        delay: TimeInterval = 1,
        useExponentialBackoff: Bool = false,
        task: @escaping () async throws -> T
    ) async throws -> T {
        var attempts = 0
        while attempts < maxAttempts {
            do {
                return try await task()
            } catch {
                attempts += 1
                if attempts >= maxAttempts {
                    throw error
                }

                // Choose between exponential backoff or fixed delay based on the parameter
                let delayDuration = useExponentialBackoff ? delay * pow(2, Double(attempts - 1)) : delay
                if delayDuration > 0 {
                    try await Task.sleep(nanoseconds: UInt64(delayDuration * 1_000_000_000))
                }
            }
        }
        throw NSError(
            domain: "RetryError",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Failed after \(maxAttempts) attempts"]
        )
    }
}
