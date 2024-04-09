//
//  TextField.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import RAKConfig

#if !os(watchOS)
@objc(RAKTextField)
public final class TextField: UITextField {
    /// Color of the placeholder text
    ///
    /// Please set before setting `placeholder`.
    /// Default is `Config.color.auxiliaryText`.
    public lazy var placeholderColor: UIColor = Config.color.auxiliaryGray.main
    
    public override var placeholder: String? {
        didSet { configPlaceholder() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configPlaceholder()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configPlaceholder()
    }
    
    private func configPlaceholder() {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [.foregroundColor: placeholderColor]
        )
    }
}

public extension TextField {
    func selectedRange() -> NSRange? {
        guard
            let start = selectedTextRange?.start,
            let end = selectedTextRange?.end
        else {
            return nil
        }
        
        let location = offset(from: beginningOfDocument, to: start)
        let length = offset(from: start, to: end)
        return .init(location: location, length: length)
    }
    
    func setSelectedRange(_ range: NSRange) {
        guard
            let start = position(from: beginningOfDocument, offset: range.location),
            let end = position(from: beginningOfDocument, offset: range.location + range.length),
            let textRange = textRange(from: start, to: end)
        else {
            return
        }
        
        selectedTextRange = textRange
    }
}
#endif
