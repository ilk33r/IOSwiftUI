//
//  FileManagerExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation

public extension FileManager {
    
    var cacheDirectory: String {
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.cachesDirectory,
            FileManager.SearchPathDomainMask.userDomainMask,
            true
        )
        return paths.first ?? ""
    }
    
    var documentDirectory: String {
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask,
            true
        )
        return paths.first ?? ""
    }
    
    var downloadsDirectory: String {
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.downloadsDirectory,
            FileManager.SearchPathDomainMask.userDomainMask,
            true
        )
        return paths.first ?? ""
    }
    
    func addSkipBackupAttribute(toItemAt filePath: String) throws {
        var directoryURL = URL(fileURLWithPath: filePath)
        var urlResourceValues = URLResourceValues()
        urlResourceValues.isExcludedFromBackup = true
        
        try directoryURL.setResourceValues(urlResourceValues)
    }
}
