// 
//  ProfileInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure
import SwiftUISampleAppScreensShared

public struct ProfileInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: ProfileEntity!
    public weak var presenter: ProfilePresenter?
    
    // MARK: - Privates
    
    @IOInstance private var baseService: IOServiceProviderImpl<BaseService>
    @IOInstance private var chatService: IOServiceProviderImpl<ChatService>
    @IOInstance private var service: IOServiceProviderImpl<ProfileService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func createInbox(memberID: Int) {
        self.showIndicator()
        
        let request = CreateInboxRequestModel(toMemberID: memberID)
        self.service.request(.createInbox(request: request), responseType: CreateInboxResponseModel.self) { result in
            
            switch result {
            case .success(response: let response):
                self.getMessages(toMemberId: memberID, inbox: response.inbox)
                
            case .error(message: let message, type: let type, response: let response):
                self.hideIndicator()
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getMember() {
        self.showIndicator()
        
        let request = MemberGetRequestModel(userName: self.entity.userName)
        self.service.request(.memberGet(request: request), responseType: MemberGetResponseModel.self) { result in
            self.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self.presenter?.set(member: response.member)
                self.presenter?.update(member: response.member, isOwnProfile: self.entity.userName == nil ? true : false)
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getImages(start: Int, count: Int) {
        let pagination = PaginationModel(start: start, count: count, total: nil)
        let request = MemberImagesRequestModel(userName: self.entity.userName, pagination: pagination)
        
        self.service.request(.memberGetImages(request: request), responseType: MemberImagesResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                self.presenter?.update(imagesResponse: response)
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func getMessages(toMemberId: Int?, inbox: InboxModel?) {
        let pagination = PaginationModel(start: 0, count: ChatConstants.messageCountPerPage, total: nil)
        let request = GetMessagesRequestModel(pagination: pagination, inboxID: inbox?.inboxID ?? 0)
        self.chatService.request(.getMessages(request: request), responseType: GetMessagesResponseModel.self) { result in
            self.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self.presenter?.navigate(
                    toMemberId: toMemberId,
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
