//
//  FastListView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

#if !os(watchOS)
/// Protocol for quickly creating lists of cells, used in conjunction with `FastCell`.
public protocol FastListView: NSObjectProtocol {
    var registeredIdentifiers: [String] { get set }
    
    /* The following methods are used to bridge the differences between `UITableView` and `UICollectionView`. */

    func register(_ cell: (some FastCell).Type, with identifier: String, isCodeCell: Bool)
    
    func dequeueCell<Cell: FastCell>(with identifier: String, for indexPath: IndexPath) -> Cell?
}

// MARK: - UITableView

private var tableViewKey: Void?

extension UITableView: FastListView {
    public var registeredIdentifiers: [String] {
        get { (objc_getAssociatedObject(self, &collectionViewKey) as? [String]) ?? [] }
        set { objc_setAssociatedObject(self, &tableViewKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    public func register(_ cell: (some FastCell).Type, with identifier: String, isCodeCell: Bool) {
        if isCodeCell {
            register(cell, forCellReuseIdentifier: identifier)
        } else {
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    public func dequeueCell<Cell: FastCell>(with identifier: String, for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell
    }
}

// MARK: - UICollectionView

private var collectionViewKey: Void?

extension UICollectionView: FastListView {
    public var registeredIdentifiers: [String] {
        get { (objc_getAssociatedObject(self, &collectionViewKey) as? [String]) ?? [] }
        set { objc_setAssociatedObject(self, &collectionViewKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    public func register(_ cell: (some FastCell).Type, with identifier: String, isCodeCell: Bool) {
        if isCodeCell {
            register(cell, forCellWithReuseIdentifier: identifier)
        } else {
            register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
    
    public func dequeueCell<Cell: FastCell>(with identifier: String, for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
    }
}
#endif
