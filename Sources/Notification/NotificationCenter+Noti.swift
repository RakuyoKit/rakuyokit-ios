//
//  NotificationCenter+Noti.swift
//  Noti
//
//  Created by Wang Wei on 2018/5/11.
//

import Foundation

import Combine
import RAKCore

// MARK: - Post

extension NotificationCenter {
    public func post<T: TypedNotification>(
        typedNotification notification: T,
        object: Any? = nil
    ) {
        let userInfo = notification.payload.userInfo
        post(name: T.name, object: object, userInfo: userInfo)
    }
    
    public func post<T: TypedNotification>(
        typedNotification _: T.Type,
        object: Any? = nil
    ) where T.Payload == EmptyNotificationPayload {
        post(name: T.name, object: object, userInfo: nil)
    }
}

// MARK: - Add Observer

extension NotificationCenter {
    /// Subscribe to a notification.
    public func addObserver<T: PassiveTypedNotification>(
        forType _: T.Type,
        object: Any? = nil,
        queue: OperationQueue? = nil,
        using block: @escaping (T.Payload) -> Void
    ) -> NotificationObserver {
        let token = addObserver(forName: T.name, object: object, queue: queue) { noti in
            block(T.Payload(noti))
        }
        return .init(token: token, in: self)
    }
    
    /// Subscribe to a notification when the notification does not contain any parameters.
    public func addObserver<T: PassiveTypedNotification>(
        forType _: T.Type,
        object: Any? = nil,
        queue: OperationQueue? = nil,
        using block: @escaping EmptyClosure
    ) -> NotificationObserver where T.Payload == EmptyNotificationPayload {
        let token = addObserver(forName: T.name, object: object, queue: queue) { _ in
            block()
        }
        return .init(token: token, in: self)
    }
}

// MARK: - Add Observer + Combine

extension NotificationCenter {
    public func publisher<T: PassiveTypedNotification>(
        forType _: T.Type,
        object: AnyObject? = nil
    ) -> AnyPublisher<T.Payload, Never> {
        publisher(for: T.name, object: object)
            .map { T.Payload($0) }
            .receive(on: RunLoop.main) // Default is RunLoop.main. Override if needed in other calling contexts.
            .eraseToAnyPublisher()
    }
}
