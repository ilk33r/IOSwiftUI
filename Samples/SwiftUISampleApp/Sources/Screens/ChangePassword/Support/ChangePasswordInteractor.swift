// 
//  ChangePasswordInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct ChangePasswordInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: ChangePasswordEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<ChangePasswordService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func changePassword(oldPassword: String, newPassword: String) async throws {
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { throw IOInteractorError.service }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { throw IOInteractorError.service }
        
        guard let encryptedOldPassword = IOAESUtilities.encrypt(string: oldPassword, keyData: aesKey, ivData: aesIV) else { throw IOInteractorError.service }
        guard let encryptedNewPassword = IOAESUtilities.encrypt(string: newPassword, keyData: aesKey, ivData: aesIV) else { throw IOInteractorError.service }
        
        showIndicator()
        
        let request = ChangePasswordRequestModel(
            oldPassword: encryptedOldPassword.base64EncodedString(),
            newPassword: encryptedNewPassword.base64EncodedString()
        )
        
        let result = await service.async(.changePassword(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            break
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
