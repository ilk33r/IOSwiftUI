//
//  DeepLinks.swift
//
//
//  Created by Adnan ilker Ozcan on 2.09.2023.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared
import SwiftUISampleAppScreensProfile

public enum DeepLinks: Int {
    
    case profile = 1
}

extension DeepLinks: IODeepLinkDefinition {

    public var controller: any IOController.Type {
        switch self {
        case .profile:
            return ProfileView.self
        }
    }
    
    public static func from(components: URLComponents) -> DeepLinks? {
        guard let screenIDComponent = components.queryItems?.first(where: { $0.name == "screenID" }) else { return nil }
        
        if
            let screenIDString = screenIDComponent.value,
            let screenID = Int(screenIDString),
            let deepLink = DeepLinks(rawValue: screenID) {
            return deepLink
        }
        
        return nil
    }
}
