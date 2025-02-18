//
//  BaseCollectionViewCell.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

@objc(RAKBaseCollectionViewCell)
open class BaseCollectionViewCell: UICollectionViewCell {
    public typealias View = UICollectionView
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        config()
    }
}

extension BaseCollectionViewCell {
    @objc
    open func config() {
        addSubviews()
        addInitialLayout()
    }
    
    @objc
    open func addSubviews() { }
    
    @objc
    open func addInitialLayout() { }
}
#endif
