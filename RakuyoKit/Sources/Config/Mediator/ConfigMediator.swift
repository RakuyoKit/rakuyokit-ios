//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

/// The caller obtains the corresponding configuration through this object
public let Config = ConfigMediator() // swiftlint:disable:this identifier_name

/// Mediator for calling configuration
public final class ConfigMediator: ConfigSourceProtocol {
    private typealias Mediator = any ConfigMediatorProtocol
    
    private var this: Mediator {
        guard let mediator = self as? Mediator else {
            fatalError("Please make \(Self.self) implement \(Mediator.self) protocol in the main project!")
        }
        return mediator
    }
    
    public var color: ColorConfig { this.source.color }
    
    public var appStoreConnectAppleID: String { this.source.appStoreConnectAppleID }
}
