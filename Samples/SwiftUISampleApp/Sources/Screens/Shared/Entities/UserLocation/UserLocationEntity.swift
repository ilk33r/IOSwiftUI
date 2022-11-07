// 
//  UserLocationEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.11.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

public struct UserLocationEntity: IOEntity {
    
    public let isPresented: Binding<Bool>
    
    public init(isPresented: Binding<Bool>) {
        self.isPresented = isPresented
    }
}
