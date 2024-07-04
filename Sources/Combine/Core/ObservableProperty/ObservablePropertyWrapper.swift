import Foundation

import Combine

public final class ObservablePropertyWrapper<ValueType, ConvertType>: ObservableProperty {
    public typealias ObservableMapBlock = (ValueType) -> ConvertType

    // swiftlint:disable:next private_subject
    let subject: CurrentValueSubject<ValueType, Never>

    let mapBlock: ObservableMapBlock?

    /// 对外提供的绑定属性
    lazy var valuePublisher = createValuePublisher()

    /// 对外提供的，值转换之后的可绑定属性
    lazy var valueMapPublisher = createValueMapPublisher()

    required init(_ value: ValueType, map: ObservableMapBlock?) {
        subject = .init(value)
        mapBlock = map
    }
}
