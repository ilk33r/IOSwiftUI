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
    public let locationName: Binding<String>
    public let locationLatitude: Binding<Double?>
    public let locationLongitude: Binding<Double?>
    
    public init(
        isPresented: Binding<Bool>,
        locationName: Binding<String>,
        locationLatitude: Binding<Double?>,
        locationLongitude: Binding<Double?>
    ) {
        self.isPresented = isPresented
        self.locationName = locationName
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
    }
}
