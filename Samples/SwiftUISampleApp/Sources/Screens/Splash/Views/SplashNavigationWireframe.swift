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

public struct SplashNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: SplashNavigationState
    
    // MARK: - Properties
    
    public var linkBody: some View {
        Group {
            NavigationLink(
                destination: LoginView(entity: LoginEntity()),
                isActive: $navigationState.navigateToLogin
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: RegisterView(),
                isActive: $navigationState.navigateToRegister
            ) {
                EmptyView()
            }
        }
    }
}
