// 
//  UpdateProfileInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct UpdateProfileInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: UpdateProfileEntity!
    public weak var presenter: UpdateProfilePresenter?
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<UpdateProfileService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
