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
    
    // MARK: - Defs
    
    enum CreatePasswordError: Error {
        case encryptionError
    }
    
    // MARK: - Interactorable
    
    public var entity: RegisterCreatePasswordEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func hashPassword(password: String) throws -> String {
        guard let aesIV = appState.object(forType: .aesIV) as? Data else { throw CreatePasswordError.encryptionError }
        guard let aesKey = appState.object(forType: .aesKey) as? Data else { throw CreatePasswordError.encryptionError }
        
        guard let encryptedPassword = IOAESUtilities.encrypt(string: password, keyData: aesKey, ivData: aesIV) else {
            throw CreatePasswordError.encryptionError
        }
        
        return encryptedPassword.base64EncodedString()
    }
}
