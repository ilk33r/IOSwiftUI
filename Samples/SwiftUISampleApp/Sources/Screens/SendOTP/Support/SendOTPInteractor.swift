// 
//  SendOTPInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct SendOTPInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: SendOTPEntity!
    public weak var presenter: SendOTPPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<SendOTPService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
