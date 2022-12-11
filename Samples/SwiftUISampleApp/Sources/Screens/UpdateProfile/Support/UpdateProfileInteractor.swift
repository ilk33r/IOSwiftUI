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
    public weak var presenter: UpdateProfilePresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<UpdateProfileService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
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
    ) {
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
            deviceModel: UIDevice.current.model
        )
        
        service.request(.updateMember(request: request), responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                presenter?.updateSuccess()
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
