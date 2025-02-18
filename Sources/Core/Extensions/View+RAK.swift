//
//  View+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(tvOS) && !os(visionOS)
import SwiftUI

import WidgetKit

extension View {
    @ViewBuilder
    public func widgetBackground(@ViewBuilder _ backgroundView: () -> some View) -> some View {
        // Adapt to iOS 17 background view changes
        if #available(iOS 17.0, watchOS 10.0, *) {
            containerBackground(for: .widget) { backgroundView() }
        } else {
            background(backgroundView())
        }
    }
}
#endif
