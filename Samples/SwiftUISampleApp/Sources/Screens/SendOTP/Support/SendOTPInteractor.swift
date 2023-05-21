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
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<SendOTPService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func otpSend() async throws -> Int {
        showIndicator()
        
        let request = SendOTPRequestModel(phoneNumber: entity.phoneNumber ?? "")
        let result = await service.async(.otpSend(request: request), responseType: SendOTPResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success(let response):
            return response.otpTimeout ?? 90
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            entity.isPresented.wrappedValue = false
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func otpVerify(otp: String) async throws {
        showIndicator()
        
        let request = VerifyOTPRequestModel(phoneNumber: entity.phoneNumber ?? "", otp: otp)
        let result = await service.async(.otpVerify(request: request), responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            entity.isOTPValidated.wrappedValue = true
            entity.isPresented.wrappedValue = false
            
        case .error(let message, let type, let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
