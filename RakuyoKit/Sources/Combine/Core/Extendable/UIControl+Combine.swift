#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit

import Combine
import RAKCore

public extension Extendable where Base: UIControl {
    func controlEvents(_ event: UIControl.Event) -> AnyPublisher<Base, Never> {
        return ControlEventsPublisher<Base>(control: base, event: event).eraseToAnyPublisher()
    }
}
#endif
