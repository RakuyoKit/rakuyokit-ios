import UIKit

import Combine

public extension Publisher where Self.Output: UITextField {
    /// 对输入长度进行限制
    ///
    /// - Parameter max: 最大的输入长度，`nil` 代表不限制
    /// - Returns:
    func limitInputLength(max: Int?) -> Publishers.Map<Self, String> {
        map {
            var content = $0.text ?? ""
            
            if let max = max, content.rak.length > max {
                content = content.rak.prefixed(max)
                $0.text = content
            }
            
            return content
        }
    }
}
