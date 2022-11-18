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
import SwiftUISampleAppScreensShared
import SwiftUISampleAppPresentation

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
            ZStack {
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
                                SecureFloatingTextField(.changePasswordFormCurrentPassword, text: $formCurrentPassword)
                                    .registerValidator(to: validator, rule: IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 4))
                                SecureFloatingTextField(.changePasswordFormNewPassword, text: $formNewPassword)
                                    .registerValidator(
                                        to: validator,
                                        rules: [
                                            IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 4),
                                            IOValidationExactRule(errorMessage: .changePasswordValidationPasswordDoNotMatch, compare: $formConfirmPassword)
                                        ]
                                    )
                                SecureFloatingTextField(.changePasswordFormConfirmPassword, text: $formConfirmPassword)
                                    .registerValidator(
                                        to: validator,
                                        rules: [
                                            IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 4),
                                            IOValidationExactRule(errorMessage: .changePasswordValidationPasswordDoNotMatch, compare: $formNewPassword)
                                        ]
                                    )
                                PrimaryButton(.commonNextUppercased)
                                    .setClick({
                                        if validator.validate().isEmpty {
                                            showSendOTP = true
                                        }
                                    })
                                    .padding(.top, 16)
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 8.0)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .changePasswordTitle,
                    iconName: "lock.fill",
                    width: 12
                )
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        //            .navigationWireframe {
        //                ChangePasswordNavigationWireframe(navigationState: navigationState)
        //            }
        .controllerWireframe {
            ChangePasswordNavigationWireframe(navigationState: navigationState)
        }
        .sheet(
            isPresented: $showSendOTP,
            onDismiss: {
                navigationState.sendOTPDismissed()
            }, content: {
                navigationState.createSendOTPView(
                    showSendOTP: $showSendOTP,
                    isOTPValidated: $isOTPValidated,
                    phoneNumber: presenter.interactor.entity.phoneNumber
                )
            }
        )
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
            }
        }
        .onReceive(presenter.$navigateToBack) { output in
            if output ?? false {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onChange(of: isOTPValidated) { newValue in
            if newValue {
                presenter.interactor.changePassword(
                    oldPassword: formCurrentPassword,
                    newPassword: formNewPassword
                )
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return ChangePasswordView(
            entity: ChangePasswordEntity(
                phoneNumber: "905335433836"
            )
        )
    }
}
