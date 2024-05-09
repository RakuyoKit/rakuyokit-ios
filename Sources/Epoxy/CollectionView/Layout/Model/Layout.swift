//
//  Layout.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

/// Used to define some content
public enum Layout {
    public typealias Environment = NSCollectionLayoutEnvironment
    
    public typealias Size = NSCollectionLayoutSize
    
    public typealias Dimension = NSCollectionLayoutDimension
    
    public typealias Compositional = UICollectionViewCompositionalLayout
    
    public typealias Item = NSCollectionLayoutItem
    
    public typealias Section = NSCollectionLayoutSection
    
    public typealias ScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior
    
    public typealias Group = NSCollectionLayoutGroup
    
    public typealias CustomGroupFactory = (_ itemSize: Size) -> Group
    
    /// Styles
    public enum Style {
        /// Similar to the flow layout of the past CollectionView
        case flow(
            itemSize: Size,
            scrollingBehavior: ScrollingBehavior = .none,
            customGroup: CustomGroupFactory? = nil
        )
        
        /// Similar to the vertical list layout of UITableView
        case list
    }
}
#endif
