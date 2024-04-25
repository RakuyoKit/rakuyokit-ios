//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

public struct FilePathComponents: ExpressibleByStringLiteral {
    public typealias SearchDirectory = FileManager.SearchPathDirectory
    
    public enum SearchType {
        case directory(SearchDirectory)
        case groupIdentifier(String)
    }
    
    public let path: String
    
    public let searchType: SearchType
    
    public init(path: String, searchType: SearchType) {
        self.path = path
        self.searchType = searchType
    }
    
    public init(path: String, directory: SearchDirectory) {
        self.init(path: path, searchType: .directory(directory))
    }
    
    public init(path: String, groupIdentifier: String) {
        self.init(path: path, searchType: .groupIdentifier(groupIdentifier))
    }
    
    public init(stringLiteral value: String) {
        self.init(path: value, directory: .documentDirectory)
    }
}
