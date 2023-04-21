//
//  UIDeviceExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.04.2023.
//

import UIKit

public extension UIDevice {
    
    class var isSimulator: Bool {
#if TARGET_IPHONE_SIMULATOR
        return true
#else
        return false
#endif
    }
}
