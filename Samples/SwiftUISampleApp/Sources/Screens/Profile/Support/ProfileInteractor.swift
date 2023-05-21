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
    
    @MainActor
    func followMember(memberID: Int) async throws -> MemberModel? {
        showIndicator()
        
        let request = MemberFollowingRequestModel(memberID: memberID)
        let result = await service.async(.follow(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
            
        switch result {
        case .success:
            return try await getMember()
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func getFriends() async throws -> MemberFriendsResponseModel {
        showIndicator()
        
        let result = await service.async(.getFriends, responseType: MemberFriendsResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success(let response):
            return response
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func getMember() async throws -> MemberModel? {
        showIndicator()
        
        let request = MemberGetRequestModel(userName: entity.userName)
        let result = await service.async(.memberGet(request: request), responseType: MemberGetResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success(let response):
            return response.member
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
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
    
    @MainActor
    func unFollowMember(memberID: Int) async throws -> MemberModel? {
        showIndicator()
        
        let request = MemberFollowingRequestModel(memberID: memberID)
        let result = await service.async(.unFollow(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            return try await getMember()
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
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
