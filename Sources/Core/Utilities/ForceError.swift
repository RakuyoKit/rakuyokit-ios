//
//  ForceError.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

/// Forceful error type conversion
public enum ForceError {
    /// Forcefully converts an error type to the target type
    ///
    /// Suitable for APIs that do not yet provide typed errors
    @discardableResult
    public static func convert<Success, Error: Swift.Error>(
        to _: Error.Type,
        _ body: () async throws -> Success
    ) async throws(Error) -> Success {
        do {
            return try await body()
        } catch {
            // swiftlint:disable:next force_cast
            throw error as! Error
        }
    }
}
