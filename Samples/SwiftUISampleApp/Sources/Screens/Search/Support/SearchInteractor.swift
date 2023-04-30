// 
//  SearchInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct SearchInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: SearchEntity!
    public weak var presenter: SearchPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<SearchService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func discoverAll(start: Int, count: Int) async throws -> DiscoverImagesResponseModel? {
        let request = PaginationRequestModel(
            pagination: PaginationModel(start: start, count: count, total: 0)
        )
        let result = await service.async(.discoverAll(request: request), responseType: DiscoverImagesResponseModel.self)
        switch result {
        case .success(response: let response):
            return response
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func discoverMember(userName: String, start: Int, count: Int) async throws -> DiscoverImagesResponseModel? {
        let pagination = PaginationModel(start: start, count: count, total: 0)
        let request = DiscoverSearchMemberRequestModel(userName: userName, pagination: pagination)
        let result = await service.async(.discoverMember(request: request), responseType: DiscoverImagesResponseModel.self)
        switch result {
        case .success(response: let response):
            return response
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
}
