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
    public weak var presenter: ChangePasswordPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<ChangePasswordService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func changePassword(oldPassword: String, newPassword: String) {
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedOldPassword = IOAESUtilities.encrypt(string: oldPassword, keyData: aesKey, ivData: aesIV) else { return }
        guard let encryptedNewPassword = IOAESUtilities.encrypt(string: newPassword, keyData: aesKey, ivData: aesIV) else { return }
        
        showIndicator()
        
        let request = ChangePasswordRequestModel(
            oldPassword: encryptedOldPassword.base64EncodedString(),
            newPassword: encryptedNewPassword.base64EncodedString()
        )
        
        service.request(.changePassword(request: request), responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                presenter?.updateSuccess()
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
