//
//  FastCell.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

/// A protocol used to quickly create Cells in conjunction with `FastListView`.
public protocol FastCell: UIView {
    typealias ConfigClosure = (Self) -> Void
    
    static func cell(
        of view: FastListView,
        for indexPath: IndexPath,
        identifier: String?,
        config: ConfigClosure
    ) -> Self
    
    #if !os(visionOS)
    static func xibCell(
        of view: FastListView,
        for indexPath: IndexPath,
        identifier: String?,
        config: ConfigClosure
    ) -> Self
    #endif
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
    
    #if !os(visionOS)
    public static func xibCell(
        of view: FastListView,
        for indexPath: IndexPath,
        identifier: String? = nil,
        config: ConfigClosure
    ) -> Self {
        createCell(of: view, for: indexPath, identifier: identifier, isCodeCell: false, config: config)
    }
    #endif
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
            #if os(visionOS)
            listView.register(Self.self, with: id)
            #else
            listView.register(Self.self, with: id, isCodeCell: isCodeCell)
            #endif

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
