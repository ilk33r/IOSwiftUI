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
    public weak var presenter: DiscoverPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<DiscoverService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func discover(start: Int, count: Int) {
        let pagination = PaginationModel(start: start, count: count, total: nil)
        let request = PaginationRequestModel(pagination: pagination)
        
        self.service.request(.discover(request: request), responseType: DiscoverImagesResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                self.presenter?.update(discoverResponse: response)
                
            case .error(message: let message, type: let type, response: let response):
                self.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
