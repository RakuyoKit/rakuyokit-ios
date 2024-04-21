// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation

// MARK: - NSExtensionHostNotificationPayload + PassiveNotificationPayload

extension NSExtensionHostNotificationPayload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        context = notification.object as! NSExtensionContext
    }
}

// MARK: - NSFileHandleDataAvailableNotification.Payload + PassiveNotificationPayload

extension NSFileHandleDataAvailableNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        sender = notification.object as! FileHandle
    }
}

// MARK: - NSHTTPCookieManagerAcceptPolicyChangedNotification.Payload + PassiveNotificationPayload

extension NSHTTPCookieManagerAcceptPolicyChangedNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        storage = notification.object as! HTTPCookieStorage
    }
}

// MARK: - NSHTTPCookieManagerCookiesChangedNotification.Payload + PassiveNotificationPayload

extension NSHTTPCookieManagerCookiesChangedNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        storage = notification.object as! HTTPCookieStorage
    }
}

// MARK: - NSProcessInfoPowerStateDidChangeNotification.Payload + PassiveNotificationPayload

extension NSProcessInfoPowerStateDidChangeNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        processInfo = notification.object as! ProcessInfo
    }
}

// MARK: - NSThreadWillExitNotification.Payload + PassiveNotificationPayload

extension NSThreadWillExitNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        thread = notification.object as! Thread
    }
}

// MARK: - NSURLCredentialStorageChangedNotification.Payload + PassiveNotificationPayload

extension NSURLCredentialStorageChangedNotification.Payload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        storage = notification.object as! URLCredentialStorage
    }
}

// MARK: - UndoManagerNotificationPayload + PassiveNotificationPayload

extension UndoManagerNotificationPayload: PassiveNotificationPayload {
    public init(_ notification: Notification) {
        // swiftlint:disable:next force_cast
        manager = notification.object as! UndoManager
    }
}
