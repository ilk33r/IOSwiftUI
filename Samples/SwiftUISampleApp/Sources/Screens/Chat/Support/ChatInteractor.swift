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
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var chatMessageService = IOServiceProviderImpl<ChatMessageService>()
    private var service = IOServiceProviderImpl<ChatService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func decryptMessage(encryptedMessage: String) -> String {
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return "" }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return "" }
        
        guard let decodedMessage = Data(base64Encoded: encryptedMessage) else { return "" }
        guard let decryptedMessage = IOAESUtilities.decrypt(data: decodedMessage, keyData: aesKey, ivData: aesIV) else { return "" }
        return String(data: decryptedMessage, encoding: .utf8) ?? ""
    }
    
    @MainActor
    func loadMessages(pagination: PaginationModel) async throws -> GetMessagesResponseModel? {
        let request = GetMessagesRequestModel(pagination: pagination, inboxID: entity.inbox.inboxID)
        let result = await chatMessageService.async(.getMessages(request: request), responseType: GetMessagesResponseModel.self)
        
        switch result {
        case .success(let response):
            return response
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func sendMessage(message: String) async throws -> MessageModel? {
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return nil }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return nil }
        guard let encryptedMessage = IOAESUtilities.encrypt(string: message, keyData: aesKey, ivData: aesIV) else { return nil }
        
        let request = SendMessageRequestModel(toMemberID: entity.toMemberId, encryptedMessage: encryptedMessage.base64EncodedString())
        let result = await service.async(.sendMessage(request: request), responseType: GetMessagesResponseModel.self)
        
        switch result {
        case .success(let response):
            return response.messages?.first
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
