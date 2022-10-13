//
//  IONavigationBarModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI

public extension View {
    
    func navigationBar<NavigationBar>(@ViewBuilder navigationBar: @escaping () -> NavigationBar) -> some View where NavigationBar: View {
        modifier(IONavigationBarModifier(navigationBar: navigationBar))
    }
}

struct IONavigationBarModifier<NavigationBar>: ViewModifier where NavigationBar: View {
    
    private var navigationBar: () -> NavigationBar
    
    init(navigationBar: @escaping () -> NavigationBar) {
        self.navigationBar = navigationBar
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    navigationBar()
                }
            }
    }
}
