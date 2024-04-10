//
//  TypedNotification.swift
//  Noti
//
//  Created by Wang Wei on 2018/5/11.
//

import Foundation

public protocol PassiveTypedNotification {
    associatedtype Payload: PassiveNotificationPayload
    
    static var name: Notification.Name { get }
}

public extension PassiveTypedNotification {
    static var name: Notification.Name {
        .init(rawValue: String(reflecting: Self.self))
    }
}

public protocol TypedNotification: PassiveTypedNotification where Payload: NotificationPayload {
    var payload: Payload { get }
}

public protocol EmptyPayloadPassiveTypedNotification: PassiveTypedNotification
    where Payload == EmptyNotificationPayload { }

public protocol EmptyPayloadTypedNotification: TypedNotification where Payload == EmptyNotificationPayload { }
public extension EmptyPayloadTypedNotification {
    var payload: Payload { .empty }
}

// For auto generating of notification
public protocol AutoPassiveTypedNotification { }
