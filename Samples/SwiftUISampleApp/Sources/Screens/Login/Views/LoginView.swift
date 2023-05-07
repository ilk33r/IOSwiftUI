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
    
    @IOInject private var appleSettings: IOAppleSetting
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: LoginPresenter
    @StateObject public var navigationState = LoginNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var emailText: String = ""
    
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
                        
                        FloatingTextField(
                            .inputEmailAddress,
                            text: $emailText,
                            validationId: "emailText"
                        )
                        .disableCorrection(true)
                        .capitalization(.none)
                        .keyboardType(.emailAddress)
                        .registerValidator(
                            to: validator,
                            rule: IOValidationEmailRule(
                                errorMessage: .inputErrorEmail
                            )
                        )
                        .padding(.top, 32)
                        PrimaryButton(.commonNextUppercased)
                            .setClick({
                                if validator.validate().isEmpty {
                                    Task {
                                        await presenter.checkMember(email: emailText)
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
            LoginNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            emailText = appleSettings.string(for: .debugDefaultUserName) ?? ""
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    
    struct LoginViewDemo: View {
        
        var body: some View {
            LoginView(
                entity: LoginEntity()
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return LoginViewDemo()
    }
}
#endif
