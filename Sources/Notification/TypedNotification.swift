//
//  TypedNotification.swift
//  Noti
//
//  Created by Wang Wei on 2018/5/11.
//

import Foundation

// MARK: - PassiveTypedNotification

public protocol PassiveTypedNotification {
    associatedtype Payload: PassiveNotificationPayload
    
    static var name: Notification.Name { get }
}

extension PassiveTypedNotification {
    public static var name: Notification.Name {
        .init(rawValue: String(reflecting: Self.self))
    }
}

// MARK: - TypedNotification

public protocol TypedNotification: PassiveTypedNotification where Payload: NotificationPayload {
    var payload: Payload { get }
}

// MARK: - EmptyPayloadPassiveTypedNotification

public protocol EmptyPayloadPassiveTypedNotification: PassiveTypedNotification
    where Payload == EmptyNotificationPayload { }

// MARK: - EmptyPayloadTypedNotification

public protocol EmptyPayloadTypedNotification: TypedNotification where Payload == EmptyNotificationPayload { }
extension EmptyPayloadTypedNotification {
    public var payload: Payload { .empty }
}

// MARK: - AutoPassiveTypedNotification

/// For auto generating of notification
public protocol AutoPassiveTypedNotification { }
