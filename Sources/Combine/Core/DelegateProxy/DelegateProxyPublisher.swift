#if !(os(iOS) && (arch(i386) || arch(arm)))
import Foundation

import Combine

@available(iOS 13.0, *)
final class DelegateProxyPublisher<Output>: Publisher {
    typealias Failure = Never
    
    private let handler: (AnySubscriber<Output, Failure>) -> Void
    
    init(_ handler: @escaping (AnySubscriber<Output, Failure>) -> Void) {
        self.handler = handler
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(subscriber: AnySubscriber(subscriber), handler: handler)
        subscriber.receive(subscription: subscription)
    }
}

@available(iOS 13.0, *)
extension DelegateProxyPublisher {
    fileprivate class Subscription<S>: Combine.Subscription where S: Subscriber, Failure == S.Failure, Output == S.Input {
        private var subscriber: S?
        
        init(subscriber: S, handler: @escaping (S) -> Void) {
            self.subscriber = subscriber
            handler(subscriber)
        }
        
        func request(_: Subscribers.Demand) {
            // We don't care for the demand.
        }
        
        func cancel() {
            subscriber = nil
        }
    }
}
#endif
