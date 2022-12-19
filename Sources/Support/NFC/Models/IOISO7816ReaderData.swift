//
//  IOISO7816ReaderData.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation

public struct IOISO7816ReaderData: IONFCTagReaderData {
    
    // MARK: - Publics
    
    public var describing: Any {
        // Calculate checksums
        let documentNumberChecksum = self.calculateChecksum(checkString: self.documentNumber)
        let birthDateChecksum = self.calculateChecksum(checkString: self.birthdate)
        let validUntilDateChecksum = self.calculateChecksum(checkString: self.validUntilDate)
        
        // Create mrz
        return String(
            format: "%@%d%@%d%@%d",
            self.documentNumber,
            documentNumberChecksum,
            self.birthdate,
            birthDateChecksum,
            self.validUntilDate,
            validUntilDateChecksum
        )
    }
    
    // MARK: - Privates
    
    private let documentNumber: String
    private let birthdate: String
    private let validUntilDate: String
    
    // MARK: - Initialization Methods
    
    public init(
        documentNumber: String,
        birthdate: String,
        validUntilDate: String
    ) {
        self.documentNumber = documentNumber
        self.birthdate = birthdate
        self.validUntilDate = validUntilDate
    }
    
    // MARK: - Helper Methods
    
    private func calculateChecksum(checkString: String) -> Int {
        let characterDict = [
            "0": 0,
            "1": 1,
            "2": 2,
            "3": 3,
            "4": 4,
            "5": 5,
            "6": 6,
            "7": 7,
            "8": 8,
            "9": 9,
            "<": 0,
            " ": 0,
            "A": 10,
            "B": 11,
            "C": 12,
            "D": 13,
            "E": 14,
            "F": 15,
            "G": 16,
            "H": 17,
            "I": 18,
            "J": 19,
            "K": 20,
            "L": 21,
            "M": 22,
            "N": 23,
            "O": 24,
            "P": 25,
            "Q": 26,
            "R": 27,
            "S": 28,
            "T": 29,
            "U": 30,
            "V": 31,
            "W": 32,
            "X": 33,
            "Y": 34,
            "Z": 35
        ]
        
        var sum = 0
        var m = 0
        let multipliers = [7, 3, 1]
        
        for i in 0..<checkString.count {
            let key = checkString.substring(start: i, count: 1)
            let lookup = characterDict[key] ?? 0
            let product = lookup * multipliers[m]
            
            sum += product
            m = (m + 1) % 3
        }
        
        return sum % 10
    }
}
