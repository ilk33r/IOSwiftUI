// 
//  RegisterProfileView.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct RegisterProfileView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterProfilePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterProfilePresenter
    @StateObject public var navigationState = RegisterProfileNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        Text("RegisterProfile")
//      .navigationWireframe {
//          RegisterProfileNavigationWireframe(navigationState: navigationState)
//      }
        .navigationBar {
            EmptyView()
        }
        .controllerWireframe {
            RegisterProfileNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct RegisterProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return RegisterProfileView(
            entity: RegisterProfileEntity(
                email: "",
                password: "",
                userName: ""
            )
        )
    }
}
#endif
