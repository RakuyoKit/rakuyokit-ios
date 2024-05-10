//
//  MutableCollection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - ConvertibleToColor

/// Used to convert some types to `UIColor` types
public protocol ConvertibleToColor {
    /// The converted color will be read through this attribute
    var color: UIColor { get }
}

extension ConvertibleToColor {
    /// The Quartz color that corresponds to the color object.
    public var cgColor: CGColor { color.cgColor }

    #if !os(watchOS)
    /// The Core Image color that corresponds to the color object.
    public var ciColor: CIColor { color.ciColor }
    #endif

    /// Returns a color in the same color space as the receiver with the specified alpha component.
    public func withAlphaComponent(_ alpha: CGFloat) -> UIColor {
        color.withAlphaComponent(alpha)
    }
}

// MARK: - UIColor + ConvertibleToColor

extension UIColor: ConvertibleToColor {
    public var color: UIColor { self }
    
    /// Initialized as a `UIColor` object using a value conforming to the `ConvertibleToColor` protocol
    ///
    /// - Parameters:
    ///   - value: color value
    ///   - alpha: Transparency, default is `1`
    public convenience init(_ value: ConvertibleToColor, alpha: CGFloat = 1) {
        self.init(cgColor: value.color.withAlphaComponent(alpha).cgColor)
    }
}

// MARK: - Int + ConvertibleToColor

/// Like `0x88B0BF`
extension Int: ConvertibleToColor {
    public var color: UIColor {
        let red = CGFloat((self & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((self & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(self & 0xFF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

// MARK: - String + ConvertibleToColor

/// Like `#FF7F20` or `FF7F20`
extension String: ConvertibleToColor {
    public var color: UIColor { rak.toHex.color }
}

// MARK: - ConvertibleToColor + ConvertibleToColor

/// Will not check for out-of-bounds behavior.
/// Please make sure that the array contains at least three elements.
///
/// The first three digits in the array require the following rules:
///
/// - Greater than or equal to 0, such as `0`
/// - Decimals less than 1, for example `0.5`
/// - Any number greater than or equal to 1, such as `234` or `120.5`
///
/// When the fourth bit is included, it will be used directly for the transparency setting
///
/// Some examples:
///
/// ```swift
/// view.backgroundColor = [0.4, 127.5, 127, 0.5].color
/// ```
extension [CGFloat]: ConvertibleToColor {
    public var color: UIColor {
        let configValue: (CGFloat) -> CGFloat = {
            guard $0 > 1 else { return $0 }
            return $0 / 255
        }
        
        let red = configValue(self[0])
        let gre = configValue(self[1])
        let blu = configValue(self[2])
        
        if count >= 4 {
            return UIColor(red: red, green: gre, blue: blu, alpha: self[3])
        }
        
        return UIColor(red: red, green: gre, blue: blu, alpha: 1)
    }
}
