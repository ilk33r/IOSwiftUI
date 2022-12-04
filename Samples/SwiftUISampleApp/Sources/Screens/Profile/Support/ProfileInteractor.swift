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
    
    private var baseService = IOServiceProviderImpl<BaseService>()
    private var chatMessageService = IOServiceProviderImpl<ChatMessageService>()
    private var service = IOServiceProviderImpl<ProfileService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func createInbox(memberID: Int) {
        showIndicator()
        
        let request = CreateInboxRequestModel(toMemberID: memberID)
        service.request(.createInbox(request: request), responseType: CreateInboxResponseModel.self) { result in
            
            switch result {
            case .success(response: let response):
                getMessages(toMemberId: memberID, inbox: response.inbox)
                
            case .error(message: let message, type: let type, response: let response):
                hideIndicator()
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func followMember(memberID: Int) {
        showIndicator()
        
        let request = MemberFollowingRequestModel(memberID: memberID)
        service.request(.follow(request: request), responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                getMember()
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getMember() {
        showIndicator()
        
        let request = MemberGetRequestModel(userName: entity.userName)
        service.request(.memberGet(request: request), responseType: MemberGetResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(response: let response):
                presenter?.set(member: response.member)
                presenter?.update(member: response.member, isOwnProfile: entity.userName == nil ? true : false)
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getImages(start: Int, count: Int) {
        let pagination = PaginationModel(start: start, count: count, total: nil)
        let request = MemberImagesRequestModel(userName: entity.userName, pagination: pagination)
        
        service.request(.memberGetImages(request: request), responseType: MemberImagesResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                presenter?.update(imagesResponse: response)
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func unFollowMember(memberID: Int) {
        showIndicator()
        
        let request = MemberFollowingRequestModel(memberID: memberID)
        service.request(.unFollow(request: request), responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                getMember()
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func getMessages(toMemberId: Int?, inbox: InboxModel?) {
        let pagination = PaginationModel(start: 0, count: ChatConstants.messageCountPerPage, total: nil)
        let request = GetMessagesRequestModel(pagination: pagination, inboxID: inbox?.inboxID ?? 0)
        chatMessageService.request(.getMessages(request: request), responseType: GetMessagesResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(response: let response):
                presenter?.navigate(
                    toMemberId: toMemberId,
                    inbox: inbox,
                    messages: response.messages ?? [],
                    pagination: pagination
                )
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
                
            }
        }
    }
}
