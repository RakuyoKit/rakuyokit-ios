import Foundation

import Combine

extension AnyPublisher {
    /// 创建一个空的信号
    public static func empty(completeImmediately: Bool = true) -> Self {
        Empty<Self.Output, Self.Failure>(completeImmediately: completeImmediately).eraseToAnyPublisher()
    }

    /// 直接发送一个信号
    public static func send(value: Self.Output) -> Self {
        Result<Self.Output, Self.Failure>.Publisher(.success(value)).eraseToAnyPublisher()
    }
}
