//
//  Bundle.swift
//  Noti
//
//  Created by 王 巍 on 2018/5/14.
//

import Foundation

// MARK: - NSBundleResourceRequestLowDiskSpaceNotification

public struct NSBundleResourceRequestLowDiskSpaceNotification: AutoPassiveTypedNotification { }

// MARK: - NSCalendarDayChangedNotification

public struct NSCalendarDayChangedNotification: AutoPassiveTypedNotification { }

// MARK: - NSDidBecomeSingleThreadedNotification

public struct NSDidBecomeSingleThreadedNotification: AutoPassiveTypedNotification { }

// MARK: - NSWillBecomeMultiThreadedNotification

public struct NSWillBecomeMultiThreadedNotification: AutoPassiveTypedNotification { }

// MARK: - NSExtensionHostNotificationPayload

public struct NSExtensionHostNotificationPayload: AutoPassiveNotificationPayload {
    // sourcery: object = true
    public let context: NSExtensionContext
}

// MARK: - NSExtensionHostDidBecomeActiveNotification

// sourcery: payload = "NSExtensionHostNotificationPayload"
public struct NSExtensionHostDidBecomeActiveNotification: AutoPassiveTypedNotification { }

// MARK: - NSExtensionHostDidEnterBackgroundNotification

// sourcery: payload = "NSExtensionHostNotificationPayload"
public struct NSExtensionHostDidEnterBackgroundNotification: AutoPassiveTypedNotification { }

// MARK: - NSExtensionHostWillEnterForegroundNotification

// sourcery: payload = "NSExtensionHostNotificationPayload"
public struct NSExtensionHostWillEnterForegroundNotification: AutoPassiveTypedNotification { }

// MARK: - NSExtensionHostWillResignActiveNotification

// sourcery: payload = "NSExtensionHostNotificationPayload"
public struct NSExtensionHostWillResignActiveNotification: AutoPassiveTypedNotification { }

// MARK: - NSFileHandleConnectionAcceptedNotification

public struct NSFileHandleConnectionAcceptedNotification: AutoPassiveTypedNotification {
    public struct Payload: PassiveNotificationPayload {
        public let sender: FileHandle
        public let nearEnd: FileHandle?
        // swiftlint:disable:next legacy_objc_type
        public let error: NSNumber?
        
        public init(_ notification: Notification) {
            // swiftlint:disable:next force_cast
            sender = notification.object as! FileHandle
            nearEnd = notification.userInfo?[NSFileHandleNotificationFileHandleItem] as? FileHandle
            // swiftlint:disable:next legacy_objc_type
            error = notification.userInfo?["NSFileHandleError"] as? NSNumber
        }
    }
}

// MARK: - NSFileHandleDataAvailableNotification

public struct NSFileHandleDataAvailableNotification: AutoPassiveTypedNotification {
    public struct Payload: AutoPassiveNotificationPayload {
        // sourcery: object = true
        public let sender: FileHandle
    }
}

// MARK: - NSFileHandleReadToEndOfFileCompletionNotification

public struct NSFileHandleReadToEndOfFileCompletionNotification: AutoPassiveTypedNotification {
    public struct Payload: PassiveNotificationPayload {
        public let sender: FileHandle
        public let data: Data?
        // swiftlint:disable:next legacy_objc_type
        public let error: NSNumber?
        
        public init(_ notification: Notification) {
            // swiftlint:disable:next force_cast
            sender = notification.object as! FileHandle
            data = notification.userInfo?[NSFileHandleNotificationDataItem] as? Data
            // swiftlint:disable:next legacy_objc_type
            error = notification.userInfo?["NSFileHandleError"] as? NSNumber
        }
    }
}

// MARK: - NSHTTPCookieManagerAcceptPolicyChangedNotification

public struct NSHTTPCookieManagerAcceptPolicyChangedNotification: AutoPassiveTypedNotification {
    public struct Payload: AutoPassiveNotificationPayload {
        // sourcery: object = true
        public let storage: HTTPCookieStorage
    }
}

// MARK: - NSHTTPCookieManagerCookiesChangedNotification

public struct NSHTTPCookieManagerCookiesChangedNotification: AutoPassiveTypedNotification {
    public struct Payload: AutoPassiveNotificationPayload {
        // sourcery: object = true
        public let storage: HTTPCookieStorage
    }
}

// MARK: - NSMetadataQueryDidFinishGatheringNotification

public struct NSMetadataQueryDidFinishGatheringNotification: AutoPassiveTypedNotification { }

// MARK: - NSMetadataQueryDidStartGatheringNotification

public struct NSMetadataQueryDidStartGatheringNotification: AutoPassiveTypedNotification { }

// MARK: - NSMetadataQueryDidUpdateNotification

public struct NSMetadataQueryDidUpdateNotification: AutoPassiveTypedNotification { }

// MARK: - NSMetadataQueryGatheringProgressNotification

public struct NSMetadataQueryGatheringProgressNotification: AutoPassiveTypedNotification { }

// MARK: - NSProcessInfoPowerStateDidChangeNotification

public struct NSProcessInfoPowerStateDidChangeNotification: AutoPassiveTypedNotification {
    public struct Payload: AutoPassiveNotificationPayload {
        // sourcery: object = true
        public let processInfo: ProcessInfo
    }
}

// MARK: - NSSystemClockDidChangeNotification

public struct NSSystemClockDidChangeNotification: AutoPassiveTypedNotification { }

// MARK: - NSSystemTimeZoneDidChangeNotification

public struct NSSystemTimeZoneDidChangeNotification: AutoPassiveTypedNotification { }

// MARK: - NSThreadWillExitNotification

public struct NSThreadWillExitNotification: AutoPassiveTypedNotification {
    public struct Payload: AutoPassiveNotificationPayload {
        // sourcery: object = true
        public let thread: Thread
    }
}

// MARK: - NSURLCredentialStorageChangedNotification

public struct NSURLCredentialStorageChangedNotification: AutoPassiveTypedNotification {
    public struct Payload: AutoPassiveNotificationPayload {
        // sourcery: object = true
        public let storage: URLCredentialStorage
    }
}

// MARK: - NSUbiquityIdentityDidChangeNotification

public struct NSUbiquityIdentityDidChangeNotification: AutoPassiveTypedNotification { }

// MARK: - UndoManagerNotificationPayload

public struct UndoManagerNotificationPayload: AutoPassiveNotificationPayload {
    // sourcery: object = true
    public let manager: UndoManager
}

// MARK: - NSUndoManagerCheckpointNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerCheckpointNotification: AutoPassiveTypedNotification { }

// MARK: - NSUndoManagerDidCloseUndoGroupNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerDidCloseUndoGroupNotification: AutoPassiveTypedNotification { }

// MARK: - NSUndoManagerDidOpenUndoGroupNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerDidOpenUndoGroupNotification: AutoPassiveTypedNotification { }

// MARK: - NSUndoManagerDidRedoChangeNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerDidRedoChangeNotification: AutoPassiveTypedNotification { }

// MARK: - NSUndoManagerDidUndoChangeNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerDidUndoChangeNotification: AutoPassiveTypedNotification { }

// MARK: - NSUndoManagerWillCloseUndoGroupNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerWillCloseUndoGroupNotification: AutoPassiveTypedNotification { }

// MARK: - NSUndoManagerWillRedoChangeNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerWillRedoChangeNotification: AutoPassiveTypedNotification { }

// MARK: - NSUndoManagerWillUndoChangeNotification

// sourcery: payload = "UndoManagerNotificationPayload"
public struct NSUndoManagerWillUndoChangeNotification: AutoPassiveTypedNotification { }
