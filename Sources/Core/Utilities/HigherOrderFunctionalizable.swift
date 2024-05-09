//
//  HigherOrderFunctionalizable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

import Then

// MARK: - HigherOrderFunctionalizable

public protocol HigherOrderFunctionalizable: Then { }

extension HigherOrderFunctionalizable {
    public static func `do`(_ block: (Self.Type) throws -> Void) rethrows {
        try block(Self.self)
    }
    
    public static func map<T>(_ transform: (Self.Type) throws -> T) rethrows -> T {
        try transform(Self.self)
    }
    
    public func map<T>(_ transform: (Self) throws -> T) rethrows -> T {
        try transform(self)
    }
}

// MARK: -

// swiftlint:disable colon duplicate_imports
// swiftformat:disable all
import struct Swift.Bool;                 extension Bool                 : HigherOrderFunctionalizable { }
import struct Swift.Int;                  extension Int                  : HigherOrderFunctionalizable { }
import struct Swift.Double;               extension Double               : HigherOrderFunctionalizable { }
import struct Swift.Float;                extension Float                : HigherOrderFunctionalizable { }
import struct Foundation.Date;            extension Date                 : HigherOrderFunctionalizable { }
import struct Foundation.URL;             extension URL                  : HigherOrderFunctionalizable { }
import struct Foundation.Data;            extension Data                 : HigherOrderFunctionalizable { }
import class  Foundation.JSONDecoder;     extension JSONDecoder          : HigherOrderFunctionalizable { }
import class  Foundation.JSONEncoder;     extension JSONEncoder          : HigherOrderFunctionalizable { }
import class  CoreGraphics.CGImage;       extension CGImage              : HigherOrderFunctionalizable { }
import struct UIKit.CGFloat;              extension CGFloat              : HigherOrderFunctionalizable { }
import struct UIKit.CGPoint;              extension CGPoint              : HigherOrderFunctionalizable { }
import struct UIKit.CGSize;               extension CGSize               : HigherOrderFunctionalizable { }
import struct UIKit.CGRect;               extension CGRect               : HigherOrderFunctionalizable { }
import struct UIKit.CGVector;             extension CGVector             : HigherOrderFunctionalizable { }
import struct UIKit.UIEdgeInsets;         extension UIEdgeInsets         : HigherOrderFunctionalizable { }
import struct UIKit.UIOffset;             extension UIOffset             : HigherOrderFunctionalizable { }
import struct UIKit.UIRectEdge;           extension UIRectEdge           : HigherOrderFunctionalizable { }
import class  UIKit.UIColor;              extension UIColor              : HigherOrderFunctionalizable { }
import class  UIKit.UIFont;               extension UIFont               : HigherOrderFunctionalizable { }
import class  UIKit.UIImage;              extension UIImage              : HigherOrderFunctionalizable { }
import class  UIKit.NSAttributedString;   extension NSAttributedString   : HigherOrderFunctionalizable { }

#if !os(watchOS)
import class  CoreImage.CIImage;   extension CIImage   : HigherOrderFunctionalizable { }
#endif

// swiftlint:enable colon duplicate_imports
// swiftformat:enable all
