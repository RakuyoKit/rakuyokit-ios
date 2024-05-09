//
//  RAKEncodable+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

import RAKCore

// MARK: - Extendable + RAKEncodable

extension Extendable: RAKEncodable where Base: Encodable {
    public var encodeValue: Base { base }
}

// MARK: - GenericExtendable + RAKEncodable

extension GenericExtendable: RAKEncodable where Base: Encodable {
    public var encodeValue: Base { base }
}
