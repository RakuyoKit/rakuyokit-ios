//
//  UIColor+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

public extension Extendable where Base: UIColor {
    static func random(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0 ..< 256) / CGFloat(255.0),
            green: CGFloat.random(in: 0 ..< 256) / CGFloat(255.0),
            blue: CGFloat.random(in: 0 ..< 256) / CGFloat(255.0),
            alpha: alpha
        )
    }
}

// MARK: - Color Property

public extension Extendable where Base: UIColor {
    /// Returns the red value component of the current color
    ///
    /// Please ensure that the current color domain is in RGB mode,
    /// otherwise `nil` will be returned if the extraction fails.
    var red: CGFloat? {
        let color = base.cgColor
        
        switch color.colorSpace?.model {
        case .monochrome:
            guard let first = color.components?.first else { return nil }
            return first
            
        case .rgb:
            guard let first = color.components?.first else { return nil }
            return first
            
        default:
            return nil
        }
    }
    
    /// Returns the green value component of the current color
    ///
    /// Please ensure that the current color domain is in RGB mode,
    /// otherwise `nil` will be returned if the extraction fails.
    var green: CGFloat? {
        let color = base.cgColor
        
        switch color.colorSpace?.model {
        case .monochrome:
            guard let first = color.components?.first else { return nil }
            return first
            
        case .rgb:
            return color.components?[1]
            
        default:
            return nil
        }
    }
    
    /// Returns the blue value component of the current color
    ///
    /// Please ensure that the current color domain is in RGB mode,
    /// otherwise `nil` will be returned if the extraction fails.
    var blue: CGFloat? {
        let color = base.cgColor
        
        switch color.colorSpace?.model {
        case .monochrome:
            guard let first = color.components?.first else { return nil }
            return first
            
        case .rgb:
            return color.components?[2]
            
        default:
            return nil
        }
    }
    
    var alpha: CGFloat { base.cgColor.alpha }
    
    var hex: Int {
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        var alpha = CGFloat()
        
        base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return Int((red * 255)) << 16 | Int((green * 255)) << 8 | Int((blue * 255)) << 0
    }
    
    var hexString: String { .init(format: "%06x", hex) }
}
