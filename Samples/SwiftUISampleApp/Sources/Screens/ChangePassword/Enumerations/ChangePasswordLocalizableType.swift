// 
//  ChangePasswordLocalizableType.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension IOLocalizationType {
    
    static let changePasswordFormConfirmPassword = IOLocalizationType(rawValue: "changePassword.form.confirmPassword")
    static let changePasswordFormCurrentPassword = IOLocalizationType(rawValue: "changePassword.form.currentPassword")
    static let changePasswordFormNewPassword = IOLocalizationType(rawValue: "changePassword.form.newPassword")
    static let changePasswordSuccessMessage = IOLocalizationType(rawValue: "changePassword.success.message")
    static let changePasswordTitle = IOLocalizationType(rawValue: "changePassword.title")
    static let changePasswordValidationPasswordDoNotMatch = IOLocalizationType(rawValue: "changePassword.validation.passwordDoNotMatch")
}
