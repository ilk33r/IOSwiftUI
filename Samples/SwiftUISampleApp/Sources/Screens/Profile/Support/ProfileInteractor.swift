// 
//  ProfileInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure
import SwiftUISampleAppScreensShared

final public class ProfileInteractor: IOInteractor<ProfilePresenter, ProfileEntity> {
    
    // MARK: - Privates
    
    @IOInstance private var baseService: IOServiceProviderImpl<BaseService>
    @IOInstance private var service: IOServiceProviderImpl<ProfileService>
    
    private var member: MemberModel?
    
    // MARK: - Interactor
    
    func createInbox() {
        self.showIndicator()
        
        let request = CreateInboxRequestModel()
        request.toMemberID = member?.id ?? 0
        
        self.service.request(.createInbox(request: request), responseType: CreateInboxResponseModel.self) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self?.presenter?.navigate(inbox: response.inbox)
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getMember() {
        self.showIndicator()
        
        let request = MemberGetRequestModel()
        request.userName = self.entity.userName
        
        self.service.request(.memberGet(request: request), responseType: MemberGetResponseModel.self) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self?.member = response.member
                self?.presenter?.update(member: response.member, isOwnProfile: self?.entity.userName == nil ? true : false)
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getImages(start: Int, count: Int) {
        let request = MemberImagesRequestModel()
        request.pagination = PaginationModel()
        request.pagination?.start = start
        request.pagination?.count = count
        request.userName = self.entity.userName
        
        self.service.request(.memberGetImages(request: request), responseType: MemberImagesResponseModel.self) { [weak self] result in
            switch result {
            case .success(response: let response):
                self?.presenter?.update(imagesResponse: response)
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
