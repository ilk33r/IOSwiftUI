//
//  NavigationWireframeModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI

public extension View {
    
    func navigationWireframe<Wireframe>(isHidden: Bool = false, @ViewBuilder wireframeView: @escaping () -> Wireframe) -> some View where Wireframe: IONavigationLinkView {
        modifier(NavigationWireframeModifier(isHidden: isHidden, wireframeView: wireframeView))
    }
}

struct NavigationWireframeModifier<Wireframe>: ViewModifier where Wireframe: IONavigationLinkView {
    
    private var isHidden: Bool
    private var wireframeView: () -> Wireframe
    
    init(isHidden: Bool, wireframeView: @escaping () -> Wireframe) {
        self.isHidden = isHidden
        self.wireframeView = wireframeView
    }
    
    func body(content: Content) -> some View {
        NavigationView {
            VStack {
                content
                wireframeView()
            }
            .navigationViewStyle(.stack)
            .navigationBarHidden(isHidden)
        }
    }
}
