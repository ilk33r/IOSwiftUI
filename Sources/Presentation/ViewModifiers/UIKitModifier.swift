//
//  UIKitModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI

public extension View {
    
    func uiKit<UIKitContent>(@ViewBuilder uiKitView: @escaping () -> UIKitContent) -> some View where UIKitContent: View {
        modifier(UIKitModifier(uiKitView: uiKitView))
    }
}

struct UIKitModifier<UIKitContent>: ViewModifier where UIKitContent: View {
    
    private var uiKitView: () -> UIKitContent
    
    init(@ViewBuilder uiKitView: @escaping () -> UIKitContent) {
        self.uiKitView = uiKitView
    }
    
    func body(content: Content) -> some View {
        Group {
            content
            uiKitView()
                .frame(width: 0, height: 0)
        }
    }
}
