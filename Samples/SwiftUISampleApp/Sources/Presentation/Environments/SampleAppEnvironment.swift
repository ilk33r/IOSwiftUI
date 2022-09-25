//
//  SampleAppEnvironment.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

final public class SampleAppEnvironment: IOAppEnvironment {
    
    // MARK: - Types
    
    public typealias AlertHandler = (_ index: Int) -> Void
    
    // MARK: - Properties
    
    @Published public var showAlert = false
    @Published public var showLoading = false
    @Published public var isLoggedIn = false
    
    private(set) public var alertButtons: [IOLocalizationType]
    private(set) public var alertHandler: AlertHandler?
    private(set) public var alertMessage: String
    private(set) public var alertTitle: String
    
    // MARK: - Initialization Methods
    
    public init() {
        self.alertButtons = []
        self.alertMessage = ""
        self.alertTitle = ""
    }
    
    func showAlert(
        _ message: String,
        title: String? = nil,
        buttonTitles: [IOLocalizationType] = [IOLocalizationType.commonOk],
        handler: AlertHandler?
    ) {
        self.alertButtons = buttonTitles
        self.alertHandler = handler
        self.alertMessage = message
        self.alertTitle = title ?? ""
        self.showAlert = true
    }
}
