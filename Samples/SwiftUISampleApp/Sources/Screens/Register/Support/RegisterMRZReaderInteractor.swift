// 
//  RegisterMRZReaderInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct RegisterMRZReaderInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterMRZReaderEntity!
    public weak var presenter: RegisterMRZReaderPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
