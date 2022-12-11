// 
//  RegisterCreatePasswordInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct RegisterCreatePasswordInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterCreatePasswordEntity!
    public weak var presenter: RegisterCreatePasswordPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func hashPassword(password: String) {
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { return }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { return }
        
        guard let encryptedPassword = IOAESUtilities.encrypt(string: password, keyData: aesKey, ivData: aesIV) else { return }
        presenter?.navigateToProfile(hashedPassword: encryptedPassword.base64EncodedString())
    }
}
