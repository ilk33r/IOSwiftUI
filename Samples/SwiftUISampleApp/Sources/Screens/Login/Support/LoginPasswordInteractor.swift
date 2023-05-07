// 
//  LoginPasswordInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct LoginPasswordInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: LoginPasswordEntity!
    public weak var presenter: LoginPasswordPresenter?
    
    // MARK: - DI
    
    @IOInject private var httpClient: IOHTTPClient
    
    // MARK: - Privates
    
    private var authenticationService = IOServiceProviderImpl<AuthenticationService>()
    private var service = IOServiceProviderImpl<LoginService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func login(password: String) async throws {
        showIndicator()
        
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedPassword = IOAESUtilities.encrypt(string: password, keyData: aesKey, ivData: aesIV) else { return }
        let request = AuthenticateRequestModel(email: entity.email, password: encryptedPassword.base64EncodedString())
        let result = await authenticationService.async(.authenticate(request: request), responseType: AuthenticateResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success(let response):
            completeLogin(response: response)
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
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
    }
}
