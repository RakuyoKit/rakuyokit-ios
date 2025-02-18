//
//  RowConfigureApplicable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/6/24.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if os(iOS)
import UIKit

import RAKCore

/// The purpose of this protocol is to make the configuration types in each custom Row more independent
/// and can be used independently of the attached types.
public protocol RowConfigureApplicable: HigherOrderFunctionalizable {
    associatedtype RowBasicType: UIView

    /// Used to apply configuration to row
    func apply(to row: RowBasicType)
}
#endif
