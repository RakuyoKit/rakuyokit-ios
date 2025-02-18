//
//  ImageContentProviding.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

// MARK: - ImageContentProviding

/// Provider that can provide content for ``ImageRow``
public protocol ImageContentProviding: Equatable {
    func setForView<V>(_ view: V?)
}

// MARK: - UIImage + ImageContentProviding

extension UIImage: ImageContentProviding {
    public func setForView<V>(_ view: V?) {
        guard let view else { return }

        if let _view = view as? UIImageView {
            _view.image = self
        } else {
            assertionFailure("UIImage.setForView(_:) has no implementation for the \(type(of: view)) type")
        }
    }
}

// MARK: - String + ImageContentProviding

extension String: ImageContentProviding {
    public func setForView<V>(_ view: V?) {
        guard let view else { return }

        if let _view = view as? UIImageView {
            _view.image = .init(named: self)
        } else {
            assertionFailure("String.setForView(_:) has no implementation for the \(type(of: view)) type")
        }
    }
}
#endif
