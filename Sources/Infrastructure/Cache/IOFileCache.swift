//
//  IOFileCache.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation

public protocol IOFileCache {
    
    // MARK: - Cache Methods
    
    func getFile(fromCache name: String) throws -> Data
    func storeFile(toCache name: String, fileData: Data) throws
    
    // MARK: - Removers
    
    func removeFile(fromCache name: String) throws
    func removeFiles(beforeDate date: Date)
}
