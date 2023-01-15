//
//  IOAttributedStringModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.01.2023.
//

import Foundation

public struct IOAttributedStringModel {
    
    // MARK: - Defs
    
    public enum `Type` {
        
        case bold
        case link
    }

    // MARK: - Publics
    
    public let range: NSRange
    public let type: `Type`
    public let urlString: String?
    
    // MARK: - Initialization Methods
    
    public init(
        range: NSRange,
        type: `Type`,
        urlString: String?
    ) {
        self.range = range
        self.type = type
        self.urlString = urlString
    }
}
