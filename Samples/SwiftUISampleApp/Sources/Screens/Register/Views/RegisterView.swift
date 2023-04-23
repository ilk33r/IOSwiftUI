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
    
    @IOInject private var appleSettings: IOAppleSetting
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterPresenter
    @StateObject public var navigationState = RegisterNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var emailText = ""
    
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
                            .inputEmailAddress,
                            text: $emailText
                        )
                        .disableCorrection(true)
                        .capitalization(.none)
                        .keyboardType(.emailAddress)
                        .registerValidator(
                            to: validator,
                            rule: IOValidationEmailRule(errorMessage: .inputErrorEmail)
                        )
                        .padding(.top, 32)
                        
                        PrimaryButton(.commonNextUppercased)
                            .setClick {
                                if validator.validate().isEmpty {
                                    Task {
                                        await presenter.checkMember(email: emailText)
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
            RegisterNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            #if DEBUG
            emailText = appleSettings.string(for: .debugDefaultUserName) ?? ""
            #endif
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    
    struct RegisterViewDemo: View {
        
        var body: some View {
            RegisterView(
                entity: RegisterEntity()
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return RegisterViewDemo()
    }
}
#endif
