//
//  PresenterableExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

public extension IOPresenterable {
    
    // MARK: - Indicator
    
    func showIndicator() {
        let environment = self.environment as? EnvironmentObject<SampleAppEnvironment>
        environment?.wrappedValue.showLoading = true
    }
    
    func hideIndicator() {
        let environment = self.environment as? EnvironmentObject<SampleAppEnvironment>
        environment?.wrappedValue.showLoading = false
    }
    
    // MARK: - Alert
    
    func showAlert(
        _ message: String,
        title: String? = nil,
        buttonTitles: [IOLocalizationType] = [IOLocalizationType.commonOk],
        handler: IOAlertModifierResultHandler?
    ) {
        let environment = self.environment as? EnvironmentObject<SampleAppEnvironment>
        environment?.wrappedValue.showAlert(
            message,
            title: title,
            buttonTitles: buttonTitles,
            handler: handler
        )
    }
}
