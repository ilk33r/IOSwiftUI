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
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var baseService = IOServiceProviderImpl<BaseService>()
    private var chatMessageService = IOServiceProviderImpl<ChatMessageService>()
    private var service = IOServiceProviderImpl<ProfileService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func createInbox(memberID: Int) async throws -> InboxModel? {
        showIndicator()
        
        let request = CreateInboxRequestModel(toMemberID: memberID)
        let result = await service.async(.createInbox(request: request), responseType: CreateInboxResponseModel.self)
        
        switch result {
        case .success(let response):
            return response.inbox
            
        case .error(let message, let type, let response):
            hideIndicator()
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
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
    
    @MainActor
    func getMessages(memberID: Int?, inboxID: Int) async throws -> GetMessagesResponseModel {
        let pagination = PaginationModel(start: 0, count: ChatConstants.messageCountPerPage, total: nil)
        let request = GetMessagesRequestModel(pagination: pagination, inboxID: inboxID)
        
        let result = await chatMessageService.async(.getMessages(request: request), responseType: GetMessagesResponseModel.self)
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
    func getImages(start: Int, count: Int) async throws -> MemberImagesResponseModel {
        let pagination = PaginationModel(start: start, count: count, total: nil)
        let request = MemberImagesRequestModel(userName: entity.userName, pagination: pagination)
        
        let result = await service.async(.memberGetImages(request: request), responseType: MemberImagesResponseModel.self)
        
        switch result {
        case .success(let response):
            return response
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
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
    
    @MainActor
    func prefetchMember(userName: String?) async throws -> MemberModel? {
        let request = MemberGetRequestModel(userName: userName)
        let result = await service.async(.memberGet(request: request), responseType: MemberGetResponseModel.self)
        
        switch result {
        case .success(let response):
            return response.member
            
        case .error(let message, _, _):
            throw IOPresenterError.prefetch(title: nil, message: message ?? "", buttonTitle: IOLocalizationType.commonOk.localized)
        }
    }
}
