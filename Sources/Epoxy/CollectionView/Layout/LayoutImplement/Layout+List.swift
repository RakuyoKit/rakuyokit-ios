//
//  Layout+List.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView
import RAKCore

extension Extendable where Base: Layout.Section {
    //  When extending `Layout.LayoutType` for list layout,
    //  Also the specific implementations for the two layout methods below.
    
    public static func list(
        layoutEnvironment environment: Layout.Environment,
        spacing: ListSpacing = .default,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground
    ) -> Base {
        custom(
            layoutEnvironment: environment,
            style: .list,
            supplementaryItems: createSupplementaryItems(header: header, footer: footer),
            decoration: decoration,
            edgeInsets: .bottom(spacing.spacing)
        )
    }
}

extension Extendable where Base: Layout.Compositional {
    //  When inheriting `BaseCodeCollectionViewController`,
    //  use in the controller's `layout` property to provide consistent layout for the entire list.
    
    public static func list(
        spacing: ListSpacing = .default,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground
    ) -> Self {
        Base { _, environment in
            Layout.Section.rak.list(
                layoutEnvironment: environment,
                spacing: spacing,
                header: header,
                footer: footer,
                decoration: decoration
            )
        }.rak
    }
}

extension SectionProviderWrapper {
    //  Used in the `.layout()` method of data tree.
    //  Provides a special layout for a specific Section.
    
    public static func list(
        spacing: ListSpacing = .default,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground
    ) -> Self {
        .init {
            Layout.Section.rak.list(
                layoutEnvironment: $0,
                spacing: spacing,
                header: header,
                footer: footer,
                decoration: decoration
            )
        }
    }
}
#endif
