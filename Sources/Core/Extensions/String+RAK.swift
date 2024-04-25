//
//  MutableCollection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - Conversion

extension Extendable where Base == String {
    public var toURL: URL? {
        guard
            let urlString = base.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return nil
        }
        return .init(string: urlString)
    }
    
    public var toHex: Int {
        var sum = 0
        
        for item in base.uppercased().utf8 {
            // 0-9 starting from 48
            sum = sum * 16 + Int(item) - 48
            
            // A-Z starts at 65, but has an initial value of 10, so it should be minus 55
            if item >= 65 { sum -= 7 }
        }
        
        return sum
    }
}

// MARK: - Interception

extension Extendable where Base == String {
    /// The UTF-16 code units of a string's `utf16`
    public var length: Int { base.utf16.count }
    
    /// Cut the maximum length string
    public func prefixed(_ maxLength: Int) -> Base {
        let sequence = base.utf16
        
        // Basically, they will be judged by the outside world, and if it is small,
        // it will not be intercepted. So `_fastPath` can be used here to optimize.
        guard _fastPath(sequence.count > maxLength) else { return base }
        
        let startIndex = sequence.startIndex
        var endIndex = sequence.index(startIndex, offsetBy: maxLength)
        
        // Check if the last character is a surrogate
        // Surrogates are often used to represent Unicode characters beyond the Basic Multilingual Plane (BMP),
        // such as some emojis
        while endIndex > startIndex, UTF16.isTrailSurrogate(sequence[endIndex]) {
            endIndex = sequence.index(before: endIndex)
        }
        
        let result = Base(sequence[..<endIndex])
        
        // Just in case, use the capabilities of Objective-C to intercept
        return result ?? bridgeToObjC.substring(to: maxLength)
    }
    
    /// Start intercepting from any position
    public func subString(from: Int) -> Base {
        let index = base.index(base.startIndex, offsetBy: from)
        return Base(base[index ..< base.endIndex])
    }
    
    /// Converts an `NSRange` object to a `Range<String.Index>` half-open range applicable to the string
    public func range(from range: NSRange) -> Range<Base.Index> {
        _range(from: range, type: ..<)
    }
    
    /// Converts an `NSRange` object to a `ClosedRange<String.Index>` closed range that applies to the string
    public func closedRange(from range: NSRange) -> ClosedRange<Base.Index> {
        _range(from: range, type: ...)
    }
    
    /// Split string according to fixed length
    ///
    /// - Parameter length: length of each part
    /// - Returns: The result after splitting
    public func split(by length: Int) -> [Base] {
        var result = [Base]()
        var index = base.startIndex
        
        while index < base.endIndex {
            let nextIndex = base.index(index, offsetBy: length, limitedBy: base.endIndex) ?? base.endIndex
            result.append(Base(base[index ..< nextIndex]))
            index = nextIndex
        }
        
        return result
    }
    
    /// Divide the **pure number** string into fixed lengths
    ///
    /// - Parameter length: length of each part
    /// - Returns: The result after splitting
    public func splitNumeric(by length: Int) -> [Base] {
        stride(from: 0, to: base.count, by: length).map {
            let startIndex = base.index(base.startIndex, offsetBy: $0)
            let endIndex = base.index(startIndex, offsetBy: length, limitedBy: base.endIndex) ?? base.endIndex
            return Base(base[startIndex ..< endIndex])
        }
    }
    
    private func _range<T>(from range: NSRange, type: (String.Index, String.Index) -> T) -> T {
        let text = base
        let startIndex = text.index(text.startIndex, offsetBy: range.location)
        let endIndex = text.index(text.startIndex, offsetBy: range.location + range.length)
        return type(startIndex, endIndex)
    }
}

// MARK: - NSString bridged

extension Extendable where Base == String {
    public func range(of searchString: Base) -> NSRange {
        bridgeToObjC.range(of: searchString)
    }
    
    public func size(withFont font: UIFont) -> CGSize {
        size(withAttributes: [.font: font])
    }
    
    public func size(withAttributes attrs: [NSAttributedString.Key: Any]? = nil) -> CGSize {
        let size = bridgeToObjC.size(withAttributes: attrs)
        
        // The documentation for `size(withAttributes:)` mentions that the `ceil` method should be used to round the result.
        return .init(width: ceil(size.width), height: ceil(size.height))
    }
    
    public func draw(at point: CGPoint, withAttributes attrs: [NSAttributedString.Key: Any]? = nil) {
        bridgeToObjC.draw(at: point, withAttributes: attrs)
    }
    
    public func draw(in rect: CGRect, withAttributes attrs: [NSAttributedString.Key: Any]? = nil) {
        bridgeToObjC.draw(in: rect, withAttributes: attrs)
    }
}
