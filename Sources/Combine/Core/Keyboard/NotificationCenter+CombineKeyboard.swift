#if !os(watchOS)
import UIKit

import Combine
import RAKCore

extension Extendable where Base: NotificationCenter {
    public typealias KeyboardPublisher = AnyPublisher<_KeyboardChangeContext, Never>
    
    public var keyboardChange: KeyboardPublisher {
        keyboard(.willChangeFrame)
            .removeDuplicates { $0.endFrame == $1.endFrame }
            .eraseToAnyPublisher()
    }
    
    public func keyboard(_ event: KeyboardEvent) -> KeyboardPublisher {
        NotificationCenter.default
            .publisher(for: event.notificationName)
            .map { _KeyboardChangeContext(userInfo: $0.userInfo ?? [:], event: event) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
#endif
