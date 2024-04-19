//
//  NotificationPayload.swift
//  Noti
//
//  Created by Wang Wei on 2018/5/11.
//

import Foundation

private let payloadEncoder = JSONEncoder()
private let payloadDecoder = JSONDecoder()

// MARK: - PassiveNotificationPayload

public protocol PassiveNotificationPayload {
    init(_ notification: Notification)
}

// MARK: - NotificationPayload

public protocol NotificationPayload: PassiveNotificationPayload {
    var userInfo: [AnyHashable: Any] { get }
}

extension NotificationPayload where Self: Decodable {
    public init(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            fatalError("""
                [Noti] Received a `nil` userInfo. Maybe you are sending a customized notification with untyped API.
                Please send typed notifications with Noti APIs instead of plain Cocoa APIs.
                """)
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: userInfo, options: [])
            self = try payloadDecoder.decode(Self.self, from: data)
        } catch {
            fatalError("[Noti] Trying to decode a notification but something wrong happens: \(error)")
        }
    }
}

extension NotificationPayload where Self: Encodable {
    public var userInfo: [AnyHashable: Any] {
        // swiftlint:disable force_cast force_try
        let data = try! payloadEncoder.encode(self)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyHashable: Any]
        // swiftlint:enable force_cast force_try
    }
}

// MARK: - EmptyNotificationPayload

public struct EmptyNotificationPayload: NotificationPayload {
    static let empty = Self()
    
    public var userInfo: [AnyHashable: Any] { [:] }
    
    public init(_: Notification) { }
    
    private init() { }
}

extension Notification {
    public func extract<T>(key: String, type _: T.Type) -> T {
        // swiftlint:disable:next force_cast force_unwrapping
        userInfo![key] as! T
    }
    
    public func extract<T, U>(key: String, type: T.Type, transform: (T) -> U) -> U {
        let value = extract(key: key, type: type)
        return transform(value)
    }
}

// MARK: - AutoPassiveNotificationPayload

/// For auto generating of payload
public protocol AutoPassiveNotificationPayload { }
