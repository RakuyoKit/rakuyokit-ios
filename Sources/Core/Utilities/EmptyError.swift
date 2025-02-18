//
//  EmptyError.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

public typealias NoErrorResult<Success> = Result<Success, EmptyError>

// MARK: - EmptyError

/// Placeholder when `.failure` is needed but `Error` is not needed
///
/// `Result<Success, Never>` means no error will occur, so `.failure` cannot be constructed in this case
/// But sometimes `.failure` is needed but it doesn't matter what kind of error is thrown.
/// It would be troublesome to construct a specific Error in this case. In this case, `EmptyError` can be used
public struct EmptyError: Error, ExpressibleByNilLiteral {
    public init() { }
    public init(nilLiteral _: ()) { }
}
