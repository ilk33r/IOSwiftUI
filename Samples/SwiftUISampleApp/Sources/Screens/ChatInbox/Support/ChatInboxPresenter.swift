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
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUI

final public class ChatInboxPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: ChatInboxInteractor!
    
    // MARK: - Publisher
    
    @Published var inboxes: [ChatInboxUIModel]
    
    // MARK: - Privates
    
    private var inboxListModel: [InboxModel]?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.inboxes = []
    }
    
    // MARK: - Presenter
    
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
