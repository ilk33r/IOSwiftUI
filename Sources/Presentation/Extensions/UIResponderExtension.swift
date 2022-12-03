//
//  UIResponderExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 3.12.2022.
//

import Foundation
import UIKit

public extension UIResponder {
    
    // MARK: - Keyboard
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
