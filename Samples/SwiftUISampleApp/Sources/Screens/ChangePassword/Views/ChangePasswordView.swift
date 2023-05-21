// 
//  ChangePasswordView.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct ChangePasswordView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = ChangePasswordPresenter
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ChangePasswordPresenter
    @StateObject public var navigationState = ChangePasswordNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var showSendOTP = false
    @State private var isOTPValidated = false
    
    @State private var formCurrentPassword = ""
    @State private var formConfirmPassword = ""
    @State private var formNewPassword = ""
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOUIView { lifecycle in
                    if lifecycle == .willAppear {
                        presenter.hideTabBar()
                    } else if lifecycle == .willDisappear {
                        presenter.showTabBar()
                    }
                } content: {
                    ScrollView {
                        IOFormGroup(.commonDone) {
                        } content: {
                            VStack(alignment: .leading) {
                                SecureFloatingTextField(.formCurrentPassword, text: $formCurrentPassword)
                                    .registerValidator(to: validator, rule: IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 4))
                                SecureFloatingTextField(.formNewPassword, text: $formNewPassword)
                                    .registerValidator(
                                        to: validator,
                                        rules: [
                                            IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 4),
                                            IOValidationExactRule(errorMessage: .validationPasswordDoNotMatch, compare: $formConfirmPassword)
                                        ]
                                    )
                                SecureFloatingTextField(.formConfirmPassword, text: $formConfirmPassword)
                                    .registerValidator(
                                        to: validator,
                                        rules: [
                                            IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 4),
                                            IOValidationExactRule(errorMessage: .validationPasswordDoNotMatch, compare: $formNewPassword)
                                        ]
                                    )
                                PrimaryButton(.commonNextUppercased)
                                    .setClick({
                                        if validator.validate().isEmpty {
                                            navigationState.createSendOTPView(
                                                showSendOTP: $showSendOTP,
                                                isOTPValidated: $isOTPValidated,
                                                phoneNumber: presenter.interactor.entity.phoneNumber
                                            )
                                        }
                                    })
                                    .padding(.top, 16)
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 8.0)
                        }
                    }
                }
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .title,
                    iconName: "lock.fill",
                    width: 12
                )
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            ChangePasswordNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
        }
        .onReceive(presenter.$navigateToBack) { output in
            if output ?? false {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onChange(of: isOTPValidated) { newValue in
            if newValue {
                Task {
                    await presenter.changePassword(
                        oldPassword: formCurrentPassword,
                        newPassword: formNewPassword
                    )
                }
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct ChangePasswordView_Previews: PreviewProvider {
    
    struct ChangePasswordViewDemo: View {
        
        var body: some View {
            ChangePasswordView(
                entity: ChangePasswordPreviewData.previewData
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ChangePasswordViewDemo()
    }
}
#endif
