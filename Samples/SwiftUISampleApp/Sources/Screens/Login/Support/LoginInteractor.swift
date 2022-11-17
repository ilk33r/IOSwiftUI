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
    
    @IOInject private var httpClient: IOHTTPClient
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<LoginService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func login(email: String, password: String) {
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedPassword = IOAESUtilities.encrypt(string: password, keyData: aesKey, ivData: aesIV) else { return }
        
        showIndicator()
        
        let request = AuthenticateRequestModel(email: email, password: encryptedPassword.base64EncodedString())
        service.request(
            .authenticate(request: request),
            responseType: AuthenticateResponseModel.self
        ) { result in
            hideIndicator()
            
            switch result {
            case .success(response: let response):
                completeLogin(response: response)
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func completeLogin(response: AuthenticateResponseModel?) {
        guard let response else { return }
        
        localStorage.set(string: response.token ?? "", forType: .userToken)
        
        if var defaultHTTPHeaders = httpClient.defaultHTTPHeaders {
            defaultHTTPHeaders["X-IO-AUTHORIZATION-TOKEN"] = response.token ?? ""
            httpClient.setDefaultHTTPHeaders(headers: defaultHTTPHeaders)
        }
        
        presenter?.loginCompleted()
    }
}
