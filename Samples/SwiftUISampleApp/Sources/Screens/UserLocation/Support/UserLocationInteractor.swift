// 
//  UserLocationInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct UserLocationInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: UserLocationEntity!
    public weak var presenter: UserLocationPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<UserLocationService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
