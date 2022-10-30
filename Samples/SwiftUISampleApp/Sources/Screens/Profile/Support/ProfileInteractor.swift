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
    @IOInstance private var service: IOServiceProviderImpl<ProfileService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func createInbox(memberID: Int) {
        self.showIndicator()
        
        let request = CreateInboxRequestModel(toMemberID: memberID)
        self.service.request(.createInbox(request: request), responseType: CreateInboxResponseModel.self) { result in
            self.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self.presenter?.navigate(toMemberId: request.toMemberID ?? 0, inbox: response.inbox)
                
            case .error(message: let message, type: let type, response: let response):
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
}
