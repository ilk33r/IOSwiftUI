// 
//  RegisterNFCReaderViewInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct RegisterNFCReaderViewInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterNFCReaderViewEntity!
    public weak var presenter: RegisterNFCReaderViewPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
