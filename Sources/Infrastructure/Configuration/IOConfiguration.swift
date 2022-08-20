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
    
    var environment: IOEnvironmentType { get }
    
    // MARK: - Setters
    
    func setConfiguration(configurations: IOConfigurationObject)
    func setEnvironment(type: IOEnvironmentType)
    
    // MARK: - Getters
    
    func configForType(type: IOConfigurationType) -> String
}
