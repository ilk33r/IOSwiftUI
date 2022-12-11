// 
//  RegisterUserNameView.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared
import SwiftUISampleAppPresentation

public struct RegisterUserNameView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterUserNamePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterUserNamePresenter
    @StateObject public var navigationState = RegisterUserNameNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        Text("RegisterUserName")
//            .navigationWireframe {
//                RegisterUserNameNavigationWireframe(navigationState: navigationState)
//            }
            .controllerWireframe {
                RegisterUserNameNavigationWireframe(navigationState: navigationState)
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
struct RegisterUserNameView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return RegisterUserNameView(entity: RegisterUserNameEntity(email: "ilker3@ilker.com"))
    }
}
#endif
