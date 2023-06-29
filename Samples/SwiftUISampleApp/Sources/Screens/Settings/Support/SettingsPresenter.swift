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
    
    private enum BiometricAuthenticatorType {
        case prepare
        case forcePair
        case unlock
    }
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SettingsInteractor!
    public var navigationState: StateObject<SettingsNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var actionSheetData: IOAlertData?
    @Published private(set) var menu: [SettingsMenuItemUIModel]
    @Published private(set) var navigateToBack: Bool
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.menu = []
        self.navigateToBack = false
    }
    
    // MARK: - Presenter
    
    func prepare() {
        self.menu = self.interactor.loadMenu()
    }
    
    @MainActor
    func deleteAndUploadProfilePicture(image: UIImage) async {
        do {
            try await self.interactor.deleteAndUploadProfilePicture(image: image)
            await showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .successUpdateProfilePicture,
                    buttons: [.commonOk]
                )
            }
            
            self.interactor.eventProcess.set(bool: true, forType: .profilePictureUpdated)
            self.navigateToBack = true
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func navigate(menu: SettingsMenuItemUIModel) async {
        switch menu.type {
        case .updateProfile:
            self.navigationState.wrappedValue.navigateToUpdateProfile(
                updateProfileEntity: UpdateProfileEntity(
                    member: self.interactor.entity.member
                )
            )
            
        case .updateProfilePicture:
            self.createUpdateProfilePictureSheet()
            
        case .removeProfilePicture:
            await self.removeProfilePicture()
            
        case .changePassword:
            self.navigationState.wrappedValue.navigateToChangePassword(
                changePasswordEntity: ChangePasswordEntity(
                    phoneNumber: self.interactor.entity.member.phoneNumber ?? ""
                )
            )
            
        case .biometricAuth:
            await self.prepareBiometricAuthentication()
            
        case .privacyPolicy:
            self.navigationState.wrappedValue.navigateToWeb(
                webEntity: WebEntity(
                    pageName: "PrivacyPolicy",
                    pageTitle: menu.localizableKey,
                    titleIcon: menu.iconName
                )
            )
            
        case .termsAndConditions:
            self.navigationState.wrappedValue.navigateToWeb(
                webEntity: WebEntity(
                    pageName: "TermsAndConditions",
                    pageTitle: menu.localizableKey,
                    titleIcon: menu.iconName
                )
            )
            
        case .logout:
            await self.logout()
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
    
    @MainActor
    private func createUpdateProfilePictureSheet() {
        self.actionSheetData = IOAlertData(
            title: .cameraActionsTitle,
            message: "",
            buttons: [
                .cameraActionsTakePhoto,
                .cameraActionsChoosePhoto,
                .commonCancel
            ],
            handler: { [weak self] index in
                if index == 0 {
                    self?.navigationState.wrappedValue.navigateToCameraPage()
                } else if index == 1 {
                    self?.navigationState.wrappedValue.navigateToPhotoLibraryPage()
                }
            }
        )
    }
    
    @MainActor
    private func removeProfilePicture() async {
        let index = await self.showAlertAsync {
            IOAlertData(
                title: nil,
                message: .promptDeleteProfilePicture,
                buttons: [.commonYes, .commonNo]
            )
        }
        
        if index == 0 {
            do {
                try await self.interactor.deleteProfilePicture()
                await self.showAlertAsync {
                    IOAlertData(
                        title: nil,
                        message: .successDeleteProfilePicture,
                        buttons: [.commonOk]
                    )
                }
                
                self.interactor.eventProcess.set(bool: true, forType: .profilePictureUpdated)
                self.navigateToBack = true
            } catch let err {
                IOLogger.error(err.localizedDescription)
            }
        }
    }
    
    @MainActor
    private func prepareBiometricAuthentication() async {
        await self.prepareBiometricAuthentication(.prepare)
    }
    
    @MainActor
    private func prepareBiometricAuthentication(_ type: BiometricAuthenticatorType) async {
        do {
            if type == .forcePair {
                try await self.interactor.biometricPairDevice()
            } else if type == .unlock {
                try await self.interactor.unlockBiometricAuthentication()
            } else {
                try await self.interactor.prepareBiometricAuthentication()
            }
            
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .successBiometricPaired,
                    buttons: [.commonOk]
                )
            }
            
        } catch IOBiometricAuthenticatorError.doesNotSupport(message: let message) {
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: message,
                    buttons: [.commonOk]
                )
            }
        } catch IOBiometricAuthenticatorError.unlockError(message: let message) {
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: message,
                    buttons: [.commonOk]
                )
            }
        } catch IOBiometricAuthenticatorError.canNotEvaluate {
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .errorBiometricCanNotEvaluate,
                    buttons: [.commonOk]
                )
            }
        } catch IOBiometricAuthenticatorError.locked {
            await self.prepareBiometricAuthentication(.unlock)
        } catch IOInteractorError.service {
            let index = await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .errorBiometricActivated,
                    buttons: [.commonCancel, .buttonReactivate]
                )
            }
            
            if index == 1 {
                await self.prepareBiometricAuthentication(.forcePair)
            }
        } catch {
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .networkCommonError,
                    buttons: [.commonOk]
                )
            }
        }
    }
}
