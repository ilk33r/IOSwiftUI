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
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import UIKit

public struct SettingsInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: SettingsEntity!
    public weak var presenter: SettingsPresenter?
    
    // MARK: - Privates
    
    @IOInject private var httpClient: IOHTTPClient
    
    private var service = IOServiceProviderImpl<SettingsService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func loadMenu() {
        var settingMenu = [SettingsMenuItemUIModel]()
        
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "person.fill",
                localizableKey: .settingsMenuUpdateProfile,
                type: .updateProfile
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "person.crop.circle",
                localizableKey: .settingsMenuUpdateProfilePicture,
                type: .updateProfilePicture
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "person.crop.circle.badge.minus",
                localizableKey: .settingsMenuRemoveProfilePicture,
                type: .removeProfilePicture
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "lock.fill",
                localizableKey: .settingsMenuChangePassword,
                type: .changePassword
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "doc.text",
                localizableKey: .settingsMenuPrivacyPolicy,
                type: .privacyPolicy
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "doc.richtext",
                localizableKey: .settingsMenuTermOfUse,
                type: .termsAndConditions
            )
        )
        settingMenu.append(
            SettingsMenuItemUIModel(
                iconName: "xmark.shield",
                localizableKey: .settingsMenuLogout,
                type: .logout
            )
        )
        
        presenter?.update(menu: settingMenu)
    }
    
    func deleteProfilePicture() {
        showIndicator()
        
        service.request(.deleteProfilePicture, responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                showAlert {
                    IOAlertData(title: nil, message: .settingsSuccessDeleteProfilePicture, buttons: [.commonOk], handler: nil)
                }
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func deleteAndUploadProfilePicture(image: UIImage) {
        showIndicator()
        
        if entity.member.profilePicturePublicId == nil {
            uploadProfilePicture(image: image)
            return
        }
        
        service.request(.deleteProfilePicture, responseType: GenericResponseModel.self) { result in
            switch result {
            case .success(_):
                uploadProfilePicture(image: image)
                
            case .error(message: let message, type: let type, response: let response):
                hideIndicator()
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func logout() {
        localStorage.remove(type: .userToken)
        
        if var defaultHTTPHeaders = httpClient.defaultHTTPHeaders {
            defaultHTTPHeaders.removeValue(forKey: "X-IO-AUTHORIZATION-TOKEN")
            httpClient.setDefaultHTTPHeaders(headers: defaultHTTPHeaders)
        }
        
        presenter?.navigateSplash()
    }
    
    // MARK: - Helper Methods
    
    private func uploadProfilePicture(image: UIImage) {
        service.request(.uploadProfilePicture(image: image.pngData()!), responseType: ImageCreateResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                showAlert {
                    IOAlertData(title: nil, message: .settingsSuccessUpdateProfilePicture, buttons: [.commonOk], handler: nil)
                }
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
