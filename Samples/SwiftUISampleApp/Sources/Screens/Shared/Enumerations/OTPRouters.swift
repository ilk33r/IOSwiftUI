//
//  OTPRouters.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared

public enum OTPRouters: IORouterDefinition {

    case sendOTP(entity: SendOTPEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .sendOTP(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .sendOTP:
            return "SendOTPView"
        }
    }
}
