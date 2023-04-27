// 
//  RegisterLocalizableType.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension IOLocalizationType {
    
    static let buttonScan = IOLocalizationType(rawValue: "register.button.scan")
    static let cameraActionsChoosePhoto = IOLocalizationType(rawValue: "register.camera.actions.choosePhoto")
    static let cameraActionsTakePhoto = IOLocalizationType(rawValue: "register.camera.actions.takePhoto")
    static let cameraActionsTitle = IOLocalizationType(rawValue: "register.camera.actions.title")
    static let cameraDeviceNotFound = IOLocalizationType(rawValue: "register.camera.deviceNotFound")
    static let formBirthDate = IOLocalizationType(rawValue: "register.form.birthDate")
    static let formLocation = IOLocalizationType(rawValue: "register.form.location")
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
    static let nfcError0 = IOLocalizationType(rawValue: "register.nfc.error.0")
    static let nfcError1 = IOLocalizationType(rawValue: "register.nfc.error.1")
    static let nfcError2 = IOLocalizationType(rawValue: "register.nfc.error.2")
    static let nfcError3 = IOLocalizationType(rawValue: "register.nfc.error.3")
    static let nfcError4 = IOLocalizationType(rawValue: "register.nfc.error.4")
    static let nfcError5 = IOLocalizationType(rawValue: "register.nfc.error.5")
    static let nfcInfo0 = IOLocalizationType(rawValue: "register.nfc.info.0")
    static let nfcInfo1 = IOLocalizationType(rawValue: "register.nfc.info.1")
    static let nfcInfo2 = IOLocalizationType(rawValue: "register.nfc.info.2")
    static let nfcInfo3 = IOLocalizationType(rawValue: "register.nfc.info.3")
    static let title = IOLocalizationType(rawValue: "register.title")
    static let titleMRZ = IOLocalizationType(rawValue: "register.title.mrz")
    static let titleNFC = IOLocalizationType(rawValue: "register.title.nfc")
    static let titleProfile = IOLocalizationType(rawValue: "register.title.profile")
}
