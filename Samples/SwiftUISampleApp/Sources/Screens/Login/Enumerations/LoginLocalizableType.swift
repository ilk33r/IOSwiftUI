// 
//  LoginLocalizableType.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension IOLocalizationType {
    
    static let biometricLogin = IOLocalizationType(rawValue: "login.biometric.login")
    static let errorUserNotFound = IOLocalizationType(rawValue: "login.error.userNotFound")
    static let inputEmailAddress = IOLocalizationType(rawValue: "login.input.emailAddress")
    static let inputErrorEmail = IOLocalizationType(rawValue: "login.input.error.email")
    static let inputErrorPassword = IOLocalizationType(rawValue: "login.input.error.password")
    static let inputPassword = IOLocalizationType(rawValue: "login.input.password")
    static let title = IOLocalizationType(rawValue: "login.title")
}
