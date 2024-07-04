#if !(os(iOS) && (arch(i386) || arch(arm)))
import Foundation

import _RAKCombineRuntime
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
open class DelegateProxy: ObjcDelegateProxy {
    private var dict: [Selector: [([Any]) -> Void]] = [:]
    private var subscribers = [AnySubscriber<[Any], Never>?]()

    override public required init() {
        super.init()
    }

    deinit {
        for subscriber in subscribers { subscriber?.receive(completion: .finished) }
        subscribers = []
    }

    override public func interceptedSelector(_ selector: Selector, arguments: [Any]) {
        dict[selector]?.forEach { handler in
            handler(arguments)
        }
    }

    public func intercept(_ selector: Selector, _ handler: @escaping ([Any]) -> Void) {
        if dict[selector] != nil {
            dict[selector]?.append(handler)
        } else {
            dict[selector] = [handler]
        }
    }

    public func interceptSelectorPublisher(_ selector: Selector) -> AnyPublisher<[Any], Never> {
        DelegateProxyPublisher<[Any]> { subscriber in
            self.subscribers.append(subscriber)
            return self.intercept(selector) { args in
                _ = subscriber.receive(args)
            }
        }.eraseToAnyPublisher()
    }
}
#endif
