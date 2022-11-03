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

final public class ChatPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: ChatInteractor!
    
    // MARK: - Publishers
    
    @Published private(set) var chatMessages: [ChatItemUIModel]
    @Published private(set) var keyboardPublisher: AnyPublisher<Bool, Never>
    @Published private(set) var userNameSurname: String
    
    // MARK: - Privates
    
    private var pagination: PaginationModel!
    
    // MARK: - Initialization Methods
    
    public init() {
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
        self.interactor.appState.set(bool: true, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
    
    func loadInitialMessages() {
        self.pagination = self.interactor.entity.pagination
        self.userNameSurname = self.interactor.entity.inbox.nameSurname ?? ""
        self.updateMessages(messages: self.interactor.entity.messages)
    }
    
    func showTabBar() {
        self.interactor.appState.set(bool: false, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
    
    // MARK: - Helper Methods
    
    private func updateMessages(messages: [MessageModel]) {
        let relativeDate = Date()
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.dateTimeStyle = .numeric
        
        let lastMessageID = messages.last?.messageID ?? 0
        
        let mappedMessages = messages.map { [weak self] message in
            ChatItemUIModel(
                imagePublicID: message.userAvatarPublicID,
                chatMessage: self?.interactor.decryptMessage(encryptedMessage: message.message ?? "") ?? "",
                isLastMessage: lastMessageID == message.messageID,
                isSend: message.isSent ?? false,
                messageTime: dateFormatter.localizedString(for: message.messageDate ?? Date(), relativeTo: relativeDate)
            )
        }
        
        self.chatMessages.insert(contentsOf: mappedMessages, at: 0)
    }
}
