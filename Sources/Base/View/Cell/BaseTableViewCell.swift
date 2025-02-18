//
//  BaseTableViewCell.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

@objc(RAKBaseTableViewCell)
open class BaseTableViewCell: UITableViewCell {
    public typealias View = UITableView
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        config(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        config(style: .default, reuseIdentifier: "\(Self.self)")
    }
}

extension BaseTableViewCell {
    @objc
    open func config(style _: UITableViewCell.CellStyle, reuseIdentifier _: String?) {
        selectionStyle = .none
        
        addSubviews()
        addInitialLayout()
    }
    
    @objc
    open func addSubviews() { }
    
    @objc
    open func addInitialLayout() { }
}
#endif
