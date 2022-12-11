// 
//  RegisterLocalizableType.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension IOLocalizationType {
    
    static let registerInputEmailAddress = IOLocalizationType(rawValue: "register.input.emailAddress")
    static let registerInputErrorEmail = IOLocalizationType(rawValue: "register.input.error.email")
    static let registerInputErrorUserName = IOLocalizationType(rawValue: "register.input.error.userName")
    static let registerInputErrorPasswordLength = IOLocalizationType(rawValue: "register.input.error.passwordLength")
    static let registerInputErrorPasswordMatch = IOLocalizationType(rawValue: "register.input.error.passwordMatch")
    static let registerInputPassword = IOLocalizationType(rawValue: "register.input.password")
    static let registerInputPasswordReEnter = IOLocalizationType(rawValue: "register.input.passwordReEnter")
    static let registerInputUserName = IOLocalizationType(rawValue: "register.input.userName")
    static let registerTitle = IOLocalizationType(rawValue: "register.title")
}
