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
    static let registerInputUserName = IOLocalizationType(rawValue: "register.input.userName")
    static let registerTitle = IOLocalizationType(rawValue: "register.title")
}
