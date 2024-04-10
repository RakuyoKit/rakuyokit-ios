//
//  Layout+CardList.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import EpoxyCollectionView
import RAKCore

public extension Extendable where Base: Layout.Section {
    /*
     *  When extending `Layout.LayoutType` to customize layout, this serves as a reference benchmark
     *  Also, it's the specific implementation of the following two layout methods.
     */
    
    static func cardList(
        layoutEnvironment environment: Layout.Environment,
        spacing: ListSpacing = .normal,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackgroundAndCornerRadius()
    ) -> Base {
        return custom(
            layoutEnvironment: environment,
            style: .list,
            header: header,
            footer: footer,
            decoration: decoration,
            edgeInsets: .card(bottom: spacing.spacing)
        )
    }
}

public extension Extendable where Base: Layout.Compositional {
    /*
     *  When inheriting `BaseCodeCollectionViewController`,
     *  use this in the controller's .layout property. Provides consistent layout for the entire list.
     */
    
    static func cardList(
        spacing: ListSpacing = .normal,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackgroundAndCornerRadius()
    ) -> Self {
        return Base { (_, environment) in
            Layout.Section.rak.cardList(
                layoutEnvironment: environment,
                spacing: spacing,
                header: header,
                footer: footer,
                decoration: decoration)
        }.rak
    }
}

public extension SectionProviderWrapper {
    /*
     *  Used in the `.layout()` method of the Data Tree.
     *  Provides a special layout for a certain Section.
     */
    
    static func cardList(
        spacing: ListSpacing = .normal,
        header: SupplementaryItem.Style? = nil,
        footer: SupplementaryItem.Style? = nil,
        decoration: DecorationStyle? = .whiteBackgroundAndCornerRadius()
    ) -> Self {
        return .init {
            Layout.Section.rak.cardList(
                layoutEnvironment: $0,
                spacing: spacing,
                header: header,
                footer: footer,
                decoration: decoration)
        }
    }
}
