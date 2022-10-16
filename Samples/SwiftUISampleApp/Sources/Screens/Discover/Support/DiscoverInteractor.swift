// 
//  DiscoverInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

final public class DiscoverInteractor: IOInteractor<DiscoverPresenter, DiscoverEntity> {
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<DiscoverService>
    
    // MARK: - Interactor
    
    func discover(start: Int, count: Int) {
        let request = PaginationRequestModel()
        request.pagination = PaginationModel()
        request.pagination?.start = start
        request.pagination?.count = count
        
        self.service.request(.discover(request: request), responseType: DiscoverImagesResponseModel.self) { [weak self] result in
            switch result {
            case .success(response: let response):
                self?.presenter?.update(discoverResponse: response)
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
