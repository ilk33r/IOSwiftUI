// 
//  RegisterProfileInteractor.swift
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
import UIKit

public struct RegisterProfileInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterProfileEntity!
    public weak var presenter: RegisterProfilePresenter?
    
    // MARK: - DI
    
    @IOInject private var httpClient: IOHTTPClient
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func createProfile(
        birthDate: Date?,
        name: String?,
        surname: String?,
        locationName: String?,
        locationLatitude: Double?,
        locationLongitude: Double?,
        phoneNumber: String?
    ) {
        showIndicator()
        
        let request = RegisterMemberRequestModel(
            userName: entity.userName,
            password: entity.password,
            birthDate: birthDate,
            email: entity.email,
            name: name, surname: surname,
            locationName: locationName,
            locationLatitude: locationLatitude,
            locationLongitude: locationLongitude,
            phoneNumber: phoneNumber,
            deviceId: UIDevice.current.identifierForVendor?.uuidString ?? "",
            deviceManifacturer: UIDevice.current.systemName,
            deviceModel: UIDevice.current.model
        )
        service.request(.register(request: request), responseType: GenericResponseModel.self) { result in
            switch result {
            case .success(_):
                authenticate()
                
            case .error(message: let message, type: let type, response: let response):
                hideIndicator()
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    func uploadProfilePicture(image: UIImage) {
        service.request(.uploadProfilePicture(image: image.pngData()!), responseType: ImageCreateResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                presenter?.navigateToHome()
                
            case .error(message: let message, type: let type, response: let response):
                hideIndicator()
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func authenticate() {
        /*
        let request = AuthenticateRequestModel(email: entity.email, password: entity.password)
        service.request(.authenticate(request: request), responseType: AuthenticateResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                completeLogin(response: response)
                
            case .error(message: let message, type: let type, response: let response):
                hideIndicator()
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
        */
    }
    
    private func completeLogin(response: AuthenticateResponseModel?) {
        guard let response else { return }
        
        localStorage.set(string: response.token ?? "", forType: .userToken)
        
        if var defaultHTTPHeaders = httpClient.defaultHTTPHeaders {
            defaultHTTPHeaders["X-IO-AUTHORIZATION-TOKEN"] = response.token ?? ""
            httpClient.setDefaultHTTPHeaders(headers: defaultHTTPHeaders)
        }
        
        presenter?.registerCompleted()
    }
}
