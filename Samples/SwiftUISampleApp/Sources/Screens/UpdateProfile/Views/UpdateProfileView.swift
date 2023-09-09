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
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct UpdateProfileView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = UpdateProfilePresenter
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    
    // MARK: - Properties
    
    private let phoneNumberPattern = "+## (###) ### ## ##"
    
    @ObservedObject public var presenter: UpdateProfilePresenter
    @StateObject public var navigationState = UpdateProfileNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var isOTPValidated = false
    
    @State private var formUserNameText = ""
    @State private var formEmailText = ""
    @State private var formNameText = ""
    @State private var formSurnameText = ""
    @State private var formBirthDateString = ""
    @State private var formPhoneText = ""
    @State private var formLocationName = ""
    @State private var formLocationLatitude: Double?
    @State private var formLocationLongitude: Double?
    
    @State private var formBirthDateSelectedDate: Date?
    
    @Environment(\.presentationMode) private var presentationMode
    
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
                        IOFormGroup(.commonDone, handler: {
                        }, content: {
                            VStack(alignment: .leading) {
                                FloatingTextField(
                                    .formUserName,
                                    text: $formUserNameText
                                )
                                .disabled(true)
                                
                                FloatingTextField(
                                    .formEmail,
                                    text: $formEmailText
                                )
                                .disabled(true)
                                
                                FloatingTextField(
                                    .formName,
                                    text: $formNameText
                                )
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationRequiredRule(
                                        errorMessage: .validationRequiredMessage
                                    )
                                )
                                
                                FloatingTextField(
                                    .formSurname,
                                    text: $formSurnameText
                                )
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationRequiredRule(
                                        errorMessage: .validationRequiredMessage
                                    )
                                )
                                
                                FloatingTextField(
                                    .formBirthdate,
                                    text: $formBirthDateString,
                                    validationId: "formBirthDate"
                                )
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationRequiredRule(
                                        errorMessage: .validationRequiredMessage
                                    )
                                )
                                .disabled(true)
                                .setClick {
                                    presenter.showDatePicker {
                                        IODatePickerData(
                                            doneButtonTitle: .commonDone,
                                            dateFormat: CommonConstants.pickerDateFormat,
                                            selectedItem: $formBirthDateSelectedDate,
                                            selectedItemString: $formBirthDateString
                                        )
                                    }
                                }
                                
                                FloatingTextField(
                                    .formPhone,
                                    text: $formPhoneText
                                )
                                .keyboardType(.numberPad)
                                .registerValidator(
                                    to: validator,
                                    rule: IOValidationMinLengthRule(
                                        errorMessage: .validationRequiredMessage,
                                        length: 19
                                    )
                                )
                                
                                FloatingTextField(
                                    .formLocation,
                                    text: $formLocationName
                                )
                                .disabled(true)
                                .setClick {
                                    navigationState.showLocationSelection(
                                        isPresented: $navigationState.showLocationSelection,
                                        locationName: $formLocationName,
                                        locationLatitude: $formLocationLatitude,
                                        locationLongitude: $formLocationLongitude
                                    )
                                }
                                
                                PrimaryButton(.commonNextUppercased)
                                    .setClick {
                                        if validator.validate().isEmpty {
                                            presenter.dismissPicker()
                                            navigationState.createSendOTPView(
                                                showSendOTP: $navigationState.showSendOTP,
                                                isOTPValidated: $isOTPValidated,
                                                phoneNumber: formPhoneText.trimLetters()
                                            )
                                        }
                                    }
                                    .padding(.top, 16)
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 8.0)
                        })
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
                    iconName: "person.fill",
                    hasBackButton: true
                )
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            UpdateProfileNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                presenter.prepare()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.prepare()
        }
        .onDisappear {
            presenter.dismissPicker()
        }
        .onReceive(presenter.$uiModel) { output in
            guard let output else { return }
            
            formUserNameText = output.userName
            formEmailText = output.email
            formNameText = output.name
            formSurnameText = output.surname
            formBirthDateString = output.birthDate?.string(format: IOModelDateTimeTransformer.iso8601DateFormat) ?? ""
            formPhoneText = output.phone.applyPattern(pattern: phoneNumberPattern)
            formLocationName = output.locationName
            formLocationLatitude = output.locationLatitude
            formLocationLongitude = output.locationLongitude
            
            formBirthDateSelectedDate = output.birthDate
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
                Task {
                    await presenter.updateMember(
                        userName: formUserNameText,
                        birthDate: formBirthDateSelectedDate,
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
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct UpdateProfileView_Previews: PreviewProvider {
    
    struct UpdateProfileViewDemo: View {
        
        var body: some View {
            UpdateProfileView(
                entity: UpdateProfilePreviewData.previewData()
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return UpdateProfileViewDemo()
    }
}
#endif
