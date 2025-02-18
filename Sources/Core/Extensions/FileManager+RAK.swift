//
//  MutableCollection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

import RaLog

extension Extendable where Base: FileManager {
    public typealias SearchDirectory = FilePathComponents.SearchDirectory

    public static func url(for directory: SearchDirectory) -> URL {
        Base.default.rak.url(for: directory)
    }

    public static func urlPath(for pathComponents: FilePathComponents) -> URL? {
        Base.default.rak.urlPath(for: pathComponents)
    }

    public func url(for directory: SearchDirectory) -> URL {
        base.urls(for: directory, in: .userDomainMask)[0]
    }

    public func urlPath(for pathComponents: FilePathComponents) -> URL? {
        let url: URL? =
            switch pathComponents.searchType {
            case .directory(let directory):
                base.urls(for: directory, in: .userDomainMask)[0]

            case .groupIdentifier(let identifier):
                base.containerURL(forSecurityApplicationGroupIdentifier: identifier)
            }

        return url?.appendingPathComponent(pathComponents.path)
    }
}

extension Extendable where Base: FileManager {
    public static func createDirectory(url: URL) throws {
        try Base.default.rak.createDirectory(url: url)
    }

    public static func removeItemIfExists(at url: URL) throws {
        try Base.default.rak.removeItemIfExists(at: url)
    }

    public static func removeItemIfExists(at path: String) throws {
        try Base.default.rak.removeItemIfExists(at: path)
    }

    public func createDirectory(url: URL) throws {
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

    public func removeItemIfExists(at url: URL) throws {
        guard base.fileExists(atPath: url.path) else { return }
        try base.removeItem(at: url)
    }

    public func removeItemIfExists(at path: String) throws {
        guard base.fileExists(atPath: path) else { return }
        try base.removeItem(atPath: path)
    }
}

extension Extendable where Base: FileManager {
    @discardableResult
    public static func writeData(_ data: Data, to path: FilePathComponents, filename: String) throws -> Bool {
        try Base.default.rak.writeData(data, to: path, filename: filename)
    }

    public static func readFile(_ filename: String, from path: FilePathComponents) -> Data? {
        Base.default.rak.readFile(filename, from: path)
    }

    @discardableResult
    public func writeData(_ data: Data, to path: FilePathComponents, filename: String) throws -> Bool {
        guard let folder = urlPath(for: path) else { return false }
        let file = folder.appendingPathComponent(filename)

        try createDirectory(url: folder)
        return base.createFile(atPath: file.path, contents: data, attributes: nil)
    }

    public func readFile(_ filename: String, from path: FilePathComponents) -> Data? {
        guard let folder = urlPath(for: path) else { return nil }
        let file = folder.appendingPathComponent(filename)

        return base.contents(atPath: file.path)
    }
}

extension Extendable where Base: FileManager {
    /// Remove Launch Screen Cache
    ///
    /// To ensure the latest launch screen is always displayed, cache needs to be cleared when it exists.
    public static func removeLaunchScreenCache() {
        Base.default.rak.removeLaunchScreenCache()
    }

    /// Remove Launch Screen Cache
    ///
    /// **This method may not always take effect.**
    ///
    /// To ensure the latest launch screen is always displayed, cache needs to be cleared when it exists.
    public func removeLaunchScreenCache() {
        let filePath = "\(NSHomeDirectory())/Library/SplashBoard"

        do {
            try removeItemIfExists(at: filePath)
            Log.success("Successfully cleared LaunchScreen cache")
        } catch {
            Log.error("Failed to clear LaunchScreen cache: \(error)")
        }
    }
}
