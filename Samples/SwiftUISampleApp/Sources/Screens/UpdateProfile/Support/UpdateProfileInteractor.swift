// 
//  UpdateProfileInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import UIKit

public struct UpdateProfileInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: UpdateProfileEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<UpdateProfileService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func updateMember(
        userName: String?,
        birthDate: Date?,
        email: String?,
        name: String?,
        surname: String?,
        locationName: String?,
        locationLatitude: Double?,
        locationLongitude: Double?,
        phoneNumber: String?
    ) async throws {
        showIndicator()
        
        let request = RegisterMemberRequestModel(
            userName: userName,
            password: "666 333 999",
            birthDate: birthDate,
            email: email,
            name: name,
            surname: surname,
            locationName: locationName,
            locationLatitude: locationLatitude,
            locationLongitude: locationLongitude,
            phoneNumber: phoneNumber,
            deviceId: UIDevice.current.identifierForVendor?.uuidString ?? "",
            deviceManifacturer: UIDevice.current.systemName,
            deviceModel: UIDevice.current.model,
            mrzFullString: ""
        )
        
        let result = await service.async(.updateMember(request: request), responseType: GenericResponseModel.self)
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
