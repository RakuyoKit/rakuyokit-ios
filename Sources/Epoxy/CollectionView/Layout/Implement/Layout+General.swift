//
//  Layout+General.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

import RAKCore

extension Extendable where Base: Layout.Section {
    /// Create a generic Section layout
    public static func create(
        layoutEnvironment _: Layout.Environment,
        style: Layout.Style,
        supplementaryItems: [SupplementaryItem] = [],
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets? = nil,
        sectionAdditionalEdgeInsets: SectionEdgeInsets? = nil
    ) -> Base {
        let item = createItem(by: style)
        let group = createGroup(by: style, item: item)
        
        return .init(group: group).then { section in
            section.decorationItems = createDecorationItems(by: decoration, edgeInsets: edgeInsets)
            section.boundarySupplementaryItems = supplementaryItems.map {
                createSupplementaryItem(with: $0)
            }

            if case .flow(_, let behavior, _, _, _) = style {
                section.orthogonalScrollingBehavior = behavior
            }
            
            let edgeInsets = edgeInsets.edgeInsets
            let additionalEdgeInsets = sectionAdditionalEdgeInsets?.edgeInsets ?? .zero
            
            section.contentInsets = .init(
                top: edgeInsets.top + additionalEdgeInsets.top,
                leading: edgeInsets.leading + additionalEdgeInsets.leading,
                bottom: edgeInsets.bottom + additionalEdgeInsets.bottom,
                trailing: edgeInsets.trailing + additionalEdgeInsets.trailing
            )
        }
    }
}

// MARK: - Public Tools

extension Extendable where Base: Layout.Section {
    public static func createSupplementaryItem(with item: SupplementaryItem) -> Layout.SupplementaryItem {
        .init(
            layoutSize: item.size,
            elementKind: item.elementKind,
            alignment: item.alignment
        )
        .then {
            $0.pinToVisibleBounds = item.style.pinToVisible
        }
    }
}

// MARK: - Internal Tools

extension Extendable where Base: Layout.Section {
    static func createSupplementaryItems(
        header: SupplementaryItem.Style?,
        footer: SupplementaryItem.Style?
    ) -> [SupplementaryItem] {
        [
            header.flatMap { .header(style: $0) },
            footer.flatMap { .footer(style: $0) },
        ]
        .compactMap { $0 }
    }
}

// MARK: - Private Tools

extension Extendable where Base: Layout.Section {
    private static func createItem(by style: Layout.Style) -> Layout.Item {
        .init(layoutSize: {
            switch style {
            case .flow(let size, _, _, _, _):
                size
                
            case .list:
                .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(50)
                )
            }
        }())
    }
    
    private static func createGroup(by style: Layout.Style, item: Layout.Item) -> Layout.Group {
        switch style {
        case .flow(let size, _, let itemContentInsets, let interItemSpacing, let customGroup):
            if let _group = customGroup?(size) { return _group }
            let flowItem = item.then {
                $0.contentInsets = itemContentInsets.directionalEdgeInsets
            }
            
            return .horizontal(
                layoutSize: .init(height: size.heightDimension),
                subitems: [flowItem]
            )
            .then { $0.interItemSpacing = interItemSpacing }
            
        case .list:
            let groupSize = Layout.Size(height: .estimated(50))
            return .vertical(layoutSize: groupSize, subitems: [item])
        }
    }

    private static func createDecorationItems(
        by decoration: DecorationStyle?,
        edgeInsets: SectionEdgeInsets?
    ) -> [NSCollectionLayoutDecorationItem] {
        guard let decoration else { return [] }
        
        let typeString =
            switch decoration {
            case .whiteBackground:
                "\(WhiteBackgroundDecorationView.self)"
                
            case .whiteBackgroundAndCornerRadius(let position):
                switch position {
                case .all:
                    "\(WhiteBackgroundAndCornerRadiusDecorationView.self)"
                case .top:
                    "\(WhiteBackgroundAndTopCornerRadiusDecorationView.self)"
                case .bottom:
                    "\(WhiteBackgroundAndBottomCornerRadiusDecorationView.self)"
                }
                
            case .grayBackground:
                "\(GrayBackgroundDecorationView.self)"
                
            case .grayBackgroundAndCornerRadius(let position):
                switch position {
                case .all:
                    "\(GrayBackgroundAndCornerRadiusDecorationView.self)"
                case .top:
                    "\(GrayBackgroundAndTopCornerRadiusDecorationView.self)"
                case .bottom:
                    "\(GrayBackgroundAndBottomCornerRadiusDecorationView.self)"
                }
                
            case .custom(let type):
                "\(type)"
            }
        
        let decorationItem = NSCollectionLayoutDecorationItem.background(
            elementKind: typeString
        )
        decorationItem.contentInsets = edgeInsets.edgeInsets
        
        return [decorationItem]
    }
}
#endif
