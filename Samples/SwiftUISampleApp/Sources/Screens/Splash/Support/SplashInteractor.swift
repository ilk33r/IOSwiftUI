//
//  SplashInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct SplashInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: SplashEntity!
    public weak var presenter: SplashPresenter?
    
    // MARK: - Constants
    
    private let rsaKeyTag = "com.ilkerozcan.IOSwiftUISample.cryptographyKey"
    
    // MARK: - DI
    
    @IOInject private var httpClient: IOHTTPClientImpl
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<SplashService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func handshake() {
        showIndicator()
        
        service.request(.handshake, responseType: HandshakeResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                setupCryptography(response: response)
                
            case .error(message: let message, type: let type, response: let response):
                hideIndicator()
                handleServiceError(message, type: type, response: response, handler: { _ in
                    exit(0)
                })
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func setupCryptography(response: HandshakeResponseModel) {            
        if
            let exponent = response.publicKeyExponent,
            let modulus = response.publicKeyModulus,
            let publicKey = IORSAKeyUtilities.generatePublicKey(
            exponent: exponent,
            modulus: modulus,
            tag: rsaKeyTag
        ) {
            let aesIV = Data(secureRandomizedData: 16)
            let aesKey = Data(secureRandomizedData: 32)
            
            appState.set(object: aesIV, forType: .aesIV)
            appState.set(object: aesKey, forType: .aesKey)
            
            if
                let encryptedIV = IORSAEncryptionUtilities.encrypt(data: aesIV, publicKey: publicKey),
                let encryptedKey = IORSAEncryptionUtilities.encrypt(data: aesKey, publicKey: publicKey)
            {
                checkSessionIfNecessary(encryptedIV: encryptedIV, encryptedKey: encryptedKey)
            } else {
                handleServiceError(nil, type: .responseStatusError, response: nil) { _ in
                    exit(0)
                }
            }
        } else {
            handleServiceError(nil, type: .responseStatusError, response: nil) { _ in
                exit(0)
            }
        }
    }
    
    private func checkSessionIfNecessary(encryptedIV: Data, encryptedKey: Data) {
        if let token = localStorage.string(forType: .userToken) {
            setupHttpClientHeaders(encryptedIV: encryptedIV, encryptedKey: encryptedKey, token: token)
            checkToken()
            return
        }
        
        hideIndicator()
        setupHttpClientHeaders(encryptedIV: encryptedIV, encryptedKey: encryptedKey, token: nil)
        presenter?.updateButtons()
    }
    
    private func checkToken() {
        service.request(.checkToken, responseType: GenericResponseModel.self) { result in
            hideIndicator()
            
            switch result {
            case .success(response: _):
                presenter?.navigateToHome()
                
            case .error(message: let message, type: let type, response: let response):
                handleServiceError(message, type: type, response: response, handler: { _ in
                    localStorage.remove(type: .userToken)
                    presenter?.updateButtons()
                })
            }
        }
    }
    
    private func setupHttpClientHeaders(encryptedIV: Data, encryptedKey: Data, token: String?) {
        var headers = [
            "X-IO-AUTHORIZATION": configuration.configForType(type: .networkingAuthorizationHeader),
            "X-SYMMETRIC-KEY": encryptedKey.base64EncodedString(),
            "X-SYMMETRIC-IV": encryptedIV.base64EncodedString()
        ]
        
        if let token {
            headers["X-IO-AUTHORIZATION-TOKEN"] = token
        }
        
        httpClient.setDefaultHTTPHeaders(headers: headers)
    }
}
