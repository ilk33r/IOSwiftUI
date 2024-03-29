// 
//  LoginPasswordView.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct LoginPasswordView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = LoginPasswordPresenter
    
    // MARK: - DI
    
    @IOInject private var appleSettings: IOAppleSetting
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: LoginPasswordPresenter
    @StateObject public var navigationState = LoginPasswordNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var passwordText: String = ""
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
                IOFormGroup(.commonDone, handler: {

                }, content: {
                    VStack(alignment: .leading) {
                        Text(type: .title)
                            .foregroundColor(.black)
                            .font(type: .regular(36))
                            .multilineTextAlignment(.leading)
                        SecureFloatingTextField(
                            .inputPassword,
                            text: $passwordText,
                            validationId: "passwordText"
                        )
                        .registerValidator(
                            to: validator,
                            rule: IOValidationMinLengthRule(
                                errorMessage: .inputErrorPassword, length: 4
                            )
                        )
                        .padding(.top, 16)
                        PrimaryButton(.commonNextUppercased)
                            .setClick({
                                if validator.validate().isEmpty {
                                    Task {
                                        await presenter.login(password: passwordText)
                                    }
                                }
                            })
                            .padding(.top, 16)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                })
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                EmptyView()
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            LoginPasswordNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            passwordText = appleSettings.string(for: .debugDefaultPassword) ?? ""
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct LoginPasswordView_Previews: PreviewProvider {
    
    struct LoginPasswordViewDemo: View {
        
        var body: some View {
            LoginPasswordView(
                entity: LoginPasswordEntity(
                    email: "ilker4@ilker.com"
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return LoginPasswordViewDemo()
    }
}
#endif
