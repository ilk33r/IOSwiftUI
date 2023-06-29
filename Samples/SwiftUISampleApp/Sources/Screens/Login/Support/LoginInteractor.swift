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
import IOSwiftUISupportBiometricAuthenticator
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct LoginInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: LoginEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var biometricAuthenticator = IOBiometricAuthenticator()
    private var authenticationService = IOServiceProviderImpl<AuthenticationService>()
    private var service = IOServiceProviderImpl<LoginService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func checkMemberEmail(email: String) async throws {
        showIndicator()
        
        let request = CheckMemberRequestModel(email: email)
        let result = await authenticationService.async(.checkMember(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            throw IOInteractorError.service
            
        case .error:
            break
        }
    }
    
    @MainActor
    func biometricLogin() async throws {
        guard let userName = localStorage.string(forType: .biometricUserName) else { return }
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedUserName = IOAESUtilities.encrypt(string: userName, keyData: aesKey, ivData: aesIV) else { return }
        
        showIndicator()
        
        let request = BiometricAuthenticateRequestModel(userName: encryptedUserName.base64EncodedString())
        let result = await service.async(.biometricToken(request: request), responseType: BiometricAuthenticateResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success(let response):
            IOLogger.debug("response \(response)")
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
