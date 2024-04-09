// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation

extension NSExtensionHostNotificationPayload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        context = notification.object as! NSExtensionContext
    }
}

extension NSFileHandleDataAvailableNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        sender = notification.object as! FileHandle
    }
}

extension NSHTTPCookieManagerAcceptPolicyChangedNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        storage = notification.object as! HTTPCookieStorage
    }
}

extension NSHTTPCookieManagerCookiesChangedNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        storage = notification.object as! HTTPCookieStorage
    }
}

extension NSProcessInfoPowerStateDidChangeNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        processInfo = notification.object as! ProcessInfo
    }
}

extension NSThreadWillExitNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        thread = notification.object as! Thread
    }
}

extension NSURLCredentialStorageChangedNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        storage = notification.object as! URLCredentialStorage
    }
}

extension UndoManagerNotificationPayload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        manager = notification.object as! UndoManager
    }
}
