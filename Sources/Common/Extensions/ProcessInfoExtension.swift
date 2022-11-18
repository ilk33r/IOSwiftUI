//
//  ProcessInfoExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.11.2022.
//

import Foundation

public extension ProcessInfo {
    
    static var isPreviewMode: Bool {
        return Self.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
