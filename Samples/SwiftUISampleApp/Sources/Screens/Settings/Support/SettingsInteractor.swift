// 
//  SettingsInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUISupportBiometricAuthenticator
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import UIKit

public struct SettingsInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: SettingsEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    @IOInject private var httpClient: IOHTTPClient
    
    private var biometricAuthenticator = IOBiometricAuthenticator()
    private var profilePictureService = IOServiceProviderImpl<ProfilePictureService>()
    private var service = IOServiceProviderImpl<SettingsService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func loadMenu() -> [SettingsMenuItemUIModel] {
        var settingMenu = [SettingsMenuItemUIModel]()
        
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "person.fill",
                localizableKey: .menuUpdateProfile,
                type: .updateProfile
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "person.crop.circle",
                localizableKey: .menuUpdateProfilePicture,
                type: .updateProfilePicture
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "person.crop.circle.badge.minus",
                localizableKey: .menuRemoveProfilePicture,
                type: .removeProfilePicture
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "lock.fill",
                localizableKey: .menuChangePassword,
                type: .changePassword
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "faceid",
                localizableKey: .menuSetupBiometricAuth,
                type: .biometricAuth
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "doc.text",
                localizableKey: .menuPrivacyPolicy,
                type: .privacyPolicy
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "doc.richtext",
                localizableKey: .menuTermOfUse,
                type: .termsAndConditions
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "xmark.shield",
                localizableKey: .menuLogout,
                type: .logout
            )
        )
        
        return settingMenu
    }
    
    @MainActor
    func deleteProfilePicture() async throws {
        showIndicator()
        
        let result = await service.async(.deleteProfilePicture, responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            break
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func deleteAndUploadProfilePicture(image: UIImage) async throws {
        showIndicator()
        
        if entity.member.profilePicturePublicId == nil {
            try await uploadProfilePicture(image: image)
            return
        }
        
        let result = await service.async(.deleteProfilePicture, responseType: GenericResponseModel.self)
        switch result {
        case .success:
            try await uploadProfilePicture(image: image)
            
        case .error(message: let message, type: let type, response: let response):
            hideIndicator()
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    func logout() {
        localStorage.remove(type: .userToken)
        
        if var defaultHTTPHeaders = httpClient.defaultHTTPHeaders {
            defaultHTTPHeaders.removeValue(forKey: "X-IO-AUTHORIZATION-TOKEN")
            httpClient.setDefaultHTTPHeaders(headers: defaultHTTPHeaders)
        }
    }
    
    @MainActor
    func prepareBiometricAuthentication() async throws {
        try biometricAuthenticator.checkBiometricStatus()
        let isPaired = try biometricAuthenticator.isPaired(forUser: entity.member.userName ?? "")
        
        if isPaired {
            throw IOInteractorError.service
        }
        
        try await self.biometricPairDevice()
    }
    
    @MainActor
    func biometricPairDevice() async throws {
        showIndicator()
        
        let authenticationData = try biometricAuthenticator.pairDevice(forUser: entity.member.userName ?? "")
        
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedAuthenticationData = IOAESUtilities.encrypt(
            string: authenticationData.toHexString(),
            keyData: aesKey,
            ivData: aesIV
        ) else { return }
        
        let request = MemberPairFaceIDRequestModel(authenticationKey: encryptedAuthenticationData.base64EncodedString())
        let result = await service.async(.pairFaceID(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            localStorage.set(string: entity.member.userName ?? "", forType: .biometricUserName)
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func unlockBiometricAuthentication() async throws {
        let status = try await biometricAuthenticator.unlockBiometricAuthentication(
            reason: .errorBiometricLockedOut
        )
        
        if status {
            try await prepareBiometricAuthentication()
        }
    }
    
    // MARK: - Helper Methods
    
    @MainActor
    private func uploadProfilePicture(image: UIImage) async throws {
        let result = await profilePictureService.async(.uploadProfilePicture(image: image.pngData()!), responseType: ImageCreateResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            break
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
