//
//  BaseDecorationView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)
import UIKit

// MARK: - BaseDecorationView

open class BaseDecorationView: UICollectionReusableView {
    open var decorationViewConfig: DecorationViewConfig { .init() }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        config()
    }
    
    open func config() {
        if let backgroundColor = decorationViewConfig.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let cornerRadius = decorationViewConfig.cornerRadius {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = decorationViewConfig.maskedCorners
            layer.masksToBounds = true
        }
    }
}
#endif
