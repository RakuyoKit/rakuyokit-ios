//
//  Layout+List.swift
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
    //  When extending `Layout.LayoutType` for list layout,
    //  Also the specific implementations for the two layout methods below.
    
    public static func list(
        layoutEnvironment environment: Layout.Environment,
        spacing: ListSpacing = .default,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil
    ) -> Base {
        custom(
            layoutEnvironment: environment,
            style: .list,
            supplementaryItems: createSupplementaryItems(header: header, footer: footer),
            decoration: decoration,
            edgeInsets: .bottom(spacing.spacing),
            sectionAdditionalEdgeInsets: sectionAdditionalEdgeInsets
        )
    }

    public static func list(
        layoutEnvironment environment: Layout.Environment,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets?,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil
    ) -> Base {
        custom(
            layoutEnvironment: environment,
            style: .list,
            supplementaryItems: createSupplementaryItems(header: header, footer: footer),
            decoration: decoration,
            edgeInsets: edgeInsets,
            sectionAdditionalEdgeInsets: sectionAdditionalEdgeInsets
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
        decoration: DecorationStyle? = .whiteBackground,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil,
        configuration: Layout.CompositionalConfiguration? = nil
    ) -> Base {
        let sectionProvider: Layout.CompositionalSectionProvider = { _, environment in
            Layout.Section.rak.list(
                layoutEnvironment: environment,
                spacing: spacing,
                header: header,
                footer: footer,
                decoration: decoration,
                sectionAdditionalEdgeInsets: sectionAdditionalEdgeInsets
            )
        }

        guard let configuration else { return .init(sectionProvider: sectionProvider) }
        return .init(sectionProvider: sectionProvider, configuration: configuration)
    }

    public static func list(
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets?,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil,
        configuration: Layout.CompositionalConfiguration? = nil
    ) -> Base {
        let sectionProvider: Layout.CompositionalSectionProvider = { _, environment in
            Layout.Section.rak.list(
                layoutEnvironment: environment,
                header: header,
                footer: footer,
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
    
    public static func list(
        spacing: ListSpacing = .default,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackground,
        sectionAdditionalEdgeInsets _: SectionEdgeInsets? = nil
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

    public static func list(
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets?,
        sectionAdditionalEdgeInsets _: SectionEdgeInsets? = nil
    ) -> Self {
        .init {
            Layout.Section.rak.list(
                layoutEnvironment: $0,
                header: header,
                footer: footer,
                decoration: decoration,
                edgeInsets: edgeInsets
            )
        }
    }
}
#endif
