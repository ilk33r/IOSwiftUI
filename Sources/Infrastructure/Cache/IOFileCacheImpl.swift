//
//  IOFileCacheImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation

public struct IOFileCacheImpl: IOFileCache, IOSingleton {
    
    // MARK: - Singleton
    
    public typealias InstanceType = IOFileCacheImpl
    public static var _sharedInstance: IOFileCacheImpl!
    
    // MARK: - DI
    
    @IOInject private var configuration: IOConfigurationImpl
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Cache Methods
    
    public func getFile(fromCache name: String) throws -> Data {
        let fileManager = FileManager.default
        let fileURL = try cacheFileURL(fromCache: name, cacheDirectory: fileManager.cacheDirectory)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            return try Data(contentsOf: fileURL)
        }
        
        throw IOFileCacheError.cacheNotExists
    }
    
    public func storeFile(toCache name: String, fileData: Data) throws {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.cacheDirectory
        let fileURL = try cacheFileURL(fromCache: name, cacheDirectory: cacheDirectory)
        
        var isDirectory = ObjCBool(true)
        if !fileManager.fileExists(atPath: cacheDirectory, isDirectory: &isDirectory) {
            try fileManager.createDirectory(atPath: cacheDirectory, withIntermediateDirectories: false)
            try fileManager.addSkipBackupAttribute(toItemAt: cacheDirectory)
        }
        
        try fileData.write(to: fileURL)
    }
    
    // MARK: - Removers
    
    public func removeFile(fromCache name: String) throws {
        let fileManager = FileManager.default
        let fileURL = try cacheFileURL(fromCache: name, cacheDirectory: fileManager.cacheDirectory)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            try fileManager.removeItem(at: fileURL)
        }
    }
    
    public func removeFiles(beforeDate date: Date) {
        let fileManager = FileManager.default
        let cacheFolder = URL(fileURLWithPath: fileManager.cacheDirectory)
        let beforeDateInterval = date.timeIntervalSince1970
        
        let resourceKeys = Set<URLResourceKey>([.nameKey, .creationDateKey])
        guard let directoryEnumerator = fileManager.enumerator(
            at: cacheFolder,
            includingPropertiesForKeys: Array(resourceKeys),
            options: []
        ) else { return }
         
        var fileURLsForRemove: [URL] = []
        for case let fileURL as URL in directoryEnumerator {
            guard
                let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
                let createDate = resourceValues.creationDate
            else { continue }
            
            if createDate.timeIntervalSince1970 < beforeDateInterval {
                fileURLsForRemove.append(fileURL)
            }
        }
        
        fileURLsForRemove.forEach { url in
            try? fileManager.removeItem(at: url)
        }
    }
    
    // MARK: - Helper Methods
    
    private func cacheFileURL(fromCache name: String, cacheDirectory: String) throws -> URL {
        let trimmedFileName = name.trimNonAlphaNumericCharacters()
        let cacheDirectoryName = configuration.configForType(type: .fileCacheDirectoryName)
        let fileManager = FileManager.default
        let fileURL = URL(fileURLWithPath: fileManager.cacheDirectory)
            .appendingPathComponent(cacheDirectoryName)
        
        var isDirectory = ObjCBool(true)
        if !fileManager.fileExists(atPath: fileURL.path, isDirectory: &isDirectory) {
            try fileManager.createDirectory(at: fileURL, withIntermediateDirectories: false)
            try fileManager.addSkipBackupAttribute(toItemAt: cacheDirectory)
        }
        
        return fileURL.appendingPathComponent(trimmedFileName)
    }
}
