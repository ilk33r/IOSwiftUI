//
//  PreviewProviderExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.11.2022.
//

import Foundation
import SwiftUI
import IOSwiftUIInfrastructure

#if DEBUG
public extension PreviewProvider {
    
    static func prepare() {
        IOPreviewAssembly.configureDI(container: IODIContainerImpl.shared)
    }
}
#endif
