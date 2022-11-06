//
//  InteractorExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure

public extension IOInteractor {
    
    // MARK: - Indicator
    
    func showIndicator() {
        presenter?.showIndicator()
    }
    
    func hideIndicator() {
        presenter?.hideIndicator()
    }
    
    // MARK: - Alert
    
    func showAlert(
        _ message: String,
        title: String? = nil,
        buttonTitles: [IOLocalizationType] = [IOLocalizationType.commonOk],
        handler: SampleAppEnvironment.AlertHandler?
    ) {
        presenter?.showAlert(
            message,
            title: title,
            buttonTitles: buttonTitles,
            handler: handler
        )
    }
    
    // MARK: - Service
    
    func handleServiceError(
        _ message: String?,
        type: IOHTTPError.ErrorType,
        response: BaseResponseModel?,
        handler: SampleAppEnvironment.AlertHandler?
    ) {
        let message = message ?? IOLocalizationType.networkCommonError.localized
        showAlert(message, handler: handler)
    }
}
