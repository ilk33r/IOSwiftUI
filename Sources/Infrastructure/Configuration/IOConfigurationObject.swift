//
//  IOConfigurationObject.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOConfigurationObject {
    
    var configData: [IOEnvironmentType: [IOConfigurationType: String]] { get }
}
