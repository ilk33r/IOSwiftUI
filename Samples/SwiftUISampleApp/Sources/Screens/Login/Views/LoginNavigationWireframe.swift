// 
//  LoginNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

struct LoginNavigationWireframe: IONavigationLinkView {
    
    public typealias AppEnvironment = SampleAppEnvironment
    
    // MARK: - States
    
    public var appEnvironment: EnvironmentObject<SampleAppEnvironment>!
    @ObservedObject var navigationState: LoginNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        EmptyView()
        /*
        NavigationLink(
            destination: route(IORouter.sef, .sample(entity: navigationState.sampleEntity)),
            isActive: $navigationState.navigateToPage
        ) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: LoginNavigationState) {
        self.navigationState = navigationState
    }
}
