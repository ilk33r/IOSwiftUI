// 
//  ChatInboxInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct ChatInboxInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: ChatInboxEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var chatMessageService = IOServiceProviderImpl<ChatMessageService>()
    private var service = IOServiceProviderImpl<ChatInboxService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func decryptMessage(_ message: String?) -> String {
        guard let message else { return "" }
        
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return "" }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return "" }
        
        guard let decodedMessage = Data(base64Encoded: message) else { return "" }
        guard let decryptedMessage = IOAESUtilities.decrypt(data: decodedMessage, keyData: aesKey, ivData: aesIV) else { return "" }
        return String(data: decryptedMessage, encoding: .utf8) ?? ""
    }
    
    @MainActor
    func deleteInbox(inboxID: Int) async throws {
        showIndicator()
        
        let request = DeleteInboxRequestModel(inboxID: inboxID)
        let result = await service.async(.deleteInbox(request: request), responseType: GenericResponseModel.self)
        
        switch result {
        case .success:
            break
            
        case .error(let message, let type, let response):
            hideIndicator()
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func getInboxes() async throws -> [InboxModel] {
        let result = await service.async(.getInboxes, responseType: InboxResponseModel.self)
        
        switch result {
        case .success(let response):
            return response.inboxes ?? []
            
        case .error(let message, let type, let response):
            hideIndicator()
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func getMessages(inboxID: Int, pagination: PaginationModel) async throws -> [MessageModel] {
        showIndicator()
        
        let request = GetMessagesRequestModel(pagination: pagination, inboxID: inboxID)
        let result = await chatMessageService.async(.getMessages(request: request), responseType: GetMessagesResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success(let response):
            return response.messages ?? []
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
