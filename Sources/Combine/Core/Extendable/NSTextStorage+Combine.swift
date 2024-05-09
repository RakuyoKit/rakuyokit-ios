#if !os(watchOS)
import UIKit

import Combine
import RAKCore

@available(iOS 13.0, *)
extension Extendable where Base: NSTextStorage {
    public typealias ProcessEditingRangeChangeOutput = (
        editedMask: NSTextStorage.EditActions,
        editedRange: NSRange,
        delta: Int
    )
    
    /// Combine publisher for `NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:)`
    public var didProcessEditingRangeChangeInLengthPublisher: AnyPublisher< // swiftlint:disable:this identifier_name
        ProcessEditingRangeChangeOutput,
        Never
    > {
        let selector = #selector(NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:))
        
        return delegateProxy
            .interceptSelectorPublisher(selector)
            .map { args -> (editedMask: NSTextStorage.EditActions, editedRange: NSRange, delta: Int) in
                // swiftlint:disable force_cast
                let editedMask = NSTextStorage.EditActions(rawValue: args[1] as! UInt)
                let editedRange = (args[2] as! NSValue).rangeValue
                let delta = args[3] as! Int
                return (editedMask, editedRange, delta)
                // swiftlint:enable force_cast
            }
            .eraseToAnyPublisher()
    }
    
    private var delegateProxy: NSTextStorageDelegateProxy {
        .createDelegateProxy(for: base)
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
private final class NSTextStorageDelegateProxy: DelegateProxy, NSTextStorageDelegate, DelegateProxyType {
    func setDelegate(to object: NSTextStorage) {
        object.delegate = self
    }
}
#endif
