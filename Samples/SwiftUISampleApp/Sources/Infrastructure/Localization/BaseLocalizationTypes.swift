//
//  BaseLocalizationTypes.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public extension IOLocalizationType {
    
    static let networkCommonError = IOLocalizationType(rawValue: "network.CommonError")
    static let networkConnectionError = IOLocalizationType(rawValue: "network.ConnectionError")
}
