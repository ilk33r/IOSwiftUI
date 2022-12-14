//
//  IOHiddenModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func hidden(
        isHidden: Binding<Bool>
    ) -> some View {
        modifier(IOHiddenModifier(isHidden: isHidden))
    }
}

struct IOHiddenModifier: ViewModifier {
    
    @Binding private var isHidden: Bool
    
    init(isHidden: Binding<Bool>) {
        self._isHidden = isHidden
    }
    
    func body(content: Content) -> some View {
        if isHidden {
            content
                .hidden()
        } else {
            content
        }
    }
}
