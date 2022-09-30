// 
//  LoginView.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import IOSwiftUIComponents
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppComponents
import SwiftUISampleAppPresentation

struct LoginView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = LoginPresenter
    
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
    
    var body: some View {
        IOFormGroup(.commonDone, handler: {

        }, content: {
            VStack(alignment: .leading) {
                Text(type: .loginTitle)
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
//                            appEnvironment.isLoggedIn = true
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
        .onAppear {
            if !self.isPreviewMode {
                self.presenter.environment = _appEnvironment
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(entity: LoginEntity())
    }
}
