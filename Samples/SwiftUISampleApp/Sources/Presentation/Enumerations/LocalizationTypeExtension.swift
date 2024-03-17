//
//  LocalizationTypeExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public extension IOLocalizationType {
    
    static let commonAddToCart = IOLocalizationType(rawValue: "common.addToCart")
    static let commonAddToCartSuccess = IOLocalizationType(rawValue: "common.addToCartSuccess")
    static let commonAppName = IOLocalizationType(rawValue: "common.appName")
    static let commonCancel = IOLocalizationType(rawValue: "common.cancel")
    static let commonNextUppercased = IOLocalizationType(rawValue: "common.next.uppercased")
    static let commonNo = IOLocalizationType(rawValue: "common.no")
    static let commonSave = IOLocalizationType(rawValue: "common.save")
    static let commonYes = IOLocalizationType(rawValue: "common.yes")
    
    static let validationRequiredMessage = IOLocalizationType(rawValue: "validation.requiredMessage")
}
