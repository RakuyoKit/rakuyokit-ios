//
//  UIColor+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

extension Extendable where Base: UIColor {
    public static var groupTableHeaderFooterTextColor: Base? {
        let value = Base.perform(Selector(("_groupTableHeaderFooterTextColor")))
        return value?.takeUnretainedValue() as? Base
    }

    public static func random(alpha: CGFloat = 1.0) -> Base {
        .init(
            red: CGFloat.random(in: 0 ..< 256) / CGFloat(255.0),
            green: CGFloat.random(in: 0 ..< 256) / CGFloat(255.0),
            blue: CGFloat.random(in: 0 ..< 256) / CGFloat(255.0),
            alpha: alpha
        )
    }
}

// MARK: - Color Property

extension Extendable where Base: UIColor {
    /// Returns the red value component of the current color
    ///
    /// Please ensure that the current color domain is in RGB mode,
    /// otherwise `nil` will be returned if the extraction fails.
    public var red: CGFloat? { getColorComponent(at: 0) }

    /// Returns the green value component of the current color
    ///
    /// Please ensure that the current color domain is in RGB mode,
    /// otherwise `nil` will be returned if the extraction fails.
    public var green: CGFloat? { getColorComponent(at: 1) }

    /// Returns the blue value component of the current color
    ///
    /// Please ensure that the current color domain is in RGB mode,
    /// otherwise `nil` will be returned if the extraction fails.
    public var blue: CGFloat? { getColorComponent(at: 2) }

    public var alpha: CGFloat { base.cgColor.alpha }

    public var hex: Int {
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        var alpha = CGFloat()

        base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return Int(red * 255) << 16 | Int(green * 255) << 8 | Int(blue * 255) << 0
    }

    public var hexString: String { .init(format: "%06x", hex) }
    
    private func getColorComponent(at index: Int) -> CGFloat? {
        let color = base.cgColor

        switch color.colorSpace?.model {
        case .monochrome:
            guard let first = color.components?.first else { return nil }
            return first

        case .rgb:
            return color.components?[index]

        default:
            return nil
        }
    }
}
