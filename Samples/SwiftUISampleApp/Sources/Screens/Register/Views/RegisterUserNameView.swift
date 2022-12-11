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
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterUserNamePresenter
    @StateObject public var navigationState = RegisterUserNameNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    #if DEBUG
    @State private var userNameText = "ilker4"
    #else
    @State private var userNameText = ""
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
                    .registerInputUserName,
                    text: $userNameText
                )
                .disableCorrection(true)
                .capitalization(.none)
                .keyboardType(.asciiCapable)
                .registerValidator(
                    to: validator,
                    rules: [
                        IOValidationRequiredRule(errorMessage: .registerInputErrorUserName),
                        IOValidationAlphaNumericRule(errorMessage: .registerInputErrorUserName)
                    ]
                )
                .padding(.top, 32)
                PrimaryButton(.commonNextUppercased)
                    .setClick({
                        if validator.validate().isEmpty {
                            presenter.interactor.checkUserName(userName: userNameText)
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
            RegisterUserNameNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
            }
        }
        .onChange(of: userNameText) { newValue in
            userNameText = newValue.trimNonAlphaNumericCharacters()
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
        return RegisterUserNameView(entity: RegisterUserNameEntity(email: ""))
    }
}
#endif
