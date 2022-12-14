//
//  BindingExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import Foundation
import SwiftUI

public extension Binding {
    
    func onChange(_ handler: @escaping (_ value: Value) -> Void) -> Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
