// 
//  ChatInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct ChatInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: ChatEntity!
    public weak var presenter: ChatPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var chatMessageService: IOServiceProviderImpl<ChatMessageService>
    @IOInstance private var service: IOServiceProviderImpl<ChatService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func decryptMessage(encryptedMessage: String) -> String {
        guard let aesIV = self.appState.object(forType: .aesIV) as? Data else { return "" }
        guard let aesKey = self.appState.object(forType: .aesKey) as? Data else { return "" }
        
        guard let decodedMessage = Data(base64Encoded: encryptedMessage) else { return "" }
        guard let decryptedMessage = IOAESUtilities.decrypt(data: decodedMessage, keyData: aesKey, ivData: aesIV) else { return "" }
        return String(data: decryptedMessage, encoding: .utf8) ?? ""
    }
    
    func loadMessages(pagination: PaginationModel) {
        self.showIndicator()
        
        let request = GetMessagesRequestModel(pagination: pagination, inboxID: self.entity.inbox.inboxID)
        self.chatMessageService.request(.getMessages(request: request), responseType: GetMessagesResponseModel.self) { result in
            self.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self.presenter?.update(previousMessagesResponse: response)
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func sendMessage(message: String) {
        guard let aesIV = self.appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = self.appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedMessage = IOAESUtilities.encrypt(string: message, keyData: aesKey, ivData: aesIV) else { return }
        
        let request = SendMessageRequestModel(toMemberID: self.entity.toMemberId, encryptedMessage: encryptedMessage.base64EncodedString())
        self.service.request(.sendMessage(request: request), responseType: GetMessagesResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                self.presenter?.update(lastMessage: response.messages?.first)
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
