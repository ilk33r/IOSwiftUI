// 
//  RegisterUserNameInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct RegisterUserNameInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterUserNameEntity!
    public weak var presenter: RegisterUserNamePresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterUserNameService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
