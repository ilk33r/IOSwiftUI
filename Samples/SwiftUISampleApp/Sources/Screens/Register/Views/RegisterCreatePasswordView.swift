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
    
    @IOInject private var appleSettings: IOAppleSetting
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterCreatePasswordPresenter
    @StateObject public var navigationState = RegisterCreatePasswordNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var password = ""
    
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
                        
                        SecureFloatingTextField(presenter.interactor.entity.validate ? .inputPasswordReEnter : .inputPassword, text: $password)
                            .disableCorrection(true)
                            .capitalization(.none)
                            .registerValidator(
                                to: validator,
                                rule: IOValidationMinLengthRule(
                                    errorMessage: .inputErrorPasswordLength,
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
            RegisterCreatePasswordNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            #if DEBUG
            password = appleSettings.string(for: .debugDefaultPassword) ?? ""
            #endif
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct RegisterCreatePasswordView_Previews: PreviewProvider {
    
    struct RegisterCreatePasswordViewDemo: View {
        
        var body: some View {
            RegisterCreatePasswordView(
                entity: RegisterCreatePasswordEntity(
                    email: "",
                    password: "",
                    userName: "",
                    validate: false
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return RegisterCreatePasswordViewDemo()
    }
}
#endif
