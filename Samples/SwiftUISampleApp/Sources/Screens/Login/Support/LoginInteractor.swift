// 
//  LoginInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

final class LoginInteractor: IOInteractor<LoginPresenter, LoginEntity> {
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<LoginService>
    
    // MARK: - Interactor
    
    func login(email: String, password: String) {
        guard let aesIV = self.appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = self.appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedPassword = IOAESUtilities.encrypt(string: password, keyData: aesKey, ivData: aesIV) else { return }
        
        self.showIndicator()
        
        let request = AuthenticateRequestModel()
        request.email = email
        request.password = encryptedPassword.base64EncodedString()
        
        self.service.request(
            .authenticate(request: request),
            responseType: AuthenticateResponseModel.self
        ) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            // case .success(response: let response):
            case .success(response: _):
                IOLogger.debug("Ok")
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
