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

final public class SplashInteractor: IOInteractor<SplashPresenter, SplashEntity> {
    
    // MARK: - Constants
    
    private let rsaKeyTag = "com.ilkerozcan.IOSwiftUISample.cryptographyKey"
    
    // MARK: - DI
    
    @IOInject private var httpClient: IOHTTPClientImpl
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<SplashService>
    
    // MARK: - Interactor
    
    func handshake() {
        self.showIndicator()
        
        self.service.request(.handshake, responseType: HandshakeResponseModel.self) { [weak self] result in
            switch result {
            case .success(response: let response):
                self?.setupCryptography(response: response)
                
            case .error(message: let message, type: let type, response: let response):
                self?.hideIndicator()
                self?.handleServiceError(message, type: type, response: response, handler: { _ in
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
            tag: self.rsaKeyTag
        ) {
            let aesIV = Data(secureRandomizedData: 16)
            let aesKey = Data(secureRandomizedData: 32)
            
            self.appState.set(object: aesIV, forType: .aesIV)
            self.appState.set(object: aesKey, forType: .aesKey)
            
            if
                let encryptedIV = IORSAEncryptionUtilities.encrypt(data: aesIV, publicKey: publicKey),
                let encryptedKey = IORSAEncryptionUtilities.encrypt(data: aesKey, publicKey: publicKey)
            {
                self.checkSessionIfNecessary(encryptedIV: encryptedIV, encryptedKey: encryptedKey)
            } else {
                self.handleServiceError(nil, type: .responseStatusError, response: nil) { _ in
                    exit(0)
                }
            }
        } else {
            self.handleServiceError(nil, type: .responseStatusError, response: nil) { _ in
                exit(0)
            }
        }
    }
    
    private func checkSessionIfNecessary(encryptedIV: Data, encryptedKey: Data) {
        if let token = self.localStorage.string(forType: .userToken) {
            self.setupHttpClientHeaders(encryptedIV: encryptedIV, encryptedKey: encryptedKey, token: token)
            self.checkToken()
            return
        }
        
        self.hideIndicator()
        self.setupHttpClientHeaders(encryptedIV: encryptedIV, encryptedKey: encryptedKey, token: nil)
        self.presenter?.updateButtons()
    }
    
    private func checkToken() {
        self.service.request(.checkToken, responseType: BaseResponseModel.self) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            case .success(response: _):
                self?.presenter?.navigateToHome()
                
            case .error(message: let message, type: let type, response: let response):
                self?.handleServiceError(message, type: type, response: response, handler: { [weak self] _ in
                    self?.localStorage.remove(type: .userToken)
                    self?.presenter?.updateButtons()
                })
            }
        }
    }
    
    private func setupHttpClientHeaders(encryptedIV: Data, encryptedKey: Data, token: String?) {
        var headers = [
            "Content-Type": "application/json",
            "X-IO-AUTHORIZATION": self.configuration.configForType(type: .networkingAuthorizationHeader),
            "X-SYMMETRIC-KEY": encryptedKey.base64EncodedString(),
            "X-SYMMETRIC-IV": encryptedIV.base64EncodedString()
        ]
        
        if let token {
            headers["X-IO-AUTHORIZATION-TOKEN"] = token
        }
        
        self.httpClient.setDefaultHTTPHeaders(headers: headers)
    }
}
