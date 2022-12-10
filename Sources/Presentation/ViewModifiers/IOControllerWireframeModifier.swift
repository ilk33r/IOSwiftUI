//
//  IOControllerWireframeModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func controllerWireframe<Wireframe>(@ViewBuilder wireframeView: () -> Wireframe) -> some View where Wireframe: IONavigationLinkView {
        modifier(IOControllerWireframeModifier(wireframeView: wireframeView()))
    }
}

struct IOControllerWireframeModifier<Wireframe>: ViewModifier where Wireframe: IONavigationLinkView {
    
    private var wireframeView: Wireframe
    
    init(wireframeView: Wireframe) {
        self.wireframeView = wireframeView
    }
    
    func body(content: Content) -> some View {
        VStack {
            content
            wireframeView
        }
    }
}
