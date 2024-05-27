//
//  ButtonImageContentProviding.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - ButtonImageContentProviding

/// Provider that can provide image for ``ButtonRow``
public protocol ButtonImageContentProviding: Equatable {
    func setForView<V>(_ view: V?, state: UIControl.State)
}

// MARK: - UIImage + ButtonImageContentProviding

extension UIImage: ButtonImageContentProviding {
    public func setForView<V>(_ view: V?, state: UIControl.State) {
        guard let view else { return }

        if let button = view as? UIButton {
            button.setImage(self, for: state)
        } else {
            assertionFailure("UIImage.setForView(_:state:) has no implementation for the \(type(of: view)) type")
        }
    }
}

// MARK: - String + ButtonImageContentProviding

extension String: ButtonImageContentProviding {
    public func setForView<V>(_ view: V?, state: UIControl.State) {
        guard let view else { return }
        
        if let button = view as? UIButton {
            button.setImage(.init(named: self), for: state)
        } else {
            assertionFailure("String.setForView(_:state:) has no implementation for the \(type(of: view)) type")
        }
    }
}
