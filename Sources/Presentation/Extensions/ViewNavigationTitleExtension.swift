//
//  ViewNavigationTitleExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.10.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public extension View {
    
    @inlinable func navigationTitle(type: IOLocalizationType) -> some View {
        return navigationTitle(type.localized)
    }
}
