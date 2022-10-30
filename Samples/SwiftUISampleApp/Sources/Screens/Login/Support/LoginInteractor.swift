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
import SwiftUISampleAppScreensShared

public struct LoginInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: LoginEntity!
    public weak var presenter: LoginPresenter?
    
    // MARK: - DI
    
    @IOInject private var httpClient: IOHTTPClientImpl
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<LoginService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func login(email: String, password: String) {
        guard let aesIV = self.appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = self.appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedPassword = IOAESUtilities.encrypt(string: password, keyData: aesKey, ivData: aesIV) else { return }
        
        self.showIndicator()
        
        let request = AuthenticateRequestModel(email: email, password: encryptedPassword.base64EncodedString())
        
        self.service.request(
            .authenticate(request: request),
            responseType: AuthenticateResponseModel.self
        ) { result in
            self.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self.completeLogin(response: response)
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func completeLogin(response: AuthenticateResponseModel?) {
        guard let response else { return }
        
        self.localStorage.set(string: response.token ?? "", forType: .userToken)
        
        if var defaultHTTPHeaders = self.httpClient.defaultHTTPHeaders {
            defaultHTTPHeaders["X-IO-AUTHORIZATION-TOKEN"] = response.token ?? ""
            self.httpClient.setDefaultHTTPHeaders(headers: defaultHTTPHeaders)
        }
        
        self.presenter?.loginCompleted()
    }
}
