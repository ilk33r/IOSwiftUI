//
//  HiddenModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import SwiftUI

public extension View {
    
    func hidden(
        isHidden: Binding<Bool>
    ) -> some View {
        modifier(HiddenModifier(isHidden: isHidden))
    }
}

struct HiddenModifier: ViewModifier {
    
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
