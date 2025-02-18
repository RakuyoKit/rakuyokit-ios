//
//  UIViewController+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension Extendable where Base: UIViewController {
    @available(iOSApplicationExtension, unavailable)
    public func hideKeyboard() {
        UIApplication.shared.rak.keyWindow?.endEditing(true)
    }

    public func addChild(_ childController: UIViewController, toView: UIView) {
        base.addChild(childController)
        childController.beginAppearanceTransition(true, animated: false)

        if let stackView = toView as? UIStackView {
            stackView.addArrangedSubview(childController.view)
        } else {
            toView.addSubview(childController.view)
        }

        childController.endAppearanceTransition()
        childController.didMove(toParent: base)
    }
}
#endif
