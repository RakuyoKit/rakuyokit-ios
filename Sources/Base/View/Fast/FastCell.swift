//
//  FastCell.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

#if !os(watchOS)
/// A protocol used to quickly create Cells in conjunction with `FastListView`.
public protocol FastCell: UIView {
    typealias ConfigClosure = (Self) -> Void
    
    static func cell(
        of view: FastListView,
        for indexPath: IndexPath,
        identifier: String?,
        config: ConfigClosure
    ) -> Self
    
    static func xibCell(
        of view: FastListView,
        for indexPath: IndexPath,
        identifier: String?,
        config: ConfigClosure
    ) -> Self
}

// MARK: - Defaults

extension FastCell {
    public static func cell(
        of view: FastListView,
        for indexPath: IndexPath,
        identifier: String? = nil,
        config: ConfigClosure
    ) -> Self {
        createCell(of: view, for: indexPath, identifier: identifier, isCodeCell: true, config: config)
    }
    
    public static func xibCell(
        of view: FastListView,
        for indexPath: IndexPath,
        identifier: String? = nil,
        config: ConfigClosure
    ) -> Self {
        createCell(of: view, for: indexPath, identifier: identifier, isCodeCell: false, config: config)
    }
}

// MARK: - Tools

extension FastCell {
    fileprivate static func createCell(
        of listView: FastListView,
        for indexPath: IndexPath,
        identifier: String?,
        isCodeCell: Bool,
        config: ConfigClosure
    ) -> Self {
        let id = identifier ?? String(describing: Self.self)
        
        if _slowPath(!listView.registeredIdentifiers.contains(id)) {
            listView.register(Self.self, with: id, isCodeCell: isCodeCell)
            listView.registeredIdentifiers.append(id)
        }
        
        guard let cell: Self = listView.dequeueCell(with: id, for: indexPath) else {
            fatalError("Cell cannot be converted to \(Self.self) type")
        }
        
        config(cell)
        
        return cell
    }
}
#endif
