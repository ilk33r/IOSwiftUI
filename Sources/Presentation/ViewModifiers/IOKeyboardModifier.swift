//
//  IOKeyboardModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func hideKeyboardOnTap() -> some View {
        modifier(IOKeyboardModifier())
    }
}

struct IOKeyboardModifier: ViewModifier {
    
    init() {
    }
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIResponder.hideKeyboard()
            }
    }
}
