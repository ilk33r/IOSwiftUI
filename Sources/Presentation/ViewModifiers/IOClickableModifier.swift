//
//  IOClickableModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.10.2022.
//

import IOSwiftUICommon
import SwiftUI

public extension View {
    
    func setClick(_ handler: IOClickableHandler?) -> some View {
        modifier(IOClickableModifier(handler))
    }
}

struct IOClickableModifier: ViewModifier {
    
    private var handler: IOClickableHandler?
    
    init(_ handler: IOClickableHandler?) {
        self.handler = handler
    }
    
    func body(content: Content) -> some View {
        content
        .contentShape(Rectangle())
        .onTapGesture {
            handler?()
        }
    }
}
