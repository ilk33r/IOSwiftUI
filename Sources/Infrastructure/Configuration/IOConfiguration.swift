//
//  IOConfiguration.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOConfiguration {
    
    // MARK: - Properties
    
    var defaultLocale: IOLocales { get }
    var environment: IOEnvironmentType { get }
    
    // MARK: - Getters
    
    func configForType(type: IOConfigurationType) -> String
}
