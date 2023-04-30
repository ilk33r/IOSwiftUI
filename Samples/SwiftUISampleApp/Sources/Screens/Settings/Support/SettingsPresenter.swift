// 
//  SettingsPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUISupportBiometricAuthenticator
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class SettingsPresenter: IOPresenterable {
    
    // MARK: - Defs
    
    struct ActionSheetData: Identifiable {
        
        let id = UUID()
    }
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SettingsInteractor!
    public var navigationState: StateObject<SettingsNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var actionSheetData: ActionSheetData?
    @Published private(set) var menu: [SettingsMenuItemUIModel]
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.menu = []
    }
    
    // MARK: - Presenter
    
    func prepare() {
        self.menu = self.interactor.loadMenu()
    }
    
    @MainActor
    func navigate(menu: SettingsMenuItemUIModel) async {
        switch menu.type {
        case .updateProfile:
            self.navigationState.wrappedValue.updateProfileEntity = UpdateProfileEntity(
                member: self.interactor.entity.member
            )
            self.navigationState.wrappedValue.navigateToUpdateProfile = true
            
        case .updateProfilePicture:
            self.actionSheetData = ActionSheetData()
            
        case .removeProfilePicture:
            self.showAlert { [weak self] in
                IOAlertData(
                    title: nil,
                    message: .promptDeleteProfilePicture,
                    buttons: [.commonYes, .commonNo]
                ) { [weak self] index in
                    if index == 0 {
                        self?.interactor.deleteProfilePicture()
                    }
                }
            }
            
        case .changePassword:
            self.navigationState.wrappedValue.changePasswordEntity = ChangePasswordEntity(
                phoneNumber: self.interactor.entity.member.phoneNumber ?? ""
            )
            self.navigationState.wrappedValue.navigateToChangePassword = true
            
        case .biometricAuth:
            self.interactor.prepareBiometricAuthentication()
            
        case .privacyPolicy:
            self.navigationState.wrappedValue.webEntity = WebEntity(
                pageName: "PrivacyPolicy",
                pageTitle: menu.localizableKey,
                titleIcon: menu.iconName
            )
            self.navigationState.wrappedValue.navigateToWeb = true
            
        case .termsAndConditions:
            self.navigationState.wrappedValue.webEntity = WebEntity(
                pageName: "TermsAndConditions",
                pageTitle: menu.localizableKey,
                titleIcon: menu.iconName
            )
            self.navigationState.wrappedValue.navigateToWeb = true
            
        case .logout:
            await self.logout()
        }
    }
    
    func updateBiometricPaired() {
        showAlert {
            IOAlertData(
                title: nil,
                message: .successBiometricPaired,
                buttons: [.commonOk],
                handler: nil
            )
        }
    }
    
    func update(biometryError: IOBiometricAuthenticatorError) {
        switch biometryError {
        case .doesNotSupport(message: let message), .unlockError(message: let message):
            showAlert {
                IOAlertData(
                    title: nil,
                    message: message,
                    buttons: [.commonOk],
                    handler: nil
                )
            }
            
        case .canNotEvaluate:
            showAlert {
                IOAlertData(
                    title: nil,
                    message: .errorBiometricCanNotEvaluate,
                    buttons: [.commonOk],
                    handler: nil
                )
            }
            
        case .dataSign, .keyCreation, .keyNotFound, .userCancelled, .authFailed:
            showAlert {
                IOAlertData(
                    title: nil,
                    message: .networkCommonError,
                    buttons: [.commonOk],
                    handler: nil
                )
            }
            
        case .locked:
            self.interactor.unlockBiometricAuthentication()
        }
    }
    
    // MARK: - Helper Methods
    
    @MainActor
    private func logout() async {
        let index = await self.showAlertAsync {
            IOAlertData(
                title: nil,
                message: .promptLogout,
                buttons: [
                    .commonYes,
                    .commonNo
                ]
            )
        }
        
        if index == 0 {
            self.interactor.logout()
            self.environment.wrappedValue.appScreen = .splash
        }
    }
}
