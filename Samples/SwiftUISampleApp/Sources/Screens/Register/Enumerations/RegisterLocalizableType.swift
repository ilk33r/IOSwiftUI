// 
//  RegisterLocalizableType.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension IOLocalizationType {
    
    static let registerButtonScan = IOLocalizationType(rawValue: "register.button.scan")
    static let cameraActionsChoosePhoto = IOLocalizationType(rawValue: "register.camera.actions.choosePhoto")
    static let cameraActionsTakePhoto = IOLocalizationType(rawValue: "register.camera.actions.takePhoto")
    static let cameraActionsTitle = IOLocalizationType(rawValue: "register.camera.actions.title")
    static let registerCameraDeviceNotFound = IOLocalizationType(rawValue: "register.camera.deviceNotFound")
    static let formBirthDate = IOLocalizationType(rawValue: "register.form.birthDate")
    static let registerFormLocation = IOLocalizationType(rawValue: "register.form.location")
    static let formName = IOLocalizationType(rawValue: "register.form.name")
    static let formPhone = IOLocalizationType(rawValue: "register.form.phone")
    static let formSurname = IOLocalizationType(rawValue: "register.form.surname")
    static let inputEmailAddress = IOLocalizationType(rawValue: "register.input.emailAddress")
    static let inputErrorEmail = IOLocalizationType(rawValue: "register.input.error.email")
    static let inputErrorUserName = IOLocalizationType(rawValue: "register.input.error.userName")
    static let inputErrorPasswordLength = IOLocalizationType(rawValue: "register.input.error.passwordLength")
    static let inputErrorPasswordMatch = IOLocalizationType(rawValue: "register.input.error.passwordMatch")
    static let inputPassword = IOLocalizationType(rawValue: "register.input.password")
    static let inputPasswordReEnter = IOLocalizationType(rawValue: "register.input.passwordReEnter")
    static let inputUserName = IOLocalizationType(rawValue: "register.input.userName")
    static let registerNFCError0 = IOLocalizationType(rawValue: "register.nfc.error.0")
    static let registerNFCError1 = IOLocalizationType(rawValue: "register.nfc.error.1")
    static let registerNFCError2 = IOLocalizationType(rawValue: "register.nfc.error.2")
    static let registerNFCError3 = IOLocalizationType(rawValue: "register.nfc.error.3")
    static let registerNFCError4 = IOLocalizationType(rawValue: "register.nfc.error.4")
    static let registerNFCError5 = IOLocalizationType(rawValue: "register.nfc.error.5")
    static let registerNfcInfo0 = IOLocalizationType(rawValue: "register.nfc.info.0")
    static let registerNfcInfo1 = IOLocalizationType(rawValue: "register.nfc.info.1")
    static let registerNFCInfo2 = IOLocalizationType(rawValue: "register.nfc.info.2")
    static let registerNFCInfo3 = IOLocalizationType(rawValue: "register.nfc.info.3")
    static let title = IOLocalizationType(rawValue: "register.title")
    static let registerTitleMRZ = IOLocalizationType(rawValue: "register.title.mrz")
    static let registerTitleNFC = IOLocalizationType(rawValue: "register.title.nfc")
    static let titleProfile = IOLocalizationType(rawValue: "register.title.profile")
}
