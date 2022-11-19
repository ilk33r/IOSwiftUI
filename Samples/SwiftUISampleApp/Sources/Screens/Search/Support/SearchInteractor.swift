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
}
