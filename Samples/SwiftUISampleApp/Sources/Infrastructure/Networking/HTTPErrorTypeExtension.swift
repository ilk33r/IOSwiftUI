//
//  HTTPErrorTypeExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public extension IOHTTPError.ErrorType {
    
    static let responseStatusError = IOHTTPError.ErrorType(rawValue: 100)
}
