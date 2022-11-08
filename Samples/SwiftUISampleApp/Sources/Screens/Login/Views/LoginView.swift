// 
//  LoginView.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct LoginView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = LoginPresenter
    
    // MARK: - DI
    
    @IOInstance private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: LoginPresenter
    @StateObject public var navigationState = LoginNavigationState()
    
    // MARK: - States
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    
    // MARK: - Body
    
    public var body: some View {
        IOFormGroup(.commonDone, handler: {

        }, content: {
            VStack(alignment: .leading) {
                Text(type: .loginTitle)
                    .foregroundColor(.black)
                    .font(type: .regular(36))
                    .multilineTextAlignment(.leading)
                FloatingTextField(
                    .loginInputEmailAddress,
                    text: $emailText
                )
                .disableCorrection(true)
                .capitalization(.none)
                .keyboardType(.emailAddress)
                .registerValidator(
                    to: validator,
                    rule: IOValidationEmailRule(errorMessage: .loginInputErrorEmail)
                )
                .padding(.top, 32)
                SecureFloatingTextField(
                    .loginInputPassword,
                    text: $passwordText
                )
                .registerValidator(
                    to: validator,
                    rule: IOValidationMinLengthRule(errorMessage: .loginInputErrorPassword, length: 4)
                )
                .padding(.top, 16)
                PrimaryButton(.commonNextUppercased)
                    .setClick({
                        if validator.validate().isEmpty {
                            presenter.interactor.login(email: emailText, password: passwordText)
                        }
                    })
                    .padding(.top, 16)
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        })
        .controllerWireframe {
            LoginNavigationWireframe(navigationState: navigationState)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(entity: LoginEntity())
    }
}
