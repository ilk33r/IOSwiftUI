// 
//  SendOTPView.swift
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

public struct SendOTPView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SendOTPPresenter
    
    // MARK: - DI
    
    @IOInstance private var validator: IOValidator
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SendOTPPresenter
    @StateObject public var navigationState = SendOTPNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var formOTPText = ""
    @State private var progressIsActive = false
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                ScrollView {
                    IOFormGroup(.commonDone, handler: {
                    }, content: {
                        VStack(alignment: .leading) {
                            Text(type: .sendOTPHeaderDescription.format(presenter.uiModel?.phoneNumber ?? ""))
                                .font(type: .regular(16))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .padding(.top, 16)
                                .padding(.bottom, 24)
                                .frame(width: proxy.size.width - 32, alignment: .center)
                            
                            OTPTextField(text: $formOTPText)
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationExactLengthRule(
                                        errorMessage: .validationRequiredMessage,
                                        length: 6
                                    )
                                )
                            
                            ZStack(alignment: .center) {
                                RoundedProgressView(
                                    secondsLeft: presenter.uiModel?.otpTimeout ?? 90,
                                    isActive: $progressIsActive
                                ) {
                                    presenter.updateOTPTimeout()
                                }
                                .frame(width: 80, height: 80)
                                .padding(.vertical, 24)
                            }
                            .frame(maxWidth: .infinity)
                            
                            PrimaryButton(.commonNextUppercased)
                                .setClick({
                                    if validator.validate().isEmpty {
                                        //                                            presenter.interactor.updateMember(
                                        //                                                userName: formUserNameText,
                                        //                                                birthDate: formBirthDate,
                                        //                                                email: formEmailText,
                                        //                                                name: formNameText,
                                        //                                                surname: formSurnameText,
                                        //                                                locationName: formLocationName,
                                        //                                                locationLatitude: formLocationLatitude,
                                        //                                                locationLongitude: formLocationLongitude,
                                        //                                                phoneNumber: formPhoneText.trimLetters()
                                        //                                            )
                                    } else {
                                        formOTPText = ""
                                    }
                                })
                                .padding(.top, 16)
                        }
                        .padding(.horizontal, 16.0)
                        .padding(.vertical, 8.0)
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                HStack {
                    Text(type: .sendOTPTitle)
                        .font(type: .systemSemibold(17))
                }
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .navigationWireframe {
            SendOTPNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
                presenter.interactor.otpSend()
            }
        }
        .onReceive(presenter.$uiModel) { newValue in
            if newValue != nil {
                progressIsActive = true
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct SendOTPView_Previews: PreviewProvider {
    
    struct SendOTPViewDemo: View {
        
        @State private var isPresented = false
        
        var body: some View {
            SendOTPView(
                entity: SendOTPEntity(
                    isPresented: $isPresented,
                    phoneNumber: "905335433836"
                )
            )
        }
    }
    
    static var previews: some View {
        SendOTPViewDemo()
    }
}
