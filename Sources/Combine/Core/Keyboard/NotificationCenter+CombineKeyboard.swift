import UIKit

import Combine
import RAKCore

public extension Extendable where Base: NotificationCenter {
    typealias KeyboardPublisher = AnyPublisher<_KeyboardChangeContext, Never>
    
    var keyboardChange: KeyboardPublisher {
        keyboard(.willChangeFrame)
            .removeDuplicates { $0.endFrame == $1.endFrame }
            .eraseToAnyPublisher()
    }
    
    func keyboard(_ event: KeyboardEvent) -> KeyboardPublisher {
        return NotificationCenter.default
            .publisher(for: event.notificationName)
            .map { _KeyboardChangeContext(userInfo: $0.userInfo ?? [:], event: event) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
