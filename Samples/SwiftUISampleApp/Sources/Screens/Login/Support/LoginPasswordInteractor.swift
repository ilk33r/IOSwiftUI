// 
//  LoginPasswordInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct LoginPasswordInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: LoginPasswordEntity!
    public weak var presenter: LoginPasswordPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<LoginService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
