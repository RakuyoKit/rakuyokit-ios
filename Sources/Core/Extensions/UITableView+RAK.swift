//
//  UITableView+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/7/8.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension Extendable where Base: UITableView {
    public func deselectRowIfNeeded(
        with transitionCoordinator: UIViewControllerTransitionCoordinator? = nil,
        animated: Bool = true,
        after deadline: DispatchTime? = nil
    ) {
        if let deadline {
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                deselectRowIfNeeded(with: transitionCoordinator, animated: animated)
            }
        } else {
            deselectRowIfNeeded(with: transitionCoordinator, animated: animated)
        }
    }

    private func deselectRowIfNeeded(
        with transitionCoordinator: UIViewControllerTransitionCoordinator?,
        animated: Bool
    ) {
        guard let selectedIndexPath = base.indexPathForSelectedRow else { return }

        guard let coordinator = transitionCoordinator else {
            base.deselectRow(at: selectedIndexPath, animated: animated)
            return
        }

        coordinator.animate(
            alongsideTransition: { [weak base] _ in
                base?.deselectRow(at: selectedIndexPath, animated: true)
            },
            completion: { [weak base] context in
                guard context.isCancelled else { return }
                base?.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
            }
        )
    }
}
#endif
