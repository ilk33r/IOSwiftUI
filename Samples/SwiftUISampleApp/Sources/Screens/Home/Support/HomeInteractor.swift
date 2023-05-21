// 
//  HomeInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import UIKit

public struct HomeInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: HomeEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<HomeService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func uploadImage(image: UIImage) async throws {
        showIndicator()
        
        let result = await service.async(.addMemberImage(image: image.pngData()!), responseType: ImageCreateResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            break
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
