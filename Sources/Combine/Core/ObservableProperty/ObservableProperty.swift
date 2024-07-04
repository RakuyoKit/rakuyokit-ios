import Foundation

import Combine

// MARK: - ObservableProperty

protocol ObservableProperty {
    associatedtype ValueType
    associatedtype ConvertType

    typealias ObservableMapBlock = (ValueType) -> ConvertType

    // swiftlint:disable:next private_subject
    var subject: CurrentValueSubject<ValueType, Never> { get }

    var mapBlock: ObservableMapBlock? { get }

    init(_ value: ValueType, map: ObservableMapBlock?)

    func createValuePublisher() -> AnyPublisher<ValueType, Never>

    func createValueMapPublisher() -> AnyPublisher<ConvertType, Never>
}

extension ObservableProperty {
    var value: ValueType { subject.value }

    func update(_ value: ValueType) {
        subject.send(value)
    }

    func createValuePublisher() -> AnyPublisher<ValueType, Never> {
        subject.eraseToAnyPublisher()
    }

    func createValueMapPublisher() -> AnyPublisher<ConvertType, Never> {
        subject
            .compactMap { self.mapBlock?($0) }
            .eraseToAnyPublisher()
    }
}

extension ObservableProperty where ValueType == ConvertType {
    func createValueMapPublisher() -> AnyPublisher<ValueType, Never> {
        createValuePublisher()
    }
}
