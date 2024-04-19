//
//  GlobalTypealias.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

/// Used to express an empty closure
public typealias EmptyClosure = () -> Void

#if !os(watchOS)
/// Closure used to call back a button
public typealias ButtonClosure = (_ button: UIButton) -> Void
#endif

/// Used to replace `Encodable` and provide the `rak` namespace.
///
/// Please try to use `RAKEncodable` instead of `Encodable` in your project.
public typealias RAKEncodable = Encodable & NamespaceProviding

/// Used to replace `RAKDecodable` and provide the `rak` namespace.
///
/// Please try to use `RAKDecodable` instead of `Decodable` in your project.
public typealias RAKDecodable = Decodable & NamespaceProviding

/// Used to replace `Codable` and provide the `rak` namespace.
///
/// Please try to use `RAKCodable` instead of `Codable` in your project.
public typealias RAKCodable = RAKDecodable & RAKEncodable
