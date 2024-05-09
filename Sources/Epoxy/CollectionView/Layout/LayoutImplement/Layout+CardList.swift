//
//  Layout+CardList.swift
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
    //  When extending `Layout.LayoutType` to customize layout, this serves as a reference benchmark
    //  Also, it's the specific implementation of the following two layout methods.
    
    public static func cardList(
        layoutEnvironment environment: Layout.Environment,
        spacing: ListSpacing = .normal,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackgroundAndCornerRadius()
    ) -> Base {
        custom(
            layoutEnvironment: environment,
            style: .list,
            header: header,
            footer: footer,
            decoration: decoration,
            edgeInsets: .card(bottom: spacing.spacing)
        )
    }
}

extension Extendable where Base: Layout.Compositional {
    //  When inheriting `BaseCodeCollectionViewController`,
    //  use this in the controller's .layout property. Provides consistent layout for the entire list.
    
    public static func cardList(
        spacing: ListSpacing = .normal,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackgroundAndCornerRadius()
    ) -> Self {
        Base { _, environment in
            Layout.Section.rak.cardList(
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
    //  Used in the `.layout()` method of the Data Tree.
    //  Provides a special layout for a certain Section.
    
    public static func cardList(
        spacing: ListSpacing = .normal,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackgroundAndCornerRadius()
    ) -> Self {
        .init {
            Layout.Section.rak.cardList(
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
