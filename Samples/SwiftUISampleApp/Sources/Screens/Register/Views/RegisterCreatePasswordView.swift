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
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterCreatePasswordPresenter
    @StateObject public var navigationState = RegisterCreatePasswordNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    #if DEBUG
    @State private var password = "12345678"
    #else
    @State private var password = ""
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
                SecureFloatingTextField(presenter.interactor.entity.validate ? .registerInputPasswordReEnter : .registerInputPassword, text: $password)
                    .disableCorrection(true)
                    .capitalization(.none)
                    .registerValidator(
                        to: validator,
                        rule: IOValidationMinLengthRule(
                            errorMessage: .registerInputErrorPasswordLength,
                            length: 8
                        )
                    )
                PrimaryButton(.commonNextUppercased)
                    .setClick({
                        if validator.validate().isEmpty {
                            presenter.validatePassword(password: password)
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
            RegisterCreatePasswordNavigationWireframe(navigationState: navigationState)
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
