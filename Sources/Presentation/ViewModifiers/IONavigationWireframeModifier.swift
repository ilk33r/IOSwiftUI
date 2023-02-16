//
//  IONavigationWireframeModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func navigationWireframe<Wireframe>(
        hasNavigationView: Bool,
        isHidden: Bool = false,
        @ViewBuilder wireframeView: @escaping () -> Wireframe
    ) -> some View where Wireframe: IONavigationLinkView {
        modifier(
            IONavigationWireframeModifier(
                hasNavigationView: hasNavigationView,
                isHidden: isHidden,
                wireframeView: wireframeView
            )
        )
    }
}

struct IONavigationWireframeModifier<Wireframe>: ViewModifier where Wireframe: IONavigationLinkView {
    
    private var hasNavigationView: Bool
    private var isHidden: Bool
    private var wireframeView: () -> Wireframe
    
    init(
        hasNavigationView: Bool,
        isHidden: Bool,
        wireframeView: @escaping () -> Wireframe
    ) {
        self.hasNavigationView = hasNavigationView
        self.isHidden = isHidden
        self.wireframeView = wireframeView
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if hasNavigationView {
            NavigationView {
                VStack {
                    content
                    wireframeView()
                }
                .navigationViewStyle(.stack)
                .navigationBarHidden(isHidden)
            }
        } else {
            VStack {
                content
                wireframeView()
            }
        }
    }
}
