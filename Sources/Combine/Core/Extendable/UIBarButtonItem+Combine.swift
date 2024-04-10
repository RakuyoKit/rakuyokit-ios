#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit

import Combine
import RAKCore

public extension Extendable where Base: UIBarButtonItem {
    func controlTarget() -> AnyPublisher<Base, Never> {
        return ControlTargetPublisher(
            control: base,
            addTargetAction: { (control, target, action) in
                control.target = target
                control.action = action
            }, removeTargetAction: { (control, _, _) in
                control?.target = nil
                control?.action = nil
            })
        .eraseToAnyPublisher()
    }
}
#endif
