#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit

import Combine

public struct ControlEventsPublisher<Control: UIControl>: Publisher {
    public typealias Output = Control
    public typealias Failure = Never
    
    private let control: Control
    private let event: UIControl.Event
    
    public init(control: Control, event: UIControl.Event) {
        self.control = control
        self.event = event
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(
            subscriber: subscriber,
            control: control,
            event: event
        )
        subscriber.receive(subscription: subscription)
    }
}

extension ControlEventsPublisher {
    private final class Subscription<S: Subscriber, C: UIControl>: Combine.Subscription where S.Input == C {
        private var subscriber: S?
        private var control: C?
        
        init(subscriber: S, control: C, event: C.Event) {
            self.subscriber = subscriber
            self.control = control
            
            control.addTarget(self, action: #selector(interaction), for: event)
        }
        
        func request(_: Subscribers.Demand) { }
        
        func cancel() {
            subscriber = nil
            control = nil
        }
        
        @objc
        private func interaction() {
            guard let control else { return }
            _ = subscriber?.receive(control)
        }
    }
}
#endif
