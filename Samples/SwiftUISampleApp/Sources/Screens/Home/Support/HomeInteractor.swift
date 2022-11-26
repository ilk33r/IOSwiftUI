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
    public weak var presenter: HomePresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<HomeService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func uploadImage(image: UIImage) {
        showIndicator()
        
        service.request(.addMemberImage(image: image.pngData()!), responseType: ImageCreateResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(_):
                showAlert {
                    IOAlertData(title: nil, message: .homeSuccessUploadImage, buttons: [.commonOk], handler: nil)
                }
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
}
