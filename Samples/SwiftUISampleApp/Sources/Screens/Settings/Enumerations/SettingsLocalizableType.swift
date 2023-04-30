// 
//  SettingsLocalizableType.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension IOLocalizationType {
    
    static let buttonReactivate = IOLocalizationType(rawValue: "settings.button.reactivate")
    static let cameraActionsChoosePhoto = IOLocalizationType(rawValue: "settings.camera.actions.choosePhoto")
    static let cameraActionsTakePhoto = IOLocalizationType(rawValue: "settings.camera.actions.takePhoto")
    static let cameraActionsTitle = IOLocalizationType(rawValue: "settings.camera.actions.title")
    static let errorBiometricActivated = IOLocalizationType(rawValue: "settings.error.biometric.activated")
    static let errorBiometricCanNotEvaluate = IOLocalizationType(rawValue: "settings.error.biometric.canNotEvaluate")
    static let errorBiometricLockedOut = IOLocalizationType(rawValue: "settings.error.biometric.lockedOut")
    static let menuChangePassword = IOLocalizationType(rawValue: "settings.menu.changePassword")
    static let menuLogout = IOLocalizationType(rawValue: "settings.menu.logout")
    static let menuPrivacyPolicy = IOLocalizationType(rawValue: "settings.menu.privacyPolicy")
    static let menuRemoveProfilePicture = IOLocalizationType(rawValue: "settings.menu.removeProfilePicture")
    static let menuSetupBiometricAuth = IOLocalizationType(rawValue: "settings.menu.setupBiometricAuth")
    static let menuTermOfUse = IOLocalizationType(rawValue: "settings.menu.termOfUse")
    static let menuUpdateProfilePicture = IOLocalizationType(rawValue: "settings.menu.updateProfilePicture")
    static let menuUpdateProfile = IOLocalizationType(rawValue: "settings.menu.updateProfile")
    static let promptDeleteProfilePicture = IOLocalizationType(rawValue: "settings.prompt.deleteProfilePicture")
    static let promptLogout = IOLocalizationType(rawValue: "settings.prompt.logout")
    static let successBiometricPaired = IOLocalizationType(rawValue: "settings.success.biometric.paired")
    static let successDeleteProfilePicture = IOLocalizationType(rawValue: "settings.success.deleteProfilePicture")
    static let successUpdateProfilePicture = IOLocalizationType(rawValue: "settings.success.updateProfilePicture")
    static let title = IOLocalizationType(rawValue: "settings.title")
}
