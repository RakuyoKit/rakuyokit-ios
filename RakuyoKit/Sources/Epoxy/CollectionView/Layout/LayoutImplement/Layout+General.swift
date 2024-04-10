//
//  Layout+General.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import RAKCore

public extension Extendable where Base: Layout.Section {
    /// Create a generic Section layout
    static func create(
        layoutEnvironment: Layout.Environment,
        style: Layout.Style,
        supplementaryItem: SupplementaryItem? = nil,
        decoration: DecorationStyle? = nil,
        edgeInsets: SectionEdgeInsets? = nil
    ) -> Base {
        let item = createItem(by: style)
        let group = createGroup(by: style, item: item)
        
        return .init(group: group).then { (section) in
            section.contentInsets = edgeInsets.edgeInsets
            section.boundarySupplementaryItems = createBoundarySupplementaryItems(by: supplementaryItem)
            
            if case .flow(_, let behavior, _) = style {
                section.orthogonalScrollingBehavior = behavior
            }
            
            let decorationItems = createDecorationItems(by: decoration, edgeInsets: edgeInsets)
            if decorationItems.isNotEmpty {
                section.decorationItems = decorationItems
            }
        }
    }
}

// MARK: - Public Tools

public extension Extendable where Base: Layout.Section {
    static func createSectionHeader(
        pinToVisible isPin: Bool
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        return createSupplementaryItem(
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            pinToVisible: isPin)
    }
    
    static func createSectionFooter(
        pinToVisible isPin: Bool
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        return createSupplementaryItem(
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom,
            pinToVisible: isPin)
    }
}

// MARK: - Private Tools

private extension Extendable where Base: Layout.Section {
    static func createItem(by style: Layout.Style) -> Layout.Item {
        return .init(layoutSize: {
            switch style {
            case .flow(let size, _, _):
                return size
                
            case .list:
                return .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(50)
                )
            }
        }())
    }
    
    static func createGroup(by style: Layout.Style, item: Layout.Item) -> Layout.Group {
        let groupSize: Layout.Size = .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
        
        switch style {
        case let .flow(size, _, customGroup):
            if let _group = customGroup?(size) { return _group }
            return .horizontal(layoutSize: groupSize, subitems: [item])
            
        case .list:
            return .vertical(layoutSize: groupSize, subitems: [item])
        }
    }
    
    static func createBoundarySupplementaryItems(
        by supplementaryItem: SupplementaryItem?
    ) -> [NSCollectionLayoutBoundarySupplementaryItem] {
        guard let supplementaryItem = supplementaryItem else { return [] }
        
        var result: [NSCollectionLayoutBoundarySupplementaryItem] = []
        
        if let header = supplementaryItem.header {
            switch header {
            case .normal:
                result.append(createSectionHeader(pinToVisible: false))
            case .pin:
                result.append(createSectionHeader(pinToVisible: true))
            }
        }
        
        if let footer = supplementaryItem.footer {
            switch footer {
            case .normal:
                result.append(createSectionFooter(pinToVisible: false))
            case .pin:
                result.append(createSectionFooter(pinToVisible: true))
            }
        }
        
        return result
    }
    
    static func createDecorationItems(
        by decoration: DecorationStyle?,
        edgeInsets: SectionEdgeInsets?
    ) -> [NSCollectionLayoutDecorationItem] {
        guard let decoration = decoration else { return [] }
        
        let typeString: String = {
            switch decoration {
            case .whiteBackground:
                return "\(WhiteBackgroundDecorationView.self)"
                
            case .whiteBackgroundAndCornerRadius(let position):
                switch position {
                case .all:
                    return "\(WhiteBackgroundAndCornerRadiusDecorationView.self)"
                case .top:
                    return "\(WhiteBackgroundAndTopCornerRadiusDecorationView.self)"
                case .bottom:
                    return "\(WhiteBackgroundAndBottomCornerRadiusDecorationView.self)"
                }
                
            case .custom(let type):
                return "\(type)"
            }
        }()
        
        let decorationItem = NSCollectionLayoutDecorationItem.background(
            elementKind: typeString
        )
        decorationItem.contentInsets = edgeInsets.edgeInsets
        
        return [decorationItem]
    }
    
    static func createSupplementaryItem(
        elementKind: String,
        alignment: NSRectAlignment,
        pinToVisible isPin: Bool
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(50)),
            elementKind: elementKind,
            alignment: alignment
        )
        .then {
            $0.pinToVisibleBounds = isPin
        }
    }
}
