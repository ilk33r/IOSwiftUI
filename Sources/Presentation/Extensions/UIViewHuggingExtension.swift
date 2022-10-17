//
//  UIViewHuggingExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import UIKit
import IOSwiftUICommon

public extension UIView {
    
    func setPriorities(priorities: IOHuggingPriorities) {
        if priorities.contains(.horizontalLow) {
            self.setContentHuggingPriority(UILayoutPriority(rawValue: 240), for: .horizontal)
        }
        
        if priorities.contains(.horizontalHigh) {
            self.setContentHuggingPriority(UILayoutPriority(rawValue: 260), for: .horizontal)
        }
        
        if priorities.contains(.verticalLow) {
            self.setContentHuggingPriority(UILayoutPriority(rawValue: 240), for: .vertical)
        }
        
        if priorities.contains(.verticalHigh) {
            self.setContentHuggingPriority(UILayoutPriority(rawValue: 260), for: .vertical)
        }
        
        if priorities.contains(.resistanceHorizontalLow) {
            self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 740), for: .horizontal)
        }
        
        if priorities.contains(.resistanceHorizontalHigh) {
            self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 760), for: .horizontal)
        }

        if priorities.contains(.resistanceVerticalLow) {
            self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 740), for: .vertical)
        }
        
        if priorities.contains(.resistanceVerticalHigh) {
            self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 760), for: .vertical)
        }
    }
}
