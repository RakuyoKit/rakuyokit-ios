//
//  Layout+Flow.swift
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
    //  When extending `Layout.LayoutType` for flow layout,
    //  this serves as a reference and specific implementation for the two layout methods below.
    
    public static func flow(
        layoutEnvironment environment: Layout.Environment,
        itemSize: Layout.Size,
        scrollingBehavior behavior: Layout.ScrollingBehavior = .none,
        customGroup: Layout.CustomGroupFactory? = nil,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        edgeInsets: SectionEdgeInsets? = nil
    ) -> Base {
        custom(
            layoutEnvironment: environment,
            style: .flow(
                itemSize: itemSize,
                scrollingBehavior: behavior,
                customGroup: customGroup
            ),
            header: header.flatMap { .header(style: $0) },
            footer: footer.flatMap { .footer(style: $0) },
            decoration: decoration,
            edgeInsets: edgeInsets
        )
    }
}

extension Extendable where Base: Layout.Compositional {
    //  When inheriting `BaseCodeCollectionViewController`,
    //  use in the controller's `layout` property to provide consistent layout for the entire list.
    
    public static func flow(
        itemSize: Layout.Size,
        scrollingBehavior behavior: Layout.ScrollingBehavior = .none,
        customGroup: Layout.CustomGroupFactory? = nil,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        edgeInsets: SectionEdgeInsets? = nil
    ) -> Self {
        Base { _, environment in
            Layout.Section.rak.flow(
                layoutEnvironment: environment,
                itemSize: itemSize,
                scrollingBehavior: behavior,
                customGroup: customGroup,
                header: header,
                footer: footer,
                decoration: decoration,
                edgeInsets: edgeInsets
            )
        }.rak
    }
}

extension SectionProviderWrapper {
    //  Used in the `.layout()` method of data tree.
    //  Provides a special layout for a specific section.
    
    public static func flow(
        itemSize: Layout.Size,
        scrollingBehavior behavior: Layout.ScrollingBehavior = .none,
        customGroup: Layout.CustomGroupFactory? = nil,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        edgeInsets: SectionEdgeInsets? = nil
    ) -> Self {
        .init {
            Layout.Section.rak.flow(
                layoutEnvironment: $0,
                itemSize: itemSize,
                scrollingBehavior: behavior,
                customGroup: customGroup,
                header: header,
                footer: footer,
                decoration: decoration,
                edgeInsets: edgeInsets
            )
        }
    }
}
#endif
