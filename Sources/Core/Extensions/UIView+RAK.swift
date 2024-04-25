//
//  UIView+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import Then

// MARK: - Hide keyboard when tap

extension Extendable where Base: UIView {
    /// By setting this property, you can add/remove the function of
    /// hiding the keyboard when clicked for `UIView` and its subclasses.
    @available(iOSApplicationExtension, unavailable)
    public var isHideKeyboardWhenTap: Bool {
        get { (objc_getAssociatedObject(base, &kIsHideKeyboardWhenTapKey) as? Bool) ?? false }
        set {
            objc_setAssociatedObject(base, &kIsHideKeyboardWhenTapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if newValue {
                base.addGestureRecognizer(base._hideKeyboardGesture)
            } else {
                base.removeGestureRecognizer(base._hideKeyboardGesture)
            }
        }
    }
}

extension UIView {
    @available(iOSApplicationExtension, unavailable)
    fileprivate var _hideKeyboardGesture: UITapGestureRecognizer {
        if let ges = objc_getAssociatedObject(self, &kHideKeyboardGestureKey) as? UITapGestureRecognizer {
            return ges
        }
        
        let ges = UITapGestureRecognizer().then {
            $0.numberOfTapsRequired = 1
            $0.cancelsTouchesInView = false
            $0.addTarget(self, action: #selector(_endEditing))
        }
        
        objc_setAssociatedObject(self, &kHideKeyboardGestureKey, ges, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return ges
    }
    
    @available(iOSApplicationExtension, unavailable)
    @objc
    fileprivate func _endEditing() {
        UIApplication.shared.rak.keyWindow?.endEditing(true)
    }
}

private var kIsHideKeyboardWhenTapKey: Void?
private var kHideKeyboardGestureKey: Void?

// MARK: - Other

extension Extendable where Base: UIView {
    /// Convert UIView to UIImage
    public func toImage() -> UIImage? {
        let format = UIGraphicsImageRendererFormat().then {
            $0.scale = UIScreen.rak.scale
            
            // Ensure the use of the sRGB color space;
            // images in the sRGB color space retain their transparency when converted to PNG format
            $0.preferredRange = .standard
        }
        
        return UIGraphicsImageRenderer(size: base.bounds.size, format: format).image {
            // If the view is not added to a superview or is not displayed,
            // the `drawHierarchy(in:)` method cannot generate an image
            if base.superview == nil || base.isHidden {
                base.layer.render(in: $0.cgContext)
            } else {
                base.drawHierarchy(in: base.bounds, afterScreenUpdates: true)
            }
        }
    }
}
#endif
