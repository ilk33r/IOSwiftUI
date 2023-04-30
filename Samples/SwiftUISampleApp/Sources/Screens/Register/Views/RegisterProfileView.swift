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
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct RegisterProfileView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterProfilePresenter
    
    // MARK: - DI
    
    @IOInject private var validator: IOValidator
    @IOInject private var bottomSheetPresenter: IOBottomSheetPresenter
    
    // MARK: - Properties
    
    private let phoneNumberPattern = "+## (###) ### ## ##"
    
    @ObservedObject public var presenter: RegisterProfilePresenter
    @StateObject public var navigationState = RegisterProfileNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var isOTPValidated = false
    
    @State private var formUserNameText = ""
    @State private var formEmailText = ""
    @State private var formNameText = ""
    @State private var formSurnameText = ""
    @State private var formPhoneText = ""
    @State private var formLocationName = ""
    @State private var formBirthDate = ""
    @State private var formLocationLatitude: Double?
    @State private var formLocationLongitude: Double?
    
    @State private var profilePictureImageView = Image(systemName: "person.crop.circle")
    
    @State private var formBirthDateSelectedDate: Date?
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
                ScrollView {
                    IOFormGroup(.commonDone) {
                    } content: {
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                profilePictureImageView
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 56, height: 56, alignment: .topLeading)
                                    .clipShape(Circle())
                                    .setClick {
                                        presenter.showActionSheet()
                                    }
                            }
                            .padding(.bottom, 8)
                            
                            FloatingTextField(
                                .inputUserName,
                                text: $formUserNameText
                            )
                            .disabled(true)
                            
                            FloatingTextField(
                                .inputEmailAddress,
                                text: $formEmailText
                            )
                            .disabled(true)
                            
                            FloatingTextField(
                                .formName,
                                text: $formNameText,
                                validationId: "formNameText"
                            )
                            .registerValidator(
                                to: validator,
                                rule: IOValidationRequiredRule(
                                    errorMessage: .validationRequiredMessage
                                )
                            )
                            
                            FloatingTextField(
                                .formSurname,
                                text: $formSurnameText,
                                validationId: "formSurnameText"
                            )
                            .registerValidator(
                                to: validator,
                                rule: IOValidationRequiredRule(
                                    errorMessage: .validationRequiredMessage
                                )
                            )
                            
                            FloatingTextField(
                                .formBirthDate,
                                text: $formBirthDate,
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
                                        selectedItemString: $formBirthDate
                                    )
                                }
                            }
                            
                            FloatingTextField(
                                .formPhone,
                                text: $formPhoneText,
                                validationId: "formPhoneText"
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
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                RegisterNavigationBar(
                    proxy: proxy
                ) {
                    showNFCBottomSheet()
                }
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            RegisterProfileNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.prepare()
        }
        .onDisappear {
            presenter.dismissPicker()
        }
        .actionSheet(data: $presenter.actionSheetData)
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
        .onReceive(presenter.$name) { output in
            formNameText = output
        }
        .onReceive(presenter.$surname) { output in
            formSurnameText = output
        }
        .onReceive(presenter.$birthDate) { output in
            if let birthDate = output {
                formBirthDate = birthDate
                presenter.dismissPicker()
            }
        }
        .onReceive(presenter.$locationName) { output in
            formLocationName = output
        }
        .onReceive(presenter.$profilePictureImage) { output in
            if let uiImage = output {
                profilePictureImageView = Image(uiImage: uiImage)
            }
        }
        .onReceive(navigationState.$pickedImage) { output in
            if let image = output {
                presenter.updateProfilePicture(image: image)
            }
        }
        .onChange(of: isOTPValidated) { newValue in
            if newValue {
                Task {
                    await presenter.createProfile(
                        birthDate: formBirthDateSelectedDate,
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
    
    // MARK: - Helper Methods
    
    private func showNFCBottomSheet() {
        bottomSheetPresenter.show {
            IOBottomSheetView {
                RegisterNFCBottomSheetView {
                    bottomSheetPresenter.dismiss()
                    navigationState.navigateToMRZReader = true
                }
            }
        }
    }
}

#if DEBUG
struct RegisterProfileView_Previews: PreviewProvider {
    
    struct RegisterProfileViewDemo: View {
        
        var body: some View {
            RegisterProfileView(
                entity: RegisterProfileEntity(
                    email: "",
                    password: "",
                    userName: ""
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return RegisterProfileViewDemo()
    }
}
#endif
