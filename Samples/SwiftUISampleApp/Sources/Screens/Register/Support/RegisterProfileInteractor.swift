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
    
    private var authenticationService = IOServiceProviderImpl<AuthenticationService>()
    private var profilePictureService = IOServiceProviderImpl<ProfilePictureService>()
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func createProfile(
        birthDate: Date?,
        name: String?,
        surname: String?,
        locationName: String?,
        locationLatitude: Double?,
        locationLongitude: Double?,
        phoneNumber: String?,
        mrzFullString: String?
    ) async throws {
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
            deviceModel: UIDevice.current.model,
            mrzFullString: mrzFullString
        )
        
        let result = await service.async(.register(request: request), responseType: GenericResponseModel.self)
        
        switch result {
        case .success:
            try await authenticate()
            
        case .error(let message, let type, let response):
            hideIndicator()
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func uploadProfilePicture(image: UIImage) async {
        let result = await profilePictureService.async(.uploadProfilePicture(image: image.pngData()!), responseType: ImageCreateResponseModel.self)
        switch result {
        case .success:
            break
            
        case .error(let message, let type, let response):
            hideIndicator()
            await handleServiceErrorAsync(message, type: type, response: response)
        }
    }
    
    // MARK: - Helper Methods
    
    @MainActor
    private func authenticate() async throws {
        let request = AuthenticateRequestModel(email: entity.email, password: entity.password)
        let result = await authenticationService.async(.authenticate(request: request), responseType: AuthenticateResponseModel.self)
        
        switch result {
        case .success(let response):
            completeLogin(response: response)
            
        case .error(let message, let type, let response):
            hideIndicator()
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    private func completeLogin(response: AuthenticateResponseModel?) {
        guard let response else { return }
        
        localStorage.set(string: response.token ?? "", forType: .userToken)
        
        if var defaultHTTPHeaders = httpClient.defaultHTTPHeaders {
            defaultHTTPHeaders["X-IO-AUTHORIZATION-TOKEN"] = response.token ?? ""
            httpClient.setDefaultHTTPHeaders(headers: defaultHTTPHeaders)
        }
    }
}
