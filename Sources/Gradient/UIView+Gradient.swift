//
//  UIView+Gradient.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import RAKCore
import Then

extension Extendable where Base: UIView {
    /// This type can be said to be a further abstraction of `Gradient.Position`
    ///
    /// `Gradient.Position` represents a specific point or position.
    /// The type `Gradient.Direction` represents the direction, including the starting point and the end point.
    public typealias Direction = Gradient.Direction

    /// Conveniently creates a gradient layer using preset positions from the `Direction` enumeration.
    ///
    /// - Parameters:
    ///   - direction: Gradient direction.
    ///   - colors: The colors for the gradient.
    /// - Returns: The created gradient layer.
    public func createGradientLayer(direction: Direction, colors: [UIColor]) -> CAGradientLayer {
        createGradientLayer(by: .init(direction: direction, colors: .init(colors)))
    }
    
    /// Conveniently applies a gradient to the view using preset positions from the `Direction` enumeration.
    ///
    /// - Parameters:
    ///   - direction: Gradient direction.
    ///   - colors: The colors for the gradient.
    /// - Returns: The created gradient layer.
    @discardableResult
    public func setGradient(direction: Direction, colors: [UIColor]) -> CAGradientLayer {
        applyGradient(with: .init(direction: direction, colors: .init(colors)))
    }
}

extension Extendable where Base: UIView {
    /// Creates a gradient layer for the view.
    ///
    /// - Parameter gradient: The gradient configuration.
    /// - Returns: The created gradient layer.
    public func createGradientLayer(by gradient: Gradient) -> CAGradientLayer {
        let start = gradient.startPosition
        let end = gradient.endPosition

        let layer = CAGradientLayer()
        
        guard
            start.x >= 0, start.x <= 1,
            start.y >= 0, start.y <= 1,
            end.x >= 0, end.x <= 1,
            end.y >= 0, end.y <= 1
        else {
            assertionFailure("Values for start(\(start)) and end(\(end)) must be within the range of 0 to 1!")
            return layer
        }
        
        if base.layer.bounds.isEmpty {
            base.layoutIfNeeded()
            base.superview?.layoutIfNeeded()
        }
        
        return layer.then {
            $0.frame = base.layer.bounds
            $0.startPoint = .init(x: start.x, y: start.y)
            $0.endPoint = .init(x: end.x, y: end.y)
            $0.colors = gradient.colors.colors.map(\.cgColor)
            $0.cornerRadius = base.layer.cornerRadius
            $0.maskedCorners = base.layer.maskedCorners
            $0.masksToBounds = true
        }
    }
    
    /// Applies the gradient configuration to the view.
    ///
    /// - Parameter gradient: The gradient configuration.
    /// - Returns: The created gradient layer.
    @discardableResult
    public func applyGradient(with gradient: Gradient) -> CAGradientLayer {
        removeGradientLayer()
        
        let gradientLayer = createGradientLayer(by: gradient)
        
        base.layer.insertSublayer(gradientLayer, at: 0)
        base.backgroundColor = .clear
        
        base.layer.masksToBounds = false
        
        return gradientLayer
    }
    
    /// Removes the gradient view.
    public func removeGradientLayer() {
        guard let sublayers = base.layer.sublayers else { return }
        
        func removeFromSuperlayer(_ layer: CALayer) {
            guard layer is CAGradientLayer else { return }
            layer.removeFromSuperlayer()
        }
        sublayers.forEach(removeFromSuperlayer)
    }
}
#endif
