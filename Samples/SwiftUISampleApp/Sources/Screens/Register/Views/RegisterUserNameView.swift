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
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct RegisterUserNameView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterUserNamePresenter
    
    // MARK: - DI
    
    @IOInject private var appleSettings: IOAppleSetting
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterUserNamePresenter
    @StateObject public var navigationState = RegisterUserNameNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var userNameText = ""
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
                IOFormGroup(.commonDone) {
                } content: {
                    VStack(alignment: .leading) {
                        
                        Text(type: .title)
                            .foregroundColor(.black)
                            .font(type: .regular(36))
                            .multilineTextAlignment(.leading)
                        
                        FloatingTextField(
                            .inputUserName,
                            text: $userNameText
                        )
                        .disableCorrection(true)
                        .capitalization(.none)
                        .keyboardType(.asciiCapable)
                        .registerValidator(
                            to: validator,
                            rules: [
                                IOValidationRequiredRule(errorMessage: .inputErrorUserName),
                                IOValidationAlphaNumericRule(errorMessage: .inputErrorUserName)
                            ]
                        )
                        .padding(.top, 32)
                        
                        PrimaryButton(.commonNextUppercased)
                            .setClick {
                                if validator.validate().isEmpty {
                                    Task {
                                        await presenter.checkUserName(userName: userNameText)
                                    }
                                }
                            }
                            .padding(.top, 16)
                        
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                }
                
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
            RegisterUserNameNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            #if DEBUG
            let defaultEmail = appleSettings.string(for: .debugDefaultUserName) ?? ""
            let emailParts = defaultEmail.components(separatedBy: "@")
            userNameText = emailParts.first ?? ""
            #endif
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
    
    struct RegisterUserNameViewDemo: View {
        
        var body: some View {
            RegisterUserNameView(
                entity: RegisterUserNameEntity(email: "")
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return RegisterUserNameViewDemo()
    }
}
#endif
