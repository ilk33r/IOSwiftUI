// 
//  RegisterCreatePasswordView.swift
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

public struct RegisterCreatePasswordView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterCreatePasswordPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterCreatePasswordPresenter
    @StateObject public var navigationState = RegisterCreatePasswordNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        Text("RegisterCreatePassword")
//      .navigationWireframe {
//          RegisterCreatePasswordNavigationWireframe(navigationState: navigationState)
//      }
        .navigationBar {
            EmptyView()
        }
        .controllerWireframe {
            RegisterCreatePasswordNavigationWireframe(navigationState: navigationState)
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
struct RegisterCreatePasswordView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return RegisterCreatePasswordView(
            entity: RegisterCreatePasswordEntity(
                email: "",
                password: "",
                userName: "",
                validate: false
            )
        )
    }
}
#endif
