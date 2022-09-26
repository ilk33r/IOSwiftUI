//
//  IORSAKeyUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import Security

final public class IORSAKeyUtilities {
    
    public static func generatePublicKey(exponent: String, modulus: String, tag: String) -> SecKey? {
        let exponentData = Data(fromHexString: exponent)
        let modulusData = Data(fromHexString: modulus)
        return self.generatePublicKey(exponent: exponentData, modulus: modulusData, tag: tag)
    }
    
    public static func generatePublicKey(exponent: Data, modulus: Data, tag: String) -> SecKey? {
        let exponentBytes = exponent.bytes
        var modulusBytes = modulus.bytes
        
        // Make sure modulus starts with a 0x00
        if modulusBytes.first != 0x00 {
            modulusBytes.insert(0x00, at: 0)
        }
        
        // Obtain lengths
        let modulusLengthOctets = self.length(of: modulusBytes.count)
        let exponentLengthOctets = self.length(of: exponentBytes.count)
        let totalLengthOctets = self.length(of: modulusLengthOctets.count + modulusBytes.count + exponentLengthOctets.count + exponentBytes.count + 2)
        
        // Create encoded bytes
        var sequenceEncoded = [UInt8]()
        
        // Container type and size
        sequenceEncoded.append(0x30)
        sequenceEncoded.append(contentsOf: totalLengthOctets)
        
        // Modulus
        sequenceEncoded.append(0x02)
        sequenceEncoded.append(contentsOf: modulusLengthOctets)
        sequenceEncoded.append(contentsOf: modulusBytes)
        
        // Exponent
        sequenceEncoded.append(0x02)
        sequenceEncoded.append(contentsOf: exponentLengthOctets)
        sequenceEncoded.append(contentsOf: exponentBytes)
        
        // Generate key data
        let keyData = sequenceEncoded.data
        
        // Obtain existing key data
        if let publicKeyData = self.obtainKeyData(forTag: tag) {
            if !publicKeyData.elementsEqual(keyData) {
                // Then update key
                let updatedKey = self.updateKey(with: keyData, tag: tag)
                
                // Do nothing
                return updatedKey
            }
            
            return self.obtainKey(forTag: tag)
        }
        
        // Insert key
        if let publicKey = self.insertKey(with: keyData, tag: tag) {
            // Call handler
            return publicKey
        }
        
        // Obtain key from tag
        return self.obtainKey(forTag: tag)
    }
    
    // MARK: - Helper Methods
    
    private static func length(of value: Int) -> [UInt8] {
        // Check value length is less than 128
        if value < 128 {
            return [UInt8(value)]
        }
        
        // The number of bytes needed to encode count.
        let lengthBytesCount = UInt8(log2(Double(value)) / 8.0) + 1
        
        // The first byte in the length field encoding the number of remaining bytes.
        let firstLengthFieldByte = 0x80 + lengthBytesCount
        
        // Create length array
        var lengthField = [UInt8]()
        
        // Create current length
        var currentLength = value
        
        // Include the first byte.
        lengthField.append(firstLengthFieldByte)
        
        // Loop throught value
        for _ in 0..<lengthBytesCount {
            // Take the last 8 bits of count.
            let lengthByte = UInt8(currentLength & 0xFF)
            
            // Add them to the length field.
            lengthField.insert(lengthByte, at: 1)
            
            // Delete the last 8 bits of count.
            currentLength = currentLength >> 8
        }
        
        return lengthField
    }
    
    private static func insertKey(with keyData: Data, tag: String) -> SecKey? {
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrApplicationTag: tag,
            kSecValueData: keyData,
            kSecClass: kSecClassKey,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            kSecAttrSynchronizable: kCFBooleanFalse as Any
        ] as NSDictionary
        
        // Add keychain item
        let status = SecItemAdd(attributes, nil)
        
        // Check status
        if status == noErr {
            // Obtain key for given tag
            return self.obtainKey(forTag: tag)
        }
        
        return nil
    }
    
    private static func obtainKey(forTag tag: String) -> SecKey? {
        // Create a key attributes
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecReturnRef: kCFBooleanTrue as Any,
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: tag,
            kSecAttrSynchronizable: kSecAttrSynchronizableAny,
            kSecMatchLimit: kSecMatchLimitOne
        ] as NSDictionary
        
        // Create a public key
        var item: CFTypeRef?
        
        // Obtain public key from keychain
        let status = SecItemCopyMatching(attributes, &item)
        
        // Check an error exists
        if
            status == noErr,
            item != nil
        {
            return (item as! SecKey)
        }
        
        return nil
    }
    
    private static func obtainKeyData(forTag tag: String) -> Data? {
        // Create a key attributes
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecReturnAttributes: kCFBooleanTrue as Any,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: tag,
            kSecAttrSynchronizable: kSecAttrSynchronizableAny,
            kSecMatchLimit: kSecMatchLimitOne
        ]  as NSDictionary
        
        // Create a public key
        var item: CFTypeRef?
        
        // Obtain public key from keychain
        let status = SecItemCopyMatching(attributes, &item)
        
        // Check an error exists
        if
            status == noErr,
            let itemDictionary = item as? NSDictionary,
            let data = itemDictionary.object(forKey: kSecValueData) as? Data
        {
            return data
        }
        
        return nil
    }
    
    private static func updateKey(with data: Data, tag: String) -> SecKey? {
        // Create a key attributes
        let attributes = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: tag,
            kSecAttrSynchronizable: kSecAttrSynchronizableAny
        ]  as NSDictionary

        // Update attributes
        let updateAttributes = [
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
            kSecAttrSynchronizable: kCFBooleanFalse as Any
        ] as NSDictionary
        
        // Update keychain item
        let status = SecItemUpdate(attributes, updateAttributes)
        
        // Check status
        if status == noErr {
            // Obtain key for given tag
            return self.obtainKey(forTag: tag)
        }
        
        return nil
    }
}
