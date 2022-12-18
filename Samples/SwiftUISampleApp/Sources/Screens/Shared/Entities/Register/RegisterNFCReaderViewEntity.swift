// 
//  RegisterNFCReaderViewEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct RegisterNFCReaderViewEntity: IOEntity {
    
    public let birthDate: String
    public let documentNumber: String
    public let expireDate: String
    public let identityNumber: String
    
    public init(
        birthDate: String,
        documentNumber: String,
        expireDate: String,
        identityNumber: String
    ) {
        self.birthDate = birthDate
        self.documentNumber = documentNumber
        self.expireDate = expireDate
        self.identityNumber = identityNumber
    }
}
