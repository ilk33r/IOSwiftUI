// 
//  RegisterView.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

public struct RegisterView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterPresenter
    @StateObject public var navigationState = RegisterNavigationState()
    
    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    // MARK: - Body
    
    public var body: some View {
        Text("Register")
//            .navigationWireframe {
//                RegisterNavigationWireframe(navigationState: navigationState)
//            }
            .controllerWireframe {
                RegisterNavigationWireframe(navigationState: navigationState)
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
struct RegisterView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return RegisterView(entity: RegisterEntity())
    }
}
#endif
