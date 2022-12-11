// 
//  RegisterUserNameInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct RegisterUserNameInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterUserNameEntity!
    public weak var presenter: RegisterUserNamePresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func checkUserName(userName: String) {
        showIndicator()
        
        let request = CheckMemberUserNameRequestModel(userName: userName)
        service.request(.checkMemberUserName(request: request), responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                presenter?.navigateToCreatePassword(
                    email: entity.email,
                    userName: userName
                )
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
