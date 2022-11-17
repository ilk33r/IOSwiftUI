// 
//  WebInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct WebInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: WebEntity!
    public weak var presenter: WebPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<WebService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
