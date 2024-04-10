import UIKit

public enum ConversionImageError: Error {
    case failure
}

public protocol ConvertibleToImage {
    typealias CompletionBlock = (Result<UIImage, ConversionImageError>) -> Void
    
    @available(watchOS 6.0.0, *)
    func getImage() async throws -> UIImage
    
    func getImage(completion: @escaping CompletionBlock)
    
    func getImage(
        start: EmptyClosure?,
        completion: @escaping CompletionBlock
    )
}

// MARK: - Default

public extension ConvertibleToImage {
    func getImage(completion: @escaping CompletionBlock) {
        getImage(start: nil, completion: completion)
    }
    
    @available(watchOS 6.0.0, *)
    func getImage() async throws -> UIImage {
        try await withCheckedThrowingContinuation { (continuation) in
            getImage { continuation.resume(with: $0) }
        }
    }
}

// MARK: - UIImage + ConvertibleToImage

extension UIImage: ConvertibleToImage {
    public func getImage(start: EmptyClosure?, completion: @escaping CompletionBlock) {
        start?()
        completion(.success(self))
    }
}

// MARK: - UIColor + ConvertibleToImage

#if !os(watchOS)
extension UIColor: ConvertibleToImage {
    public func getImage(start: EmptyClosure?, completion: @escaping CompletionBlock) {
        start?()
        completion(.success(UIImage.rak.color(self)))
    }
}
#endif

// MARK: - Data + ConvertibleToImage

extension Data: ConvertibleToImage {
    public func getImage(start: EmptyClosure?, completion: @escaping CompletionBlock) {
        start?()
        
        if let image = UIImage(data: self, scale: 0.9) {
            completion(.success(image))
        } else {
            completion(.failure(.failure))
        }
    }
}
