//
//  IOScrollDismissKeyboardModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.02.2023.
//

import Foundation
import SwiftUI

public extension View {
    
    @ViewBuilder
    func scrollDismissKeyboard() -> some View {
        modifier(IOScrollDismissKeyboardModifier())
    }
}

struct IOScrollDismissKeyboardModifier: ViewModifier {
    
    init() {
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollDismissesKeyboard(.interactively)
        } else {
            content
        }
    }
}
