import UIKit

// swiftlint:disable type_name
/// The context of an upcoming change in the frame of the system keyboard.
public struct _KeyboardChangeContext {
    // swiftlint:enable type_name
    
    private let base: [AnyHashable: Any]
    
    /// The event type of the system keyboard.
    public let event: KeyboardEvent
    
    /// The current frame of the system keyboard.
    public var beginFrame: CGRect {
        // swiftlint:disable:next force_cast
        base[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
    }
    
    /// The final frame of the system keyboard.
    public var endFrame: CGRect {
        // swiftlint:disable:next force_cast
        base[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    }
    
    /// The animation curve which the system keyboard will use to animate the
    /// change in its frame.
    public var animationCurve: UIView.AnimationCurve {
        // swiftlint:disable force_unwrapping
        // swiftlint:disable:next force_cast legacy_objc_type
        let value = base[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
        return UIView.AnimationCurve(rawValue: value.intValue)!
        // swiftlint:enable force_unwrapping
    }
    
    /// The duration in which the system keyboard expects to animate the change in
    /// its frame.
    public var animationDuration: Double {
        // swiftlint:disable:next force_cast
        base[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    }
    
    /// Indicates whether the change is triggered locally. Used in iPad
    /// multitasking, where all foreground apps would be notified of any changes
    /// in the system keyboard's frame.
    @available(iOS 9.0, *)
    public var isLocal: Bool {
        // swiftlint:disable:next force_cast
        base[UIResponder.keyboardIsLocalUserInfoKey] as! Bool
    }
    
    init(userInfo: [AnyHashable: Any], event: KeyboardEvent) {
        base = userInfo
        self.event = event
    }
}
