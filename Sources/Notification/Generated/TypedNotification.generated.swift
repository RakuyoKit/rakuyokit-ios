// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation

// MARK: - NSBundleResourceRequestLowDiskSpaceNotification + EmptyPayloadPassiveTypedNotification

extension NSBundleResourceRequestLowDiskSpaceNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSBundleResourceRequestLowDiskSpace
}

// MARK: - NSCalendarDayChangedNotification + EmptyPayloadPassiveTypedNotification

extension NSCalendarDayChangedNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSCalendarDayChanged
}

// MARK: - NSDidBecomeSingleThreadedNotification + EmptyPayloadPassiveTypedNotification

extension NSDidBecomeSingleThreadedNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSDidBecomeSingleThreaded
}

// MARK: - NSExtensionHostDidBecomeActiveNotification + PassiveTypedNotification

extension NSExtensionHostDidBecomeActiveNotification: PassiveTypedNotification {
    public typealias Payload = NSExtensionHostNotificationPayload
    public static let name: Notification.Name = .NSExtensionHostDidBecomeActive
}

// MARK: - NSExtensionHostDidEnterBackgroundNotification + PassiveTypedNotification

extension NSExtensionHostDidEnterBackgroundNotification: PassiveTypedNotification {
    public typealias Payload = NSExtensionHostNotificationPayload
    public static let name: Notification.Name = .NSExtensionHostDidEnterBackground
}

// MARK: - NSExtensionHostWillEnterForegroundNotification + PassiveTypedNotification

extension NSExtensionHostWillEnterForegroundNotification: PassiveTypedNotification {
    public typealias Payload = NSExtensionHostNotificationPayload
    public static let name: Notification.Name = .NSExtensionHostWillEnterForeground
}

// MARK: - NSExtensionHostWillResignActiveNotification + PassiveTypedNotification

extension NSExtensionHostWillResignActiveNotification: PassiveTypedNotification {
    public typealias Payload = NSExtensionHostNotificationPayload
    public static let name: Notification.Name = .NSExtensionHostWillResignActive
}

// MARK: - NSFileHandleConnectionAcceptedNotification + PassiveTypedNotification

extension NSFileHandleConnectionAcceptedNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSFileHandleConnectionAccepted
}

// MARK: - NSFileHandleDataAvailableNotification + PassiveTypedNotification

extension NSFileHandleDataAvailableNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSFileHandleDataAvailable
}

// MARK: - NSFileHandleReadToEndOfFileCompletionNotification + PassiveTypedNotification

extension NSFileHandleReadToEndOfFileCompletionNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSFileHandleReadToEndOfFileCompletion
}

// MARK: - NSHTTPCookieManagerAcceptPolicyChangedNotification + PassiveTypedNotification

extension NSHTTPCookieManagerAcceptPolicyChangedNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSHTTPCookieManagerAcceptPolicyChanged
}

// MARK: - NSHTTPCookieManagerCookiesChangedNotification + PassiveTypedNotification

extension NSHTTPCookieManagerCookiesChangedNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSHTTPCookieManagerCookiesChanged
}

// MARK: - NSMetadataQueryDidFinishGatheringNotification + EmptyPayloadPassiveTypedNotification

extension NSMetadataQueryDidFinishGatheringNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSMetadataQueryDidFinishGathering
}

// MARK: - NSMetadataQueryDidStartGatheringNotification + EmptyPayloadPassiveTypedNotification

extension NSMetadataQueryDidStartGatheringNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSMetadataQueryDidStartGathering
}

// MARK: - NSMetadataQueryDidUpdateNotification + EmptyPayloadPassiveTypedNotification

extension NSMetadataQueryDidUpdateNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSMetadataQueryDidUpdate
}

// MARK: - NSMetadataQueryGatheringProgressNotification + EmptyPayloadPassiveTypedNotification

extension NSMetadataQueryGatheringProgressNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSMetadataQueryGatheringProgress
}

// MARK: - NSProcessInfoPowerStateDidChangeNotification + PassiveTypedNotification

extension NSProcessInfoPowerStateDidChangeNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSProcessInfoPowerStateDidChange
}

// MARK: - NSSystemClockDidChangeNotification + EmptyPayloadPassiveTypedNotification

extension NSSystemClockDidChangeNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSSystemClockDidChange
}

// MARK: - NSSystemTimeZoneDidChangeNotification + EmptyPayloadPassiveTypedNotification

extension NSSystemTimeZoneDidChangeNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSSystemTimeZoneDidChange
}

// MARK: - NSThreadWillExitNotification + PassiveTypedNotification

extension NSThreadWillExitNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSThreadWillExit
}

// MARK: - NSURLCredentialStorageChangedNotification + PassiveTypedNotification

extension NSURLCredentialStorageChangedNotification: PassiveTypedNotification {
    public static let name: Notification.Name = .NSURLCredentialStorageChanged
}

// MARK: - NSUbiquityIdentityDidChangeNotification + EmptyPayloadPassiveTypedNotification

extension NSUbiquityIdentityDidChangeNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSUbiquityIdentityDidChange
}

// MARK: - NSUndoManagerCheckpointNotification + PassiveTypedNotification

extension NSUndoManagerCheckpointNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerCheckpoint
}

// MARK: - NSUndoManagerDidCloseUndoGroupNotification + PassiveTypedNotification

extension NSUndoManagerDidCloseUndoGroupNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerDidCloseUndoGroup
}

// MARK: - NSUndoManagerDidOpenUndoGroupNotification + PassiveTypedNotification

extension NSUndoManagerDidOpenUndoGroupNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerDidOpenUndoGroup
}

// MARK: - NSUndoManagerDidRedoChangeNotification + PassiveTypedNotification

extension NSUndoManagerDidRedoChangeNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerDidRedoChange
}

// MARK: - NSUndoManagerDidUndoChangeNotification + PassiveTypedNotification

extension NSUndoManagerDidUndoChangeNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerDidUndoChange
}

// MARK: - NSUndoManagerWillCloseUndoGroupNotification + PassiveTypedNotification

extension NSUndoManagerWillCloseUndoGroupNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerWillCloseUndoGroup
}

// MARK: - NSUndoManagerWillRedoChangeNotification + PassiveTypedNotification

extension NSUndoManagerWillRedoChangeNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerWillRedoChange
}

// MARK: - NSUndoManagerWillUndoChangeNotification + PassiveTypedNotification

extension NSUndoManagerWillUndoChangeNotification: PassiveTypedNotification {
    public typealias Payload = UndoManagerNotificationPayload
    public static let name: Notification.Name = .NSUndoManagerWillUndoChange
}

// MARK: - NSWillBecomeMultiThreadedNotification + EmptyPayloadPassiveTypedNotification

extension NSWillBecomeMultiThreadedNotification: EmptyPayloadPassiveTypedNotification {
    public static let name: Notification.Name = .NSWillBecomeMultiThreaded
}
