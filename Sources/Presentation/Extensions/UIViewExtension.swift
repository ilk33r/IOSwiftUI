//
//  UIViewExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import UIKit
import SwiftUI

public extension UIView {
    
    func controller() -> UIViewController? {
        var responder = self.next
        while responder != nil {
            if responder is UIViewController {
                return responder as? UIViewController
            }
            
            responder = responder?.next
        }
        
        return nil
    }
    
    func find<TView: UIResponder>(type: TView.Type, in view: UIView) -> TView? {
        let subViewCount = view.subviews.count
        if subViewCount == 0 {
            return nil
        }
        
        for subView in view.subviews {
            if subView is TView {
                return subView as? TView
            }
            
            if !subView.subviews.isEmpty {
                return find(type: type, in: subView)
            }
        }
        
        return nil
    }
}
