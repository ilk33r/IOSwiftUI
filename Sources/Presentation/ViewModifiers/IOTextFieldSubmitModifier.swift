//
//  IOTextFieldSubmitModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.03.2023.
//

import SwiftUI
import IOSwiftUICommon

public extension View {
    
    @ViewBuilder
    func onSend(handler: IOClickableHandler?) -> some View {
        modifier(IOTextFieldSubmitModifier(handler: handler))
    }
}

struct IOTextFieldSubmitModifier: ViewModifier {
    
    private var handler: IOClickableHandler?
    
    init(handler: IOClickableHandler?) {
        self.handler = handler
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .onSubmit {
                    handler?()
                }
        } else {
            content
        }
    }
}
