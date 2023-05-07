// 
//  LoginInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct LoginInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: LoginEntity!
    public weak var presenter: LoginPresenter?
    
    // MARK: - Privates
    
    private var authenticationService = IOServiceProviderImpl<AuthenticationService>()
    private var service = IOServiceProviderImpl<LoginService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func checkMemberEmail(email: String) async throws {
        showIndicator()
        
        let request = CheckMemberRequestModel(email: email)
        let result = await authenticationService.async(.checkMember(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            throw IOInteractorError.service
            
        case .error:
            break
        }
    }    
}
