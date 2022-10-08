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

final class ProfileInteractor: IOInteractor<ProfilePresenter, ProfileEntity> {
    
    // MARK: - Privates
    
    @IOInstance private var baseService: IOServiceProviderImpl<BaseService>
    @IOInstance private var service: IOServiceProviderImpl<ProfileService>
    
    // MARK: - Interactor
    
    func getMember() {
        self.showIndicator()
        
        let request = MemberGetRequestModel()
        request.userName = self.entity.userName
        
        self.service.request(.memberGet(request: request), responseType: MemberGetResponseModel.self) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self?.presenter?.update(member: response.member)
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func getImages(start: Int, count: Int) {
        let request = PaginationRequestModel()
        request.pagination = PaginationModel()
        request.pagination?.start = start
        request.pagination?.count = count
        
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
