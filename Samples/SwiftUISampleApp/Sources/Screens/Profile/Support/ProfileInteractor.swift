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

final class ProfileInteractor: IOInteractor<ProfilePresenter, ProfileEntity> {
    
    // MARK: - Privates
    
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
                self?.presenter?.update(member: response)
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
