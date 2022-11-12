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
    
    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    @State private var formOTPText = ""
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                ScrollView {
                    IOFormGroup(.commonDone, handler: {
                    }, content: {
                        VStack(alignment: .leading) {
                            Text(type: .sendOTPHeaderDescription.format("+905335433836"))
                                .font(type: .regular(16))
                                .padding(.horizontal, 24)
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
        .alertView(isPresented: $navigationState.showAlert.value) { navigationState.alertData }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct SendOTPView_Previews: PreviewProvider {
    static var previews: some View {
        SendOTPView(entity: SendOTPEntity())
    }
}
