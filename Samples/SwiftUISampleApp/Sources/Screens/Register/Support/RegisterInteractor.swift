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
    public weak var presenter: RegisterPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func checkMember(email: String) {
        showIndicator()
        
        let request = CheckMemberRequestModel(email: email)
        service.request(.checkMember(request: request), responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                presenter?.navigateToUserName(email: email)
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
