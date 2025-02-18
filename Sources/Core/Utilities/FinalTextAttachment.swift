//
//  FinalTextAttachment.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import Then

/// A blank subclass of `NSTextAttachment`, used to conform to the `HigherOrderFunctionalizable` protocol
public final class FinalTextAttachment: NSTextAttachment { }

// MARK: - HigherOrderFunctionalizable

extension FinalTextAttachment: HigherOrderFunctionalizable { }
#endif
