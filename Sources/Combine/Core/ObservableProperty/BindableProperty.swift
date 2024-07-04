import Foundation

import Combine

// MARK: - BindableProperty

///
public final class BindableProperty<Value>: BindableConvertibleProperty<Value, Value> {
    public init(_ value: Value) {
        super.init(value, map: nil)
    }

    @available(*, unavailable)
    override init(_: Value, map _: ObservableMapBlock?) {
        fatalError("init(_:map:) has not been implemented")
    }
}

// MARK: - BindableConvertibleProperty

///
public class BindableConvertibleProperty<Value, Convert> {
    public typealias Wrapper = ObservablePropertyWrapper<Value, Convert>

    public typealias ObservableMapBlock = Wrapper.ObservableMapBlock

    public var value: Value { observableWrapper.value }

    public var valuePublisher: AnyPublisher<Value, Never> {
        observableWrapper.valuePublisher
    }

    public var valueMapPublisher: AnyPublisher<Convert, Never> {
        observableWrapper.valueMapPublisher
    }

    private let observableWrapper: Wrapper

    public init(_ value: Value, map: ObservableMapBlock?) {
        observableWrapper = .init(value, map: map)
    }

    public func update(_ value: Value) {
        observableWrapper.update(value)
    }
}
