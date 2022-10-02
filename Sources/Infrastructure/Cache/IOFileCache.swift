//
//  IOFileCache.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation

public enum IOFileCacheError: Error {
    case cacheNotExists
}

public protocol IOFileCache {
    
    // MARK: - Cache Methods
    
    func getFile(fromCache name: String) throws -> Data
    func storeFile(toCache name: String, fileData: Data) throws
    
    // MARK: - Removers
    
    func removeFiles(beforeDate date: Date)
}
