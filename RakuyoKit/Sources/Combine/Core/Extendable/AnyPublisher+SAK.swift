import Foundation

import Combine

public extension AnyPublisher {
    /// 创建一个空的信号
    static func empty(completeImmediately: Bool = true) -> Self {
        return Empty<Self.Output, Self.Failure>(completeImmediately: completeImmediately).eraseToAnyPublisher()
    }
    
    /// 直接发送一个信号
    static func send(value: Self.Output) -> Self {
        return Result<Self.Output, Self.Failure>.Publisher(.success(value)).eraseToAnyPublisher()
    }
}
