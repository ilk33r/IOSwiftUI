// 
//  SendOTPEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

public struct SendOTPEntity: IOEntity {
    
    public let isPresented: Binding<Bool>
    public let phoneNumber: String?
    
    public init(
        isPresented: Binding<Bool>,
        phoneNumber: String?
    ) {
        self.isPresented = isPresented
        self.phoneNumber = phoneNumber
    }
}
