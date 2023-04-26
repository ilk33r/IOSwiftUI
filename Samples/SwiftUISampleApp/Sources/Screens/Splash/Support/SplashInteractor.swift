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
    
    @IOInject private var httpClient: IOHTTPClient
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<SplashService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    @MainActor
    func handshake() async throws {
        showIndicator()
        
        let headers = [
            "X-IO-AUTHORIZATION": configuration.configForType(type: .networkingAuthorizationHeader)
        ]
        httpClient.setDefaultHTTPHeaders(headers: headers)
        
        let result = await service.async(.handshake, responseType: HandshakeResponseModel.self)
        switch result {
        case .success(response: let response):
            try await setupCryptography(response: response)
            
        case .error(message: _, type: let type, response: let response):
            hideIndicator()
            await handleServiceErrorAsync(nil, type: type, response: response)
            exit(0)
        }
    }
    
    // MARK: - Helper Methods
    
    @MainActor
    private func setupCryptography(response: HandshakeResponseModel) async throws {
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
                try await checkSessionIfNecessary(encryptedIV: encryptedIV, encryptedKey: encryptedKey)
            } else {
                await handleServiceErrorAsync(nil, type: .responseStatusError, response: nil)
                exit(0)
            }
        } else {
            await handleServiceErrorAsync(nil, type: .responseStatusError, response: nil)
            exit(0)
        }
    }
    
    @MainActor
    private func checkSessionIfNecessary(encryptedIV: Data, encryptedKey: Data) async throws {
        if let token = localStorage.string(forType: .userToken) {
            setupHttpClientHeaders(encryptedIV: encryptedIV, encryptedKey: encryptedKey, token: token)
            try await checkToken()
            return
        }
        
        hideIndicator()
        setupHttpClientHeaders(encryptedIV: encryptedIV, encryptedKey: encryptedKey, token: nil)
        throw IOInteractorError.service
    }
    
    @MainActor
    private func checkToken() async throws {
        let result = await service.async(.checkToken, responseType: GenericResponseModel.self)
        hideIndicator()
        
        switch result {
        case .success:
            break
            
        case .error(_, let type, let response):
            await handleServiceErrorAsync(nil, type: type, response: response)
            localStorage.remove(type: .userToken)
            throw IOInteractorError.service
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
