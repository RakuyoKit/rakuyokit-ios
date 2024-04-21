#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit

import Combine
import RAKCore

extension Extendable where Base: UIControl {
    public func controlEvents(_ event: UIControl.Event) -> AnyPublisher<Base, Never> {
        ControlEventsPublisher<Base>(control: base, event: event).eraseToAnyPublisher()
    }
}
#endif
