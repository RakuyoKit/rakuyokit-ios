//
//  NotificationPayload.swift
//  Noti
//
//  Created by Wang Wei on 2018/5/11.
//

import Foundation

private let payloadEncoder = JSONEncoder()
private let payloadDecoder = JSONDecoder()

public protocol PassiveNotificationPayload {
    init(_ notification: Notification)
}

public protocol NotificationPayload: PassiveNotificationPayload {
    var userInfo: [AnyHashable: Any] { get }
}

public extension NotificationPayload where Self: Decodable {
    init(_ notification: Notification) {
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

public extension NotificationPayload where Self: Encodable {
    var userInfo: [AnyHashable: Any] {
        // swiftlint:disable force_cast force_try
        let data = try! payloadEncoder.encode(self)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyHashable: Any]
        // swiftlint:enable force_cast force_try
    }
}

public struct EmptyNotificationPayload: NotificationPayload {
    static let empty = Self()
    
    public var userInfo: [AnyHashable: Any] { [:] }
    
    public init(_ notification: Notification) { }
    
    private init() { }
}

public extension Notification {
    func extract<T>(key: String, type: T.Type) -> T {
        // swiftlint:disable:next force_cast force_unwrapping
        return userInfo![key] as! T
    }
    
    func extract<T, U>(key: String, type: T.Type, transform: (T) -> U) -> U {
        let value = extract(key: key, type: type)
        return transform(value)
    }
}

// For auto generating of payload
public protocol AutoPassiveNotificationPayload { }
