//
//  ProcessInfoExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.11.2022.
//

import Foundation

public extension ProcessInfo {
    
    static var isPreviewMode: Bool {
        Self.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    static var isTestMode: Bool {
        !(Self.processInfo.environment["XCTestSessionIdentifier"]?.isEmpty ?? true)
    }
}
