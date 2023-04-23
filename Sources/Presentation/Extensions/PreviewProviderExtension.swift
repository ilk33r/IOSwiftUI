//
//  PreviewProviderExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

#if DEBUG
public extension PreviewProvider {
    
    static func prepare() {
        IOPreviewAssembly.configureDI(container: IODIContainerImpl.shared)
    }
}
#endif
