import Foundation

import Combine

public extension Array where Element: Publisher {
    func combineLatest() -> AnyPublisher<[Element.Output], Element.Failure> {
        Publishers.combineLatestArray(self)
    }
}

public extension Publishers {
    /// Publishers.CombineLatestArray([publisher1, publisher2])
    static func combineLatestArray<P: Publisher>(_ array: [P]) -> AnyPublisher<[P.Output], P.Failure> {
        guard let first = array.first else {
            return Empty().eraseToAnyPublisher()
        }
        
        return array
            .dropFirst()
            .reduce(
                into: first.map { [$0] }.eraseToAnyPublisher()
            ) { (result, single) in
                result = result
                    .combineLatest(single) { $0 + [$1] }
                    .eraseToAnyPublisher()
            }
    }
}
