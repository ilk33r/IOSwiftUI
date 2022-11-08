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
    
    // MARK: - Properties
    
    @Published public var showAlert = false
    @Published public var showLoading = false
    @Published public var isLoggedIn = false
    
    private(set) public var alertData: IOAlertData!
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    func showAlert(
        _ message: String,
        title: String? = nil,
        buttonTitles: [IOLocalizationType] = [IOLocalizationType.commonOk],
        handler: IOAlertModifierResultHandler?
    ) {
        self.alertData = IOAlertData(
            title: title ?? "",
            message: message,
            buttons: buttonTitles,
            handler: { [weak self] index in
                handler?(index)
                self?.showAlert = false
            }
        )

        self.showAlert = true
    }
}
