//
//  SampleAppEnvironment.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Combine
import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

final public class SampleAppEnvironment: IOAppEnvironment {
    
    // MARK: - Properties
    
    @Published public var showLoading = false
    @Published public var isLoggedIn = false
    
    public var alertData: IOAlertData? {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}
