//
//  DispatchQueue+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

extension Extendable where Base: DispatchQueue {
    public typealias DispatchTask = (_ canceled: Bool) -> Void

    /// Create a deferred task that can be canceled midway using the `cancel()` method.
    ///
    /// - Parameters:
    ///   - time: Delay duration. Internal `.now() + time`
    ///   - task: Tasks to be performed after the time is reached. Will be executed on the main thread
    /// - Returns: Action to cancel execution
    @discardableResult
    public static func after(
        _ time: DispatchTimeInterval,
        execute task: @escaping EmptyClosure
    ) -> DispatchTask? {
        func _after(block: @escaping EmptyClosure) {
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: block)
        }

        var taskAction: EmptyClosure? = task
        var result: DispatchTask?

        let delayedClosure: DispatchTask = { canceled in
            if let action = taskAction, !canceled {
                DispatchQueue.main.async(execute: action)
            }
            taskAction = nil
            result = nil
        }

        result = delayedClosure

        _after { result?(false) }

        return result
    }
    
    /// Cancel delayed tasks
    ///
    /// - Parameter task: Task to be canceled
    public static func cancel(_ task: DispatchTask?) {
        task?(true)
    }
}
