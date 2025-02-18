//
//  Layout+Custom.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView
import RAKCore

extension Extendable where Base: Layout.Section {
    //  When extending `Layout.LayoutType` to customize layouts, this serves as a reference baseline.
    //  It is also the specific implementation for the two layout methods below.
    
    public static func custom(
        layoutEnvironment environment: Layout.Environment,
        style: Layout.Style,
        supplementaryItems: [SupplementaryItem] = [],
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets? = nil,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil
    ) -> Base {
        create(
            layoutEnvironment: environment,
            style: style,
            supplementaryItems: supplementaryItems,
            decoration: decoration,
            edgeInsets: edgeInsets,
            sectionAdditionalEdgeInsets: sectionAdditionalEdgeInsets
        )
    }
}

extension Extendable where Base: Layout.Compositional {
    //  When inheriting `BaseCodeCollectionViewController`,
    //  use this in the controller's .layout property to provide consistent layout for the entire list.
    
    public static func custom(
        style: Layout.Style,
        supplementaryItems: [SupplementaryItem] = [],
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets? = nil,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil,
        configuration: Layout.CompositionalConfiguration? = nil
    ) -> Base {
        let sectionProvider: Layout.CompositionalSectionProvider = { _, environment in
            Layout.Section.rak.custom(
                layoutEnvironment: environment,
                style: style,
                supplementaryItems: supplementaryItems,
                decoration: decoration,
                edgeInsets: edgeInsets,
                sectionAdditionalEdgeInsets: sectionAdditionalEdgeInsets
            )
        }

        guard let configuration else { return .init(sectionProvider: sectionProvider) }
        return .init(sectionProvider: sectionProvider, configuration: configuration)
    }
}

extension SectionProviderWrapper {
    //  Used in the `.layout()` method of data tree.
    //  Provides a special layout for a specific Section.
    
    public static func custom(
        style: Layout.Style,
        supplementaryItems: [SupplementaryItem] = [],
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets? = nil,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil
    ) -> Self {
        .init {
            Layout.Section.rak.custom(
                layoutEnvironment: $0,
                style: style,
                supplementaryItems: supplementaryItems,
                decoration: decoration,
                edgeInsets: edgeInsets,
                sectionAdditionalEdgeInsets: sectionAdditionalEdgeInsets
            )
        }
    }
}
#endif
