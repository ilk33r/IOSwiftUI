// 
//  ChatInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

final public class ChatInteractor: IOInteractor<ChatPresenter, ChatEntity> {
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<ChatService>
    
    // MARK: - Interactor
    
    func sendMessage(message: String) {
        guard let aesIV = self.appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = self.appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedMessage = IOAESUtilities.encrypt(string: message, keyData: aesKey, ivData: aesIV) else { return }
        
        let request = SendMessageRequestModel()
        request.toMemberID = self.entity.toMemberId
        request.encryptedMessage = encryptedMessage.base64EncodedString()
        
        self.service.request(.sendMessage(request: request), responseType: BaseResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                IOLogger.verbose("Response \(response)")
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
