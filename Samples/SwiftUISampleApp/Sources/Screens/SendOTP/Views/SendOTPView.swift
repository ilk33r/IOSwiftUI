// 
//  SendOTPView.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

public struct SendOTPView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SendOTPPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SendOTPPresenter
    @StateObject public var navigationState = SendOTPNavigationState()
    
    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    // MARK: - Body
    
    public var body: some View {
        Text("SendOTP")
//            .navigationWireframe {
//                SendOTPNavigationWireframe(navigationState: navigationState)
//            }
            .controllerWireframe {
                SendOTPNavigationWireframe(navigationState: navigationState)
            }
            .alertView(isPresented: $navigationState.showAlert.value) { navigationState.alertData }
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

struct SendOTPView_Previews: PreviewProvider {
    static var previews: some View {
        SendOTPView(entity: SendOTPEntity())
    }
}
