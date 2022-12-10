//
//  SplashNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct SplashNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: SplashNavigationState
    
    // MARK: - Properties
    
    public var body: some View {
        Group {
            NavigationLink(
                destination: route(PreLoginRouters.self, .login(entity: nil)),
                isActive: $navigationState.navigateToLogin
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: route(PreLoginRouters.self, .register(entity: nil)),
                isActive: $navigationState.navigateToRegister
            ) {
                EmptyView()
            }
        }
    }
}
