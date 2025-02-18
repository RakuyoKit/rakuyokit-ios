//
//  GlobalTypealias.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

/// Used to express an empty closure
public typealias EmptyClosure = () -> Void

#if !os(watchOS)
/// Closure used to call back a button
public typealias ButtonClosure = (_ button: UIButton) -> Void
#endif
