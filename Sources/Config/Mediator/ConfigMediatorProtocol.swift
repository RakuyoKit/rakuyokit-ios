//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

/// The middleman protocol serves as the bridge between `Mediator` and `SourceProtocol`.
public protocol ConfigMediatorProtocol {
    associatedtype SourceProtocol: ConfigSourceProtocol
    
    var source: SourceProtocol { get }
}
