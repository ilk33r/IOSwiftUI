//
//  IOBiometricAuthenticator.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import LocalAuthentication
import IOSwiftUIInfrastructure

public struct IOBiometricAuthenticator {
    
    // MARK: - Defs
    
    public typealias OnCompleteHandler = (_ data: Data?, _ error: IOBiometricAuthenticatorError?) -> Void
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private let authenticationContext: LAContext
    
    // MARK: - Initialization Methods
    
    public init() {
        self.authenticationContext = LAContext()
        self.authenticationContext.touchIDAuthenticationAllowableReuseDuration = 3
    }
    
    // MARK: - Biometric Authenticator Methods
    
    public func checkBiometricStatus() throws -> Bool {
        // Create an error
        var contextError: NSError?
        
        // Check biometric authentication is available
        let canEvaluate = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &contextError)
        if let error = contextError {
            if error.code == LAError.Code.biometryLockout.rawValue {
                // Unlock biometric authentication
                IOLogger.error("Biometric authentication locked.")
                throw IOBiometricAuthenticatorError.locked
            }
            
            // Thrown an error
            IOLogger.error("Biometric authentication error.\n\(error.localizedDescription)")
            throw IOBiometricAuthenticatorError.doesNotSupport(message: error.localizedDescription)
        }
        
        if canEvaluate {
            var biometryExists = false
            
            // Check biometry types
            if authenticationContext.biometryType == .faceID {
                biometryExists = true
            } else if authenticationContext.biometryType == .touchID {
                biometryExists = true
            }
            
            // Check biometry exists
            if biometryExists {
                // Log call
                IOLogger.debug("Biometry Exists.")
                
                // Create key async
                return true
            } else {
                // Thrown an error
                IOLogger.error("Device does not supported face id or touch id.")
                throw IOBiometricAuthenticatorError.doesNotSupport(message: "DEVICE_DOES_NOT_SUPPORT_BIOMETRY")
            }
        }
        
        IOLogger.error("Can not evaluate local authentication policy.")
        throw IOBiometricAuthenticatorError.doesNotSupport(message: "CAN_NOT_EVALUATE_AUTH_POLICY")
    }
    
    public func isPaired(forUser user: String) throws -> Bool {
        try IOBiometricAuthenticatorKeyUtilities.exists(forTag: user)
        return true
    }
    
    public func unlockBiometricAuthentication(
        reason: IOLocalizationType,
        handler: @escaping OnCompleteHandler
    ) {
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: reason.localized
        ) { success, error in
            // Check error exist
            if let error {
                IOLogger.error("Biometry unlock error.\n\(error.localizedDescription)")
                handler(nil, IOBiometricAuthenticatorError.unlockError(message: error.localizedDescription))
                return
            }
            
            // Check status
            if success {
                handler(nil, nil)
            } else {
                IOLogger.error("Biometric authentication failed.")
                handler(nil, IOBiometricAuthenticatorError.authFailed)
            }
        }
    }
}
