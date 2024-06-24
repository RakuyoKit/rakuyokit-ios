//
//  UIEdgeInsets+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

import RaLog

// MARK: - Init

extension Extendable where Base: UIImage {
    public enum Radius {
        /// The corner radius should be calculated as a proportion of the **width** of the image.
        /// Typically, the associated value should be between 0 and 0.5,
        /// where 0 means no rounded corners and 0.5 means using half of the image width as the corner radius.
        case widthFraction(CGFloat)

        /// The corner radius should be calculated as a proportion of the **height** of the image.
        /// Typically, the associated value should be between 0 and 0.5,
        /// where 0 means no rounded corners and 0.5 means using half of the image height as the corner radius.
        case heightFraction(CGFloat)

        /// Use a fixed point value as the corner radius.
        case point(CGFloat)

        func compute(with size: CGSize) -> CGFloat {
            let cornerRadius: CGFloat =
                switch self {
                case .point(let point):
                    point
                case .widthFraction(let widthFraction):
                    size.width * widthFraction
                case .heightFraction(let heightFraction):
                    size.height * heightFraction
                }
            return cornerRadius
        }
    }

    #if !os(watchOS)
    /// Generate a solid color image.
    ///
    /// - Parameters:
    ///   - color: The color of the image.
    ///   - size: The size of the image.
    ///   - radius: Whether to apply rounded corners, and the size of the rounded corners.
    ///   - corners: The position of the rounded corners. By default, all four corners have rounded corners.
    /// - Returns: The created image.
    public static func color(
        _ color: UIColor,
        size: CGSize = .init(width: 1, height: 1),
        radius: Radius? = nil,
        corners: CACornerMask = CACornerMask.rak.all
    ) -> UIImage {
        let cornerRadius = radius?.compute(with: size)

        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            let path: UIBezierPath =
                if let cornerRadius {
                    .init(
                        roundedRect: rect,
                        byRoundingCorners: corners.rak.uiRectCorner,
                        cornerRadii: .init(width: cornerRadius, height: cornerRadius)
                    )
                } else {
                    .init(rect: rect)
                }

            color.setFill()
            path.fill()
        }

        guard let cornerRadius else { return image }

        let insets = { UIEdgeInsets(top: $0, left: $0, bottom: $0, right: $0) }(cornerRadius)
        return image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
    }
    #endif
}

// MARK: - Adjustment

extension Extendable where Base: UIImage {
    #if !os(watchOS)
    /// Scale image to new size.
    public func resized(to newSize: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: newSize).image { _ in
            let size = base.size

            // Calculate scaling
            let scaleFactor = min(newSize.width / size.width, newSize.height / size.height)
            let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

            // Calculate drawing area
            let scaledPoint = CGPoint(
                x: (newSize.width - scaledSize.width) * 0.5,
                y: (newSize.height - scaledSize.height) * 0.5
            )

            // draw image
            base.draw(in: .init(origin: scaledPoint, size: scaledSize))
        }
    }
    #endif
}

// MARK: - Compresse

extension Extendable where Base: UIImage {
    /// Image compression result
    public struct ImageCompresseResult {
        /// Whether the compression was successful
        public let isSuccess: Bool

        /// The compressed image data. Returns `nil` when compression fails or when the image cannot be compressed further.
        public let imageData: Data?

        /// The compression ratio when successful. Returns 0.0 when failed.
        public let compression: CGFloat

        /// Returns the failure case
        public static var failure: Self { .init(isSuccess: false, imageData: nil, compression: 0) }
    }

    /// Compress images using bisection method
    ///
    /// - Parameter maxSizeByte: Maximum image size. Unit kb
    /// - Returns: Compress results
    @available(watchOS 6.0, *)
    public func halfFuntion(maxSizeByte: Int) async -> ImageCompresseResult {
        await withCheckedContinuation { continuation in
            halfFuntion(maxSizeByte: maxSizeByte) {
                continuation.resume(returning: $0)
            }
        }
    }

