//
//  HTTPDebuggerNotificationNameExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

#if DEBUG
import Foundation

extension NSNotification.Name {
    
    static let httpDebuggerShareLog = NSNotification.Name("httpDebuggerShareLog")
}
#endif
