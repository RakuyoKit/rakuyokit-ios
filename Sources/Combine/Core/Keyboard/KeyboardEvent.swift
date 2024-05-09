#if !os(watchOS)
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
        case .willShow: UIResponder.keyboardWillShowNotification
        case .didShow: UIResponder.keyboardDidShowNotification
        case .willHide: UIResponder.keyboardWillHideNotification
        case .didHide: UIResponder.keyboardDidHideNotification
        case .willChangeFrame: UIResponder.keyboardWillChangeFrameNotification
        case .didChangeFrame: UIResponder.keyboardDidChangeFrameNotification
        }
    }
}
#endif
