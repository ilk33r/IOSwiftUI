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
    
    private var authenticationService = IOServiceProviderImpl<AuthenticationService>()
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func checkUserName(userName: String) async throws {
        showIndicator()
        
        let request = CheckMemberUserNameRequestModel(userName: userName)
        let result = await authenticationService.async(.checkMemberUserName(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            break
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
