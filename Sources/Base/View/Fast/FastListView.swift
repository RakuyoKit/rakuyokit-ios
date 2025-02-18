//
//  FastListView.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

/// Protocol for quickly creating lists of cells, used in conjunction with `FastCell`.
public protocol FastListView: NSObjectProtocol {
    var registeredIdentifiers: [String] { get set }
    
    // The following methods are used to bridge the differences between `UITableView` and `UICollectionView`.

    #if os(visionOS)
    func register(_ cell: (some FastCell).Type, with identifier: String)
    #else
    func register(_ cell: (some FastCell).Type, with identifier: String, isCodeCell: Bool)
    #endif

    func dequeueCell<Cell: FastCell>(with identifier: String, for indexPath: IndexPath) -> Cell?
}

// MARK: - UITableView

private var tableViewKey: Void? = nil

extension UITableView: FastListView {
    public var registeredIdentifiers: [String] {
        get { (objc_getAssociatedObject(self, &collectionViewKey) as? [String]) ?? [] }
        set { objc_setAssociatedObject(self, &tableViewKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    #if !os(visionOS)
    @available(visionOS, unavailable, message: "Use `register(_: with:)` instead")
    public func register(_ cell: (some FastCell).Type, with identifier: String, isCodeCell: Bool) {
        if isCodeCell {
            register(cell, with: identifier)
        } else {
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    #endif

    public func register(_ cell: (some FastCell).Type, with identifier: String) {
        register(cell, forCellReuseIdentifier: identifier)
    }

    public func dequeueCell<Cell: FastCell>(with identifier: String, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell
    }
}

// MARK: - UICollectionView

private var collectionViewKey: Void? = nil

extension UICollectionView: FastListView {
    public var registeredIdentifiers: [String] {
        get { (objc_getAssociatedObject(self, &collectionViewKey) as? [String]) ?? [] }
        set { objc_setAssociatedObject(self, &collectionViewKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    #if !os(visionOS)
    @available(visionOS, unavailable, message: "Use `register(_: with:)` instead")
    public func register(_ cell: (some FastCell).Type, with identifier: String, isCodeCell: Bool) {
        if isCodeCell {
            register(cell, with: identifier)
        } else {
            register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
    #endif

    public func register(_ cell: (some FastCell).Type, with identifier: String) {
        register(cell, forCellWithReuseIdentifier: identifier)
    }

    public func dequeueCell<Cell: FastCell>(with identifier: String, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
    }
}
#endif
