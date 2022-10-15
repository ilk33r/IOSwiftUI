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
    
    public var linkBody: some View {
        Group {
            NavigationLink(
                destination: route(PreLoginRouters.login(entity: nil)),
                isActive: $navigationState.navigateToLogin
            ) {
                EmptyView()
            }
            /*
             LoginView(entity: LoginEntity()
             
            NavigationLink(
                destination: RegisterView(),
                isActive: $navigationState.navigateToRegister
            ) {
                EmptyView()
            }
             */
        }
    }
}
