//
//  IOCameraLocalizationType.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public extension IOLocalizationType {
    
    static let cameraAccessDeniedMessage = IOLocalizationType(rawValue: "camera.accessDeniedMessage")
    static let cameraAccessRestrictedMessage = IOLocalizationType(rawValue: "camera.accessRestrictedMessage")
}