    /// Compress images using bisection method.
    ///
    /// - Parameters:
    ///   - maxSizeByte: Maximum image size. Unit kb
    ///   - completion: Compress results
    public func halfFuntion(maxSizeByte: Int, completion: (ImageCompresseResult) -> Void) {
        // Binary image compression
        var compression: CGFloat = 1

        guard var imageData = base.jpegData(compressionQuality: compression) else {
            completion(.failure)
            return
        }

        // Exponential bisection processing, first calculate the minimum value
        compression = pow(2, -6)

        guard let tmpData = base.jpegData(compressionQuality: compression) else {
            completion(.failure)
            return
        }

        imageData = tmpData

        // If the minimum value is still greater than the maximum value, return the minimum value
        if tmpData.count >= maxSizeByte {
            Log.warning(
                "The original size of the image is approximately: \(imageData)." +
                    "The minimum value that can be compressed is \(tmpData.count)," +
                    "which is still greater than the limit: \(tmpData.count)!"
            )
            completion(.init(isSuccess: false, imageData: imageData, compression: compression))
            return
        }

        var max: CGFloat = 1
        var min: CGFloat = 0

        // The maximum number of bisections is 10 times, and the interval range accuracy can reach 0.00097657;
        // the maximum number is 6 times, and the accuracy can reach 0.015625.
        for _ in 0 ..< 8 {
            compression = (max + min) * 0.5

            guard let tmpData = base.jpegData(compressionQuality: compression) else { continue }

            if tmpData.count < maxSizeByte { imageData = tmpData }

            // Fault tolerance range 0.9~1.0
            if imageData.count < Int(Double(maxSizeByte) * 0.9) {
                min = compression
            } else if imageData.count > maxSizeByte {
                max = compression
            } else {
                break
            }
        }

        completion(.init(isSuccess: true, imageData: imageData, compression: compression))
    }
}

// MARK: - Draw Text

extension Extendable where Base: UIImage {
    public func drawText(
        _ text: String,
        attributes: [NSAttributedString.Key: Any]? = nil,
        at point: CGPoint? = nil
    ) -> UIImage {
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        return drawText(attributedText, at: point)
    }

    public func drawText(_ text: NSAttributedString, at point: CGPoint? = nil) -> UIImage {
        let size = base.size

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        base.draw(in: .init(origin: .zero, size: size))

        let origin: CGPoint
        if let point {
            origin = point
        } else {
            let textSize = text.size()
            origin = .init(
                x: (size.width - textSize.width) / 2.0,
                y: (size.height - textSize.height) / 2.0
            )
        }

        text.draw(in: .init(origin: origin, size: size))

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("Failed to get image from canvas!")
        }

        return image
    }
}

// MARK: - QRCode

extension Extendable where Base: UIImage {
    #if !os(watchOS)
    /// Create QR code
    ///
    /// - Parameters:
    ///   - string: Content in the QR code
    ///   - size: Size of the QR code, default is 100
    /// - Returns: Created QR code image
    @available(iOSApplicationExtension, unavailable, message: "This method is NS_EXTENSION_UNAVAILABLE.")
    public static func createQRCode(with string: String, size: CGFloat = 100) -> UIImage? {
        guard
            let data = string.data(using: .isoLatin1),
            let filter = CIFilter(name: "CIQRCodeGenerator")
        else {
            return nil
        }

        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")

        guard
            let ciImage = filter.outputImage,
            let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent)
        else {
            return nil
        }

        let scale = UIScreen.rak.scale
        let newSize = size * scale
        UIGraphicsBeginImageContext(.init(width: newSize, height: newSize))

        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.interpolationQuality = .none

        context.draw(
            cgImage,
            in: .init(
                x: 0.0,
                y: 0.0,
                width: context.boundingBoxOfClipPath.width,
                height: context.boundingBoxOfClipPath.height
            )
        )

        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }

        return UIImage(cgImage: cgImage, scale: scale, orientation: .downMirrored)
    }
    #endif
}
