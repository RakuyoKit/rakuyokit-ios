//
//  CoreConfig+Demo.swift
//  RakuyoKitDemo
//
//  Created by Rakuyo on 2024/5/9.
//

import Foundation

import RAKConfig

extension ConfigMediator: ConfigMediatorProtocol {
    public var source: EmptyConfig { .shared }
}
