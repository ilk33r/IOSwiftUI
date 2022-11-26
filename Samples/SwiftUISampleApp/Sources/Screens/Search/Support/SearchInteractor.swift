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
    
    func discoverAll(start: Int, count: Int) {
        showIndicator()
        
        let request = PaginationRequestModel(
            pagination: PaginationModel(start: start, count: count, total: 0)
        )
        service.request(.discoverAll(request: request), responseType: DiscoverImagesResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(response: let response):
                presenter?.update(discoverResponse: response)
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
