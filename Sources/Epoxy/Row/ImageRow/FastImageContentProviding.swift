//
//  ImageContentProviding.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import UIKit

public protocol FastImageContentProviding {
    static func asset(name: String, bundle: Bundle, with configuration: UIImage.Configuration?) -> Self
    static func data(_ data: Data) -> Self
    static func file(path: String) -> Self
    static func sfSymbols(name: String, color: UIColor?, configuration: UIImage.SymbolConfiguration?) -> Self
}
