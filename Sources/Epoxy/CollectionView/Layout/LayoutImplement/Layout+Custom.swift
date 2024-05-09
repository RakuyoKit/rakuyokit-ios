//
//  Layout+Custom.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

import EpoxyCollectionView
import RAKCore

extension Extendable where Base: Layout.Section {
    //  When extending `Layout.LayoutType` to customize layouts, this serves as a reference baseline.
    //  It is also the specific implementation for the two layout methods below.
    
    public static func custom(
        layoutEnvironment environment: Layout.Environment,
        style: Layout.Style,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        edgeInsets: SectionEdgeInsets? = nil
    ) -> Base {
        create(
            layoutEnvironment: environment,
            style: style,
            supplementaryItem: .init(
                header: header,
                footer: footer
            ),
            decoration: decoration,
            edgeInsets: edgeInsets
        )
    }
}

extension Extendable where Base: Layout.Compositional {
    //  When inheriting `BaseCodeCollectionViewController`,
    //  use this in the controller's .layout property to provide consistent layout for the entire list.
    
    public static func custom(
        style: Layout.Style,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        edgeInsets: SectionEdgeInsets? = nil
    ) -> Self {
        Base { _, environment in
            Layout.Section.rak.custom(
                layoutEnvironment: environment,
                style: style,
                header: header,
                footer: footer,
                decoration: decoration,
                edgeInsets: edgeInsets
            )
        }.rak
    }
}

extension SectionProviderWrapper {
    //  Used in the `.layout()` method of the Data Tree.
    //  Provides a special layout for a specific Section.
    
    public static func custom(
        style: Layout.Style,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        edgeInsets: SectionEdgeInsets? = nil
    ) -> Self {
        .init {
            Layout.Section.rak.custom(
                layoutEnvironment: $0,
                style: style,
                header: header,
                footer: footer,
                decoration: decoration,
                edgeInsets: edgeInsets
            )
        }
    }
}
#endif
