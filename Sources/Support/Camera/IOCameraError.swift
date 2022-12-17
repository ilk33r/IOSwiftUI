//
//  IOCameraError.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public enum IOCameraError: Error {
    
    case authorization(errorMessage: IOLocalizationType, settingsURL: URL?)
    case deviceError(errorMessage: String)
    case deviceNotFound
}
