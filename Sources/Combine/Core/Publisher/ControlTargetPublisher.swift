#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit

import Combine

public struct ControlTargetPublisher<Control: AnyObject>: Publisher {
    public typealias Output = Control
    public typealias Failure = Never

    public typealias AddTargetAction = (Control, AnyObject, Selector) -> Void
    public typealias RemoveTargetAction = (Control?, AnyObject, Selector) -> Void

    private let control: Control
    private let addTargetAction: AddTargetAction
    private let removeTargetAction: RemoveTargetAction

    public init(
        control: Control,
        addTargetAction: @escaping AddTargetAction,
        removeTargetAction: @escaping RemoveTargetAction
    ) {
        self.control = control
        self.addTargetAction = addTargetAction
        self.removeTargetAction = removeTargetAction
    }

    public func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(
            subscriber: subscriber,
            control: control,
            addTargetAction: addTargetAction,
            removeTargetAction: removeTargetAction
        )
        subscriber.receive(subscription: subscription)
    }
}

extension ControlTargetPublisher {
    private final class Subscription<S: Subscriber, C: AnyObject>: Combine.Subscription where S.Input == C {
        typealias AddTargetAction = (C, AnyObject, Selector) -> Void
        typealias RemoveTargetAction = (C?, AnyObject, Selector) -> Void

        private var subscriber: S?
        private var control: C?

        private let removeTargetAction: RemoveTargetAction
        private let action = #selector(interaction)

        init(
            subscriber: S,
            control: C,
            addTargetAction: @escaping AddTargetAction,
            removeTargetAction: @escaping RemoveTargetAction
        ) {
            self.subscriber = subscriber
            self.control = control
            self.removeTargetAction = removeTargetAction

            addTargetAction(control, self, action)
        }

        func request(_: Subscribers.Demand) { }

        func cancel() {
            subscriber = nil
            removeTargetAction(control, self, action)
        }

        @objc
        private func interaction() {
            guard let control else { return }
            _ = subscriber?.receive(control)
        }
    }
}
#endif
