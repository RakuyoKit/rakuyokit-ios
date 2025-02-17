//
//  DirectlyConvertibleToImage.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - DirectlyConvertibleToImage

/// Encapsulates types that can be converted into a `UIImage` object
///
/// This protocol is responsible for encapsulating **the synchronous process** of converting an object to `UIImage`.
/// If you need to obtain a `UIImage` **asynchronously**, consider using the `ConvertibleToImage` protocol.
public protocol DirectlyConvertibleToImage {
    typealias ConversionResult = Result<UIImage, Error>

    var directImage: UIImage? { get }

    func getDirectImage() -> ConversionResult
}

// MARK: - Default Implementation

extension DirectlyConvertibleToImage {
    public func getDirectImage() -> ConversionResult {
        if let directImage { .success(directImage) } else { .failure(ConversionImageError.failure) }
    }
}

// MARK: - UIImage + DirectlyConvertibleToImage

extension UIImage: DirectlyConvertibleToImage {
    public var directImage: UIImage? { self }
}

// MARK: - UIColor + DirectlyConvertibleToImage

#if !os(watchOS)
extension UIColor: DirectlyConvertibleToImage {
    public var directImage: UIImage? { .rak.color(self) }
}
#endif

// MARK: - Data + DirectlyConvertibleToImage

extension Data: DirectlyConvertibleToImage {
    public var directImage: UIImage? { .init(data: self, scale: 0.9) }
}
