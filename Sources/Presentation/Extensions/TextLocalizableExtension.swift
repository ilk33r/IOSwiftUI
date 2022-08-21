//
//  TextLocalizableExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import SwiftUI
import IOSwiftUIInfrastructure

public extension Text {
    
    init(type: IOLocalizationType) {
        self.init(type.localized)
    }
}
