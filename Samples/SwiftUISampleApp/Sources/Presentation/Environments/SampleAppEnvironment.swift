//
//  SampleAppEnvironment.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final public class SampleAppEnvironment: IOAppEnvironment {
    
    // MARK: - Properties
    
    @Published public var showLoading = false
    @Published public var isLoggedIn = false
    
    // MARK: - Initialization Methods
    
    public init() {
        
    }
}
