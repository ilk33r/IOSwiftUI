//
//  UIResponderExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import UIKit

public extension UIResponder {
    
    func next<TView: UIResponder>(_ type: TView.Type) -> TView? {
        return (next is TView) ? next as? TView : next?.next(type)
    }
}
