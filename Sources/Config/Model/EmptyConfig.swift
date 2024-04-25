//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

/// Empty configuration
///
/// Instructions:：
/// ```swift
/// extension ConfigMediator: ConfigMediatorProtocol {
///     public var source: ConfigSourceProtocol { EmptyConfig.shared }
/// }
/// ```
public final class EmptyConfig: ConfigSourceProtocol {
    public static let shared = EmptyConfig()
    
    private init() { }
}
