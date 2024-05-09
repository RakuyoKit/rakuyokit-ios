#if !os(watchOS)
import UIKit

import Combine

public struct ControlPropertyPublisher<Control: UIControl, Value>: Publisher {
    public typealias Output = Value
    public typealias Failure = Never
    
    private let control: Control
    private let controlEvents: Control.Event
    private let keyPath: KeyPath<Control, Value>
    
    public init(
        control: Control,
        events: Control.Event,
        keyPath: KeyPath<Control, Value>
    ) {
        self.control = control
        controlEvents = events
        self.keyPath = keyPath
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(
            subscriber: subscriber,
            control: control,
            event: controlEvents,
            keyPath: keyPath
        )
        subscriber.receive(subscription: subscription)
    }
}

extension ControlPropertyPublisher {
    private final class Subscription<S: Subscriber, C: UIControl, V>: Combine.Subscription where S.Input == V {
        let keyPath: KeyPath<C, V>
        
        private var subscriber: S?
        private var control: C?
        
        private var didEmitInitial = false
        private let event: C.Event
        
        init(subscriber: S, control: C, event: C.Event, keyPath: KeyPath<C, V>) {
            self.subscriber = subscriber
            self.control = control
            self.keyPath = keyPath
            self.event = event
            control.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {
            // 在第一次需求请求时发出初始值
            if
                !didEmitInitial,
                demand > .none,
                let control,
                let subscriber
            {
                _ = subscriber.receive(control[keyPath: keyPath])
                didEmitInitial = true
            }
        }
        
        func cancel() {
            control?.removeTarget(self, action: #selector(handleEvent), for: event)
            subscriber = nil
        }
        
        @objc
        private func handleEvent() {
            guard let control else { return }
            _ = subscriber?.receive(control[keyPath: keyPath])
        }
    }
}

extension UIControl.Event {
    public static var defaultValueEvents: UIControl.Event {
        [.allEditingEvents, .valueChanged]
    }
}
#endif
