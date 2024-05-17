//
//  Layout+Waterfall.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView
import RAKCore

extension Extendable where Base: Layout.Section {
    //  When extending `Layout.LayoutType` for waterfall layout,
    //  this serves as a reference and specific implementation for the two layout methods below.

    public static func waterfall(
        layoutEnvironment environment: Layout.Environment,
        config: WaterfallCompositionalLayout.Configuration,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil
    ) -> Base {
        let section: Base = WaterfallCompositionalLayout.makeLayoutSection(environment: environment, config: config)
        return section.then {
            $0.boundarySupplementaryItems = createBoundarySupplementaryItems(
                by: .init(header: header, footer: footer)
            )
        }
    }
}

extension Extendable where Base: Layout.Compositional {
    //  When inheriting `BaseCodeCollectionViewController`,
    //  use in the controller's `layout` property to provide consistent layout for the entire list.

    public static func waterfall(
        config: WaterfallCompositionalLayout.Configuration,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil
    ) -> Self {
        Base { _, environment in
            Layout.Section.rak.waterfall(
                layoutEnvironment: environment,
                config: config,
                header: header,
                footer: footer
            )
        }.rak
    }
}

extension SectionProviderWrapper {
    //  Used in the `.layout()` method of data tree.
    //  Provides a special layout for a specific section.

    public static func waterfall(
        config: WaterfallCompositionalLayout.Configuration,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil
    ) -> Self {
        .init {
            Layout.Section.rak.waterfall(
                layoutEnvironment: $0,
                config: config,
                header: header,
                footer: footer
            )
        }
    }
}
#endif
