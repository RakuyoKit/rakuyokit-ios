//
//  RangeReplaceableCollection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/18.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

extension GenericExtendable where Base: RangeReplaceableCollection {
    public mutating func move(from index: Base.Index, to newIndex: Base.Index) {
        let element = base.remove(at: index)
        base.insert(element, at: newIndex)
    }
}
