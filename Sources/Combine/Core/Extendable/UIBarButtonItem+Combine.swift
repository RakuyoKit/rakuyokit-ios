#if !os(watchOS)
import UIKit

import Combine
import RAKCore

extension Extendable where Base: UIBarButtonItem {
    public func controlTarget() -> AnyPublisher<Base, Never> {
        ControlTargetPublisher(
            control: base,
            addTargetAction: { control, target, action in
                control.target = target
                control.action = action
            }, removeTargetAction: { control, _, _ in
                control?.target = nil
                control?.action = nil
            }
        )
        .eraseToAnyPublisher()
    }
}
#endif
