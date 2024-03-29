// 
//  ChatPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class ChatPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: ChatInteractor!
    public var navigationState: StateObject<ChatNavigationState>!
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Publics
    
    var scrollToLastMessage: Bool
    private(set) var messageCount: Int?
    
    // MARK: - Publishers
    
    @Published private(set) var chatMessages: [ChatItemUIModel]
    @Published private(set) var keyboardPublisher: AnyPublisher<Bool, Never>
    @Published private(set) var userNameSurname: String
    
    // MARK: - Privates
    
    private var isMessagesLoading: Bool
    private var pagination: PaginationModel!
    
    // MARK: - Initialization Methods
    
    public init() {
        self.isMessagesLoading = true
        self.scrollToLastMessage = true
        self.chatMessages = []
        self.userNameSurname = ""
        self.keyboardPublisher = Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in false }
            )
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Presenter
    
    func hideTabBar() {
        self.interactor.eventProcess.set(bool: false, forType: .tabBarVisibility)
    }
    
    func loadInitialMessages() {
        self.pagination = self.interactor.entity.pagination
        self.userNameSurname = self.interactor.entity.inbox.nameSurname ?? ""
        self.scrollToLastMessage = true
        self.updateMessages(messages: self.interactor.entity.messages)
    }
    
    @MainActor
    func loadPreviousMessages() async {
        if self.isMessagesLoading {
            return
        }
        
        self.isMessagesLoading = true
        
        let start = self.pagination.start ?? 0
        let pagination = PaginationModel(start: start + ChatConstants.messageCountPerPage, count: ChatConstants.messageCountPerPage, total: nil)
        
        do {
            guard let previousMessagesResponse = try await self.interactor.loadMessages(pagination: pagination) else { return }
            self.pagination = previousMessagesResponse.pagination
            self.messageCount = previousMessagesResponse.pagination?.count
            
            if let messages = previousMessagesResponse.messages, !messages.isEmpty {
                self.updateMessages(messages: messages)
            }
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func sendMessage(message: String) async {
        do {
            guard let lastMessage = try await self.interactor.sendMessage(message: message) else { return }
            
            let relativeDate = Date()
            let dateFormatter = RelativeDateTimeFormatter()
            dateFormatter.dateTimeStyle = .numeric
            
            let newMessage = ChatItemUIModel(
                id: lastMessage.messageID ?? 0,
                imagePublicID: lastMessage.userAvatarPublicID,
                chatMessage: self.interactor.decryptMessage(encryptedMessage: lastMessage.message ?? ""),
                isLastMessage: true,
                isSend: lastMessage.isSent ?? false,
                messageTime: dateFormatter.localizedString(for: lastMessage.messageDate ?? Date(), relativeTo: relativeDate)
            )
            
            self.scrollToLastMessage = true
            self.chatMessages.append(newMessage)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    func showTabBar() {
        self.interactor.eventProcess.set(bool: true, forType: .tabBarVisibility)
    }
    
    // MARK: - Helper Methods
    
    private func updateMessages(messages: [MessageModel]) {
        let relativeDate = Date()
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.dateTimeStyle = .numeric
        
        let lastMessageID = messages.last?.messageID ?? 0
        
        let mappedMessages = messages.map { [weak self] message in
            ChatItemUIModel(
                id: message.messageID ?? 0,
                imagePublicID: message.userAvatarPublicID,
                chatMessage: self?.interactor.decryptMessage(encryptedMessage: message.message ?? "") ?? "",
                isLastMessage: lastMessageID == message.messageID,
                isSend: message.isSent ?? false,
                messageTime: dateFormatter.localizedString(for: message.messageDate ?? Date(), relativeTo: relativeDate)
            )
        }
        
        self.chatMessages.insert(contentsOf: mappedMessages, at: 0)
        
        self.thread.runOnMainThread(afterMilliSecond: 250) { [weak self] in
            self?.isMessagesLoading = false
        }
    }
}

#if DEBUG
extension ChatPresenter {
    
    func prepareForPreview() {
        chatMessages = ChatPreviewData.previewData
    }
}
#endif
