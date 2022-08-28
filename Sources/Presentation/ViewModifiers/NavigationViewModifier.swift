//
//  NavigationViewModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI

public extension View {
    
    func navigationView<Wireframe>(@ViewBuilder wireframeView: () -> Wireframe) -> some View where Wireframe: IONavigationLinkView {
        modifier(NavigationViewModifier(wireframeView: wireframeView()))
    }
}

struct NavigationViewModifier<Wireframe>: ViewModifier where Wireframe: IONavigationLinkView {
    
    private var wireframeView: Wireframe
    
    init(wireframeView: Wireframe) {
        self.wireframeView = wireframeView
    }
    
    func body(content: Content) -> some View {
        NavigationView {
            VStack {
                content
                wireframeView
            }
        }
    }
}
