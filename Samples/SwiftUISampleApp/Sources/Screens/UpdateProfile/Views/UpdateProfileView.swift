// 
//  UpdateProfileView.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Combine
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import SwiftUISampleAppPresentation

public struct UpdateProfileView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = UpdateProfilePresenter
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    private let phoneNumberPattern = "+## (###) ### ## ##"
    
    @ObservedObject public var presenter: UpdateProfilePresenter
    @StateObject public var navigationState = UpdateProfileNavigationState()
    
    @State private var isOTPValidated = false
    @State private var showSendOTP = false
    @State private var showLocationSelection = false
    
    @State private var formUserNameText = ""
    @State private var formEmailText = ""
    @State private var formNameText = ""
    @State private var formSurnameText = ""
    @State private var formBirthDate: Date?
    @State private var formPhoneText = ""
    @State private var formLocationName = ""
    @State private var formLocationLatitude: Double?
    @State private var formLocationLongitude: Double?
    
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        EmptyView()
        /*
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
                        IOFormGroup(.commonDone, handler: {
                        }, content: {
                            VStack(alignment: .leading) {
                                FloatingTextField(.updateProfileFormUserName, text: $formUserNameText)
                                    .disabled(true)
                                FloatingTextField(.updateProfileFormEmail, text: $formEmailText)
                                    .disabled(true)
                                FloatingTextField(.updateProfileFormName, text: $formNameText)
                                    .registerValidator(to: validator, rule: IOValidationRequiredRule(errorMessage: .validationRequiredMessage))
                                FloatingTextField(.updateProfileFormSurname, text: $formSurnameText)
                                    .registerValidator(to: validator, rule: IOValidationRequiredRule(errorMessage: .validationRequiredMessage))
                                FloatingDatePicker(.updateProfileFormBirthdate, date: $formBirthDate)
                                    .registerValidator(to: validator, rule: IOValidationRequiredRule(errorMessage: .validationRequiredMessage))
                                FloatingTextField(.updateProfileFormPhone, text: $formPhoneText)
                                    .keyboardType(.numberPad)
                                    .registerValidator(to: validator, rule: IOValidationMinLengthRule(errorMessage: .validationRequiredMessage, length: 19))
                                FloatingTextField(.updateProfileFormLocation, text: $formLocationName)
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
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 8.0)
                        })
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .updateProfileTitle,
                    iconName: "person.fill"
                )
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
         */
        /*
        .controllerWireframe {
            UpdateProfileNavigationWireframe(navigationState: navigationState)
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
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.load()
        }
        .onReceive(presenter.$uiModel) { output in
            guard let output else { return }
            
            formUserNameText = output.userName
            formEmailText = output.email
            formNameText = output.name
            formSurnameText = output.surname
            formBirthDate = output.birthDate
            formPhoneText = output.phone.applyPattern(pattern: phoneNumberPattern)
            formLocationName = output.locationName
            formLocationLatitude = output.locationLatitude
            formLocationLongitude = output.locationLongitude
        }
        .onReceive(presenter.$navigateToBack) { output in
            if output ?? false {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onChange(of: formPhoneText) { newValue in
            let plainNumber = newValue.trimLetters()
            formPhoneText = plainNumber.applyPattern(pattern: phoneNumberPattern)
        }
        .onChange(of: isOTPValidated) { newValue in
            if newValue {
                presenter.interactor.updateMember(
                    userName: formUserNameText,
                    birthDate: formBirthDate,
                    email: formEmailText,
                    name: formNameText,
                    surname: formSurnameText,
                    locationName: formLocationName,
                    locationLatitude: formLocationLatitude,
                    locationLongitude: formLocationLongitude,
                    phoneNumber: formPhoneText.trimLetters()
                )
            }
        }
         */
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView(
            entity: UpdateProfileEntity(
                member: MemberModel()
            )
        )
    }
}
#endif
