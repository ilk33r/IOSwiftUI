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
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct RegisterView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterPresenter
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterPresenter
    @StateObject public var navigationState = RegisterNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    #if DEBUG
    @State private var emailText = "ilker4@ilker.com"
    #else
    @State private var emailText = ""
    #endif
    
    // MARK: - Body
    
    public var body: some View {
        IOFormGroup(.commonDone) {
        } content: {
            VStack(alignment: .leading) {
                Text(type: .registerTitle)
                    .foregroundColor(.black)
                    .font(type: .regular(36))
                    .multilineTextAlignment(.leading)
                FloatingTextField(
                    .registerInputEmailAddress,
                    text: $emailText
                )
                .disableCorrection(true)
                .capitalization(.none)
                .keyboardType(.emailAddress)
                .registerValidator(
                    to: validator,
                    rule: IOValidationEmailRule(errorMessage: .registerInputErrorEmail)
                )
                .padding(.top, 32)
                PrimaryButton(.commonNextUppercased)
                    .setClick({
                        if validator.validate().isEmpty {
                            presenter.interactor.checkMember(email: emailText)
                        }
                    })
                    .padding(.top, 16)
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        }
        .navigationBar {
            EmptyView()
        }
        .controllerWireframe {
            RegisterNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
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
