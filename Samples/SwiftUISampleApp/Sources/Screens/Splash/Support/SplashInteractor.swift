//
//  SplashInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

final public class SplashInteractor: IOInteractor<SplashPresenter, SplashEntity> {
    
    private var service = IOServiceProviderImpl<SplashService>()
    
    func handshake() {
        self.showIndicator()
        
        self.service.request(.handshake, responseType: HandshakeResponseModel.self) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            case .success(response: let response):
                break
                
            case .error(message: let message, type: let type, response: let response):
                IOLogger.error(message)
            }
        }
    }
}
