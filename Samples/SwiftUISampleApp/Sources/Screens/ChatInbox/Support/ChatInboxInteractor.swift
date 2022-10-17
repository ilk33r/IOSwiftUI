// 
//  ChatInboxInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

final public class ChatInboxInteractor: IOInteractor<ChatInboxPresenter, ChatInboxEntity> {
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<ChatInboxService>
    
    // MARK: - Privates
    
    private var inboxes: [InboxModel]?
    
    // MARK: - Interactor
    
    func decryptMessage(_ message: String?) -> String {
        guard let message else { return "" }
        
        guard let aesIV = self.appState.object(forType: .aesIV) as? Data else { return "" }
        guard let aesKey = self.appState.object(forType: .aesKey) as? Data else { return "" }
        
        guard let decodedMessage = Data(base64Encoded: message) else { return "" }
        guard let decryptedMessage = IOAESUtilities.decrypt(data: decodedMessage, keyData: aesKey, ivData: aesIV) else { return "" }
        return String(data: decryptedMessage, encoding: .utf8) ?? ""
    }
    
    func getInboxes() {
        self.showIndicator()
        
        self.service.request(.getInboxes, responseType: InboxResponseModel.self) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self?.inboxes = response.inboxes
                self?.presenter?.update(inboxes: response.inboxes ?? [])
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
