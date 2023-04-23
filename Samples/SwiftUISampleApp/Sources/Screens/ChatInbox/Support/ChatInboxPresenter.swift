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
    
    func deleteInbox(index: Int) {
        guard let inbox = self.inboxListModel?[index] else { return }
        self.interactor.deleteInbox(inboxID: inbox.inboxID ?? 0)
    }
    
    func getMessages(index: Int) {
        guard let inbox = self.inboxListModel?[index] else { return }
        self.interactor.getMessages(inbox: inbox)
    }
    
    func navigate(toMemberId: Int?, inbox: InboxModel?, messages: [MessageModel], pagination: PaginationModel) {
        guard let inbox else { return }
        
        self.navigationState.wrappedValue.chatEntity = ChatEntity(toMemberId: toMemberId, inbox: inbox, messages: messages, pagination: pagination)
        self.navigationState.wrappedValue.navigateToChat = true
    }
    
    func set(inboxListModel: [InboxModel]?) {
        self.inboxListModel = inboxListModel
    }
    
    func update(inboxes: [InboxModel]) {
        self.inboxes = inboxes.enumerated().map({ [weak self] it in
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
        })
    }
}
