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
    public weak var presenter: ChatInboxPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var chatMessageService: IOServiceProviderImpl<ChatMessageService>
    @IOInstance private var service: IOServiceProviderImpl<ChatInboxService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
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
        
        self.service.request(.getInboxes, responseType: InboxResponseModel.self) { result in
            self.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self.presenter?.set(inboxListModel: response.inboxes)
                self.presenter?.update(inboxes: response.inboxes ?? [])
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getMessages(inbox: InboxModel) {
        self.showIndicator()
        
        let pagination = PaginationModel(start: 0, count: ChatConstants.messageCountPerPage, total: nil)
        let request = GetMessagesRequestModel(pagination: pagination, inboxID: inbox.inboxID ?? 0)
        self.chatMessageService.request(.getMessages(request: request), responseType: GetMessagesResponseModel.self) { result in
            self.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self.presenter?.navigate(
                    toMemberId: inbox.toMemberID,
                    inbox: inbox,
                    messages: response.messages ?? [],
                    pagination: pagination
                )
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
                
            }
        }
    }
}
