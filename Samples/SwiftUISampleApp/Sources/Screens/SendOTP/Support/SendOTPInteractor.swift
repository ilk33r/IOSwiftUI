// 
//  SendOTPInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct SendOTPInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: SendOTPEntity!
    public weak var presenter: SendOTPPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<SendOTPService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func otpSend() {
        showIndicator()
        
        let request = SendOTPRequestModel(phoneNumber: entity.phoneNumber ?? "")
        service.request(.otpSend(request: request), responseType: SendOTPResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(response: let response):
                presenter?.update(otpTimeout: response.otpTimeout ?? 90)
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response) { _ in
                    entity.isPresented.wrappedValue = false
                }
            }
        }
    }
    
    func otpVerify(otp: String) {
        showIndicator()
        
        let request = VerifyOTPRequestModel(phoneNumber: entity.phoneNumber ?? "", otp: otp)
        service.request(.otpVerify(request: request), responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                entity.isOTPValidated.wrappedValue = true
                entity.isPresented.wrappedValue = false
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
