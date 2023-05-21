// 
//  ChangePasswordLocalizableType.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension IOLocalizationType {
    
    static let formConfirmPassword = IOLocalizationType(rawValue: "changePassword.form.confirmPassword")
    static let formCurrentPassword = IOLocalizationType(rawValue: "changePassword.form.currentPassword")
    static let formNewPassword = IOLocalizationType(rawValue: "changePassword.form.newPassword")
    static let successMessage = IOLocalizationType(rawValue: "changePassword.success.message")
    static let title = IOLocalizationType(rawValue: "changePassword.title")
    static let validationPasswordDoNotMatch = IOLocalizationType(rawValue: "changePassword.validation.passwordDoNotMatch")
}
