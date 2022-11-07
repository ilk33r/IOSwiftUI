//
//  IOLocationLocalizationType.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public extension IOLocalizationType {
    
    static let locationServiceDeniedMessage = IOLocalizationType(rawValue: "location.serviceDeniedMessage")
    static let locationServiceDisabledMessage = IOLocalizationType(rawValue: "location.serviceDisabledMessage")
    static let locationServiceRestrictedMessage = IOLocalizationType(rawValue: "location.serviceRestrictedMessage")

}
