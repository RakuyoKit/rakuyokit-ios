//
//  AnyImageContent.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import RAKCore

// MARK: - AnyImageContent

public struct AnyImageContent<View>: AnyImageProviding {
    public typealias Value = ImageContentProviding

    public typealias Input = Equatable & Value

    public let value: (any Value)?

    public let equals: ((any Value)?) -> Bool

    public let setForViewAction: (View?) -> Void

    public init<T: Input>(_ value: T?) {
        self.value = value
        equals = { ($0 as? T == value) }
        setForViewAction = { value?.setForView($0) }
    }
}

// MARK: ImageContentProviding

extension AnyImageContent: ImageContentProviding {
    public func setForView<V>(_ view: V?) {
        setForViewAction(view as? View)
    }
}

// MARK: FastImageContentProviding

extension AnyImageContent: FastImageContentProviding {
    public static func asset(name: String, bundle: Bundle = .main, with configuration: UIImage.Configuration? = nil) -> Self {
        .init(UIImage(named: name, in: bundle, with: configuration))
    }

    public static func data(_ data: Data) -> Self {
        .init(UIImage(data: data))
    }

    public static func file(path: String) -> Self {
        .init(UIImage(contentsOfFile: path))
    }

    public static func sfSymbols(name: String, color: UIColor? = nil, configuration: UIImage.SymbolConfiguration? = nil) -> Self {
        let image = UIImage(systemName: name, withConfiguration: configuration)
        let finalImage = color.flatMap { image?.withTintColor($0, renderingMode: .alwaysOriginal) } ?? image
        return .init(finalImage)
    }
}
#endif
