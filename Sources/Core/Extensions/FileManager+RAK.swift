//
//  MutableCollection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

import RaLog

public extension Extendable where Base: FileManager {
    typealias SearchDirectory = FilePathComponents.SearchDirectory
    
    static func url(for directory: SearchDirectory) -> URL {
        return Base.default.rak.url(for: directory)
    }
    
    static func urlPath(for pathComponents: FilePathComponents) -> URL? {
        return Base.default.rak.urlPath(for: pathComponents)
    }
    
    func url(for directory: SearchDirectory) -> URL {
        return base.urls(for: directory, in: .userDomainMask)[0]
    }
    
    func urlPath(for pathComponents: FilePathComponents) -> URL? {
        let url: URL? = {
            switch pathComponents.searchType {
            case .directory(let directory):
                return base.urls(for: directory, in: .userDomainMask)[0]
                
            case .groupIdentifier(let identifier):
                return base.containerURL(forSecurityApplicationGroupIdentifier: identifier)
            }
        }()
        
        return url?.appendingPathComponent(pathComponents.path)
    }
}

public extension Extendable where Base: FileManager {
    static func createDirectory(url: URL) throws {
        try Base.default.rak.createDirectory(url: url)
    }
    
    static func removeItemIfExists(at url: URL) throws {
        try Base.default.rak.removeItemIfExists(at: url)
    }
    
    static func removeItemIfExists(at path: String) throws {
        try Base.default.rak.removeItemIfExists(at: path)
    }
    
    func createDirectory(url: URL) throws {
        var isDirectory = ObjCBool(false)
        let isExist = base.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        switch (isExist, isDirectory.boolValue) {
        case (false, _):
            try base.createDirectory(at: url, withIntermediateDirectories: true)
            
        case (true, false):
            try base.removeItem(at: url)
            try base.createDirectory(at: url, withIntermediateDirectories: true)
            
        default:
            break
        }
    }
    
    func removeItemIfExists(at url: URL) throws {
        guard base.fileExists(atPath: url.path) else { return }
        try base.removeItem(at: url)
    }
    
    func removeItemIfExists(at path: String) throws {
        guard base.fileExists(atPath: path) else { return }
        try base.removeItem(atPath: path)
    }
}

public extension Extendable where Base: FileManager {
    @discardableResult
    static func writeData(_ data: Data, to path: FilePathComponents, filename: String) throws -> Bool {
        return try Base.default.rak.writeData(data, to: path, filename: filename)
    }
    
    static func readFile(_ filename: String, from path: FilePathComponents) -> Data? {
        return Base.default.rak.readFile(filename, from: path)
    }
    
    @discardableResult
    func writeData(_ data: Data, to path: FilePathComponents, filename: String) throws -> Bool {
        guard let folder = urlPath(for: path) else { return false }
        let file = folder.appendingPathComponent(filename)
        
        try createDirectory(url: folder)
        return base.createFile(atPath: file.path, contents: data, attributes: nil)
    }
    
    func readFile(_ filename: String, from path: FilePathComponents) -> Data? {
        guard let folder = urlPath(for: path) else { return nil }
        let file = folder.appendingPathComponent(filename)
        
        return base.contents(atPath: file.path)
    }
}

public extension Extendable where Base: FileManager {
    /// Remove Launch Screen Cache
    ///
    /// To ensure the latest launch screen is always displayed, cache needs to be cleared when it exists.
    static func removeLaunchScreenCache() {
        Base.default.rak.removeLaunchScreenCache()
    }
    
    /// Remove Launch Screen Cache
    ///
    /// **This method may not always take effect.**
    ///
    /// To ensure the latest launch screen is always displayed, cache needs to be cleared when it exists.
    func removeLaunchScreenCache() {
        let filePath = "\(NSHomeDirectory())/Library/SplashBoard"
        
        do {
            try removeItemIfExists(at: filePath)
            Log.success("Successfully cleared LaunchScreen cache")
        } catch {
            Log.error("Failed to clear LaunchScreen cache: \(error)")
        }
    }
}
