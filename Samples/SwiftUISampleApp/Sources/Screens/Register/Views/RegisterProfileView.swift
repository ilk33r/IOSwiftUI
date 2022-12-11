// 
//  RegisterProfileView.swift
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

public struct RegisterProfileView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterProfilePresenter
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    private let phoneNumberPattern = "+## (###) ### ## ##"
    
    @ObservedObject public var presenter: RegisterProfilePresenter
    @StateObject public var navigationState = RegisterProfileNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var isOTPValidated = false
    @State private var showSendOTP = false
    @State private var showLocationSelection = false
    
    @State private var formUserNameText = ""
    @State private var formEmailText = ""
    @State private var formNameText = ""
    @State private var formSurnameText = ""
    @State private var formPhoneText = ""
    @State private var formLocationName = ""
    @State private var formBirthDate: Date?
    @State private var formLocationLatitude: Double?
    @State private var formLocationLongitude: Double?
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                ScrollView {
                    IOFormGroup(.commonDone, handler: {
                    }, content: {
                        VStack(alignment: .leading) {
                            FloatingTextField(.registerInputUserName, text: $formUserNameText)
                                .disabled(true)
                            FloatingTextField(.registerInputEmailAddress, text: $formEmailText)
                                .disabled(true)
                            FloatingTextField(.registerFormName, text: $formNameText)
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationRequiredRule(errorMessage: .validationRequiredMessage)
                                )
                            FloatingTextField(.registerFormSurname, text: $formSurnameText)
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationRequiredRule(errorMessage: .validationRequiredMessage)
                                )
                            FloatingDatePicker(.registerFormBirthDate, date: $formBirthDate)
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationRequiredRule(errorMessage: .validationRequiredMessage)
                                )
                            FloatingTextField(.registerFormPhone, text: $formPhoneText)
                                .keyboardType(.numberPad)
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 19)
                                )
                            FloatingTextField(.registerFormLocation, text: $formLocationName)
                                .disabled(true)
                                .setClick {
                                    showLocationSelection = true
                                }
                            PrimaryButton(.commonNextUppercased)
                                .setClick({
                                    if validator.validate().isEmpty {
                                        showSendOTP = true
                                    }
                                })
                                .padding(.top, 16)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    })
                }
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                HStack {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 4)
                            .padding(.leading, -8)
                        Text(type: .registerTitleProfile)
                            .font(type: .medium(17))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.leading, 32)
                    .padding(.trailing, 32)
                    .frame(width: proxy.size.width - 108)
                    Button {
                        
                    } label: {
                        Image(systemName: "wave.3.right")
                    }
                    .foregroundColor(.black)
                    .frame(width: 32)
                }
            }
        }
        .controllerWireframe {
            RegisterProfileNavigationWireframe(navigationState: navigationState)
        }
        .sheet(isPresented: $showLocationSelection) {
            IORouterUtilities.route(
                ProfileRouters.self,
                .userLocation(
                    entity: UserLocationEntity(
                        isEditable: true,
                        isPresented: $showLocationSelection,
                        locationName: $formLocationName,
                        locationLatitude: $formLocationLatitude,
                        locationLongitude: $formLocationLongitude
                    )
                )
            )
        }
        .sheet(
            isPresented: $showSendOTP,
            onDismiss: {
                navigationState.sendOTPDismissed()
            }, content: {
                navigationState.createSendOTPView(
                    showSendOTP: $showSendOTP,
                    isOTPValidated: $isOTPValidated,
                    phoneNumber: formPhoneText.trimLetters()
                )
            }
        )
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
                presenter.prepare()
            }
        }
        .onChange(of: formPhoneText) { newValue in
            let plainNumber = newValue.trimLetters()
            formPhoneText = plainNumber.applyPattern(pattern: phoneNumberPattern)
        }
        .onReceive(presenter.$userEmail) { output in
            formEmailText = output
        }
        .onReceive(presenter.$userName) { output in
            formUserNameText = output
        }
        .onChange(of: isOTPValidated) { newValue in
            if newValue {
                
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct RegisterProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return RegisterProfileView(
            entity: RegisterProfileEntity(
                email: "",
                password: "",
                userName: ""
            )
        )
    }
}
#endif
