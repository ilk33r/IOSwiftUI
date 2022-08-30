//
//  KeyboardModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import SwiftUI

public extension View {
    
    func hideKeyboardOnTap() -> some View {
        modifier(KeyboardModifier())
    }
}

struct KeyboardModifier: ViewModifier {
    
    init() {
    }
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}
