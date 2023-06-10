// 
//  ChatInboxPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class ChatInboxPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: ChatInboxInteractor!
    public var navigationState: StateObject<ChatInboxNavigationState>!
    
    // MARK: - Publisher
    
    @Published private(set) var inboxes: [ChatInboxUIModel]
    
    // MARK: - Privates
    
    private var inboxListModel: [InboxModel]?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.inboxes = []
    }
    
    // MARK: - Presenter
    
    @MainActor
    func prepare() async {
        self.showIndicator()
        await self.getInboxes()
    }
    
    @MainActor
    func deleteInbox(index: Int) async {
        guard let inbox = self.inboxListModel?[index] else { return }
        
        do {
            try await self.interactor.deleteInbox(inboxID: inbox.inboxID ?? 0)
            await self.getInboxes()
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func getInboxes() async {
        do {
            self.inboxListModel = try await self.interactor.getInboxes()
            self.hideIndicator()
            
            self.inboxes = self.inboxListModel?.enumerated().map { [weak self] it in
                let lastMessage: String
                
                if let encryptedMessage = it.element.lastMessage?.message {
                    lastMessage = self?.interactor.decryptMessage(encryptedMessage) ?? ""
                } else {
                    lastMessage = ""
                }
                
                return ChatInboxUIModel(
                    index: it.offset,
                    profilePicturePublicId: it.element.profilePicturePublicID ?? "",
                    nameSurname: it.element.nameSurname ?? "",
                    lastMessage: lastMessage
                )
            } ?? []
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func getMessages(index: Int) async {
        guard let inbox = self.inboxListModel?[index] else { return }
        let pagination = PaginationModel(start: 0, count: ChatConstants.messageCountPerPage, total: nil)
        
        do {
            let messages = try await self.interactor.getMessages(inboxID: inbox.inboxID ?? 0, pagination: pagination)
            self.navigationState.wrappedValue.navigateToChat(
                chatEntity: ChatEntity(
                    toMemberId: inbox.toMemberID,
                    inbox: inbox,
                    messages: messages,
                    pagination: pagination
                )
            )
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}

#if DEBUG
extension ChatInboxPresenter {
    
    func prepareForPreview() {
        self.inboxes = ChatInboxPreviewData.previewData
    }
}
#endif
