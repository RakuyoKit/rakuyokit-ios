import Foundation

import Combine

extension Publisher where Failure == Never {
    /// 将信号绑定到 `root.keyPath` 上
    ///
    /// 覆写官方声明以解决内存泄漏问题：
    /// https://forums.swift.org/t/does-assign-to-produce-memory-leaks/29546/11
    func assign<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Output>,
        on root: Root
    ) -> AnyCancellable {
        sink { [weak root] in
            root?[keyPath: keyPath] = $0
        }
    }
}
