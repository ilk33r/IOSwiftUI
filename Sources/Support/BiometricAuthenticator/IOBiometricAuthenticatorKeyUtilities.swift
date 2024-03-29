//
//  IOBiometricAuthenticatorKeyUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import LocalAuthentication
import Security

struct IOBiometricAuthenticatorKeyUtilities {
    
    // MARK: - Constants
    
    private static let ecKeySize = 256
    private static let tagPrefix = "com.ioswiftui.support.biometricAuthenticator.%@"
    
    // MARK: - Utilities
    
    static func create(forTag tag: String, context: LAContext) throws -> Data {
        // Delete old keys
        try? delete(forTag: tag)
        
        // Create key pair
        var privateKeyRef: SecKey!
        var publicKeyRef: SecKey!
        
        let accessControl = SecAccessControlCreateWithFlags(
            nil,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            SecAccessControlCreateFlags.biometryAny,
            nil
        )
        
        // Create a key attributes
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits: ecKeySize,
            kSecAttrApplicationTag: reformTag(tag: tag),
            kSecClass: kSecClassKey,
            kSecAttrSynchronizable: kCFBooleanFalse as Any,
            kSecPrivateKeyAttrs: [kSecAttrIsPermanent: kCFBooleanTrue],
            kSecPublicKeyAttrs: [kSecAttrIsPermanent: kCFBooleanTrue],
            kSecUseAuthenticationContext: context,
            kSecAttrAccessControl: accessControl as Any
        ] as NSDictionary
        
        // Create key pair
        let status = SecKeyGeneratePair(attributes, &publicKeyRef, &privateKeyRef)
        
        // Check status
        if status != noErr {
            // Obtain key for given tag
            throw IOBiometricAuthenticatorError.keyCreation
        }
        
        // Set exponent and modulus
        let biometricPublicKeyDataRef = SecKeyCopyExternalRepresentation(publicKeyRef, nil)
        guard let biometricPublicKey = biometricPublicKeyDataRef as? Data else {
            throw IOBiometricAuthenticatorError.keyCreation
        }
        
        let keyBytes = biometricPublicKey.bytes
        return Data(keyBytes)
    }
    
    static func delete(forTag tag: String) throws {
        // Create a key attributes
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits: ecKeySize,
            kSecAttrApplicationTag: reformTag(tag: tag),
            kSecClass: kSecClassKey,
            kSecAttrSynchronizable: kCFBooleanFalse as Any
        ] as NSDictionary
        
        // Update keychain item
        let status = SecItemDelete(attributes)
        
        // Check status
        if status != noErr {
            // Obtain key for given tag
            throw IOBiometricAuthenticatorError.keyNotFound
        }
    }
    
    static func exists(forTag tag: String) throws {
        // Create a key attributes
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits: ecKeySize,
            kSecAttrApplicationTag: reformTag(tag: tag),
            kSecClass: kSecClassKey,
            kSecAttrSynchronizable: kCFBooleanFalse as Any,
            kSecReturnRef: kCFBooleanFalse as Any,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecAttrKeyClass: kSecAttrKeyClassPublic
        ] as NSDictionary
        
        // Create a private key
        var publicKeyRef: AnyObject!
        
        // Obtain keychain item
        let status = SecItemCopyMatching(attributes, &publicKeyRef)
        
        // Check status
        if status != noErr {
            throw IOBiometricAuthenticatorError.keyNotFound
        }
    }
    
    static func sign(_ data: Data, forTag tag: String) throws -> Data {
        // Create a key attributes
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits: ecKeySize,
            kSecAttrApplicationTag: reformTag(tag: tag),
            kSecClass: kSecClassKey,
            kSecAttrSynchronizable: kCFBooleanFalse as Any,
            kSecReturnRef: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate
        ] as NSDictionary
        
        // Create a private key
        var privateKeyRef: AnyObject!
        
        // Obtain keychain item
        let status = SecItemCopyMatching(attributes, &privateKeyRef)
        
        // Check status
        if status == errSecUserCanceled {
            // Thrown an error
            throw IOBiometricAuthenticatorError.userCancelled
        } else if status != noErr {
            // Thrown an error
            throw IOBiometricAuthenticatorError.keyNotFound
        }
        
        // Cast key
        // swiftlint:disable force_cast
        let privateKey = privateKeyRef as! SecKey
        // swiftlint:enable force_cast
        
        // Create a signature
        guard let signedData = IOBiometricAuthenticatorSignUtilities.sign(data: data, privateKey: privateKey) else {
            // Thrown an error
            throw IOBiometricAuthenticatorError.dataSign
        }
        
        return signedData
    }
    
    // MARK: - Helper Methods
    
    private static func reformTag(tag: String) -> String {
        String(format: tagPrefix, tag)
    }
}
