#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit

import _RAKCombineRuntime
import Combine
import RAKCore

@available(iOS 13.0, *)
extension Extendable where Base: UITextView {
    /// A Combine publisher for the `UITextView's` value.
    ///
    /// - note: This uses the underlying `NSTextStorage` to make sure autocorrect changes are reflected as well.
    ///
    /// - seealso: https://git.io/JJM5Q
    public var textPublisher: AnyPublisher<String?, Never> {
        Deferred { [weak textView = base] in
            textView?.textStorage.rak
                .didProcessEditingRangeChangeInLengthPublisher
                .map { _ in textView?.text }
                .prepend(textView?.text)
                .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `textViewDidBeginEditing(_:)`
    public var didBeginEditingPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UITextViewDelegate.textViewDidBeginEditing(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `textViewDidEndEditing(_:)`
    public var didEndEditingPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UITextViewDelegate.textViewDidEndEditing(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    /// A publisher emits on first responder changes
    public var isFirstResponderPublisher: AnyPublisher<Bool, Never> {
        Just<Void>(())
            .merge(with: didBeginEditingPublisher, didEndEditingPublisher)
            .map { [weak textView = base] in
                textView?.isFirstResponder ?? false
            }
            .eraseToAnyPublisher()
    }
    
    /// A publisher emits on selected range changes
    public var selectedRangePublisher: AnyPublisher<NSRange, Never> {
        let selector = #selector(UITextViewDelegate.textViewDidChangeSelection(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .compactMap { [weak textView = base] _ in
                textView?.selectedRange
            }
            .eraseToAnyPublisher()
    }
    
    private var delegateProxy: DelegateProxy {
        TextViewDelegateProxy.createDelegateProxy(for: base)
    }
}

@available(iOS 13.0, *)
private final class TextViewDelegateProxy: DelegateProxy, UITextViewDelegate, DelegateProxyType {
    func setDelegate(to object: UITextView) {
        object.delegate = self
    }
}
#endif
