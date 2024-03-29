// 
//  DiscoverInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct DiscoverInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: DiscoverEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<DiscoverService>()
    private var storyService = IOServiceProviderImpl<StoryService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func discover(start: Int, count: Int) async throws -> DiscoverImagesResponseModel? {
        let pagination = PaginationModel(start: start, count: count, total: nil)
        let request = PaginationRequestModel(pagination: pagination)
        
        let result = await service.async(.discover(request: request), responseType: DiscoverImagesResponseModel.self)
        switch result {
        case .success(response: let response):
            return response
            
        case .error(message: let message, type: let type, response: let response):
            await handleServiceErrorAsync(message, type: type, response: response)
            throw IOInteractorError.service
        }
    }
    
    @MainActor
    func stories() async -> DiscoverStoriesResponseModel? {
        let result = await storyService.async(.discoverStories, responseType: DiscoverStoriesResponseModel.self)
        
        switch result {
        case .success(let response):
            return response
            
        case .error:
            return nil
        }
    }
}
