import UIKit

/// The type of system keyboard events.
public enum KeyboardEvent {
    // swiftlint:disable sorted_enum_cases
    case willShow
    case didShow
    case willHide
    case didHide
    case willChangeFrame
    case didChangeFrame
    // swiftlint:enable sorted_enum_cases
    
    /// The name of the notification to observe system keyboard events.
    var notificationName: Notification.Name {
        switch self {
        case .willShow: return UIResponder.keyboardWillShowNotification
        case .didShow: return UIResponder.keyboardDidShowNotification
        case .willHide: return UIResponder.keyboardWillHideNotification
        case .didHide: return UIResponder.keyboardDidHideNotification
        case .willChangeFrame: return UIResponder.keyboardWillChangeFrameNotification
        case .didChangeFrame: return UIResponder.keyboardDidChangeFrameNotification
        }
    }
}
