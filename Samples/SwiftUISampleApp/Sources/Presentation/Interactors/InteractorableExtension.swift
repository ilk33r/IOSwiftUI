//
//  InteractorableExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

public extension IOInteractorable {
    
    // MARK: - Service
    
    var service: IOServiceProvider { IOServiceProviderImpl.shared }
}
