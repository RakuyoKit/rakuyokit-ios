//
//  WidgetConfiguration+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(tvOS) && !os(visionOS)
import SwiftUI

import WidgetKit

@available(iOS 14.0, macOS 11.0, watchOS 9.0, *)
@available(tvOS, unavailable)
extension WidgetConfiguration {
    public func contentMarginsDisabledForGlobal() -> some WidgetConfiguration {
        if #available(iOS 15.0, *) { return contentMarginsDisabled() }
        return self
    }
}
#endif
