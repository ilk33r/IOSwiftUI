// 
//  RegisterInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct RegisterInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var authenticationService = IOServiceProviderImpl<AuthenticationService>()
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func checkMember(email: String) async throws {
        showIndicator()
        
        let request = CheckMemberRequestModel(email: email)
        let result = await authenticationService.async(.checkMember(request: request), responseType: GenericResponseModel.self)
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
