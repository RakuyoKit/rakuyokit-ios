#if !os(watchOS)
import UIKit

import Combine

public protocol KeyboardListenable: NSObjectProtocol {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var view: UIView! { get set }
    
    /// 适用于列表
    var listView: UIScrollView? { get }
    
    /// 可取消的绑定
    var cancellable: Set<AnyCancellable> { get set }
    
    /// 键盘监听之后的逻辑
    func keyboardChange(_ context: _KeyboardChangeContext)
}

// MARK: - Default

public extension KeyboardListenable {
    var listView: UIScrollView? { nil }
    
    @available(iOSApplicationExtension, unavailable, message: "This method is NS_EXTENSION_UNAVAILABLE.")
    func keyboardChange(_ context: _KeyboardChangeContext) {
        defaultKeyboardChangeBehavior(context)
    }
}

// MARK: - Logic

public extension KeyboardListenable {
    /// 添加键盘监听
    @available(iOSApplicationExtension, unavailable, message: "This method is NS_EXTENSION_UNAVAILABLE.")
    func addKeyboardListener(handle: ((_ context: _KeyboardChangeContext) -> Void)? = nil) {
        NotificationCenter.default.rak.keyboardChange
            .sink { [weak self] in (handle ?? self?.keyboardChange)?($0) }
            .store(in: &cancellable)
    }
    
    /// 键盘监听事件的默认行为
    @available(iOSApplicationExtension, unavailable, message: "This method is NS_EXTENSION_UNAVAILABLE.")
    func defaultKeyboardChangeBehavior(_ context: _KeyboardChangeContext) {
        // visionOS 应该不需要处理键盘弹起
#if !os(visionOS)
        guard let _listView = listView else { return }
        
        let height = UIApplication.shared.rak.statusBarHeight(in: view) + 44
        
        if context.endFrame.minY != UIScreen.rak.mainBounds.height {
            // 弹
            let bottom = context.endFrame.height - height
            _listView.contentInset = .init(top: 0, left: 0, bottom: bottom, right: 0)
            _listView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: bottom, right: 0)
            
        } else {
            // 收
            _listView.contentInset = .zero
            _listView.scrollIndicatorInsets = .zero
        }
#endif
    }
}
#endif
