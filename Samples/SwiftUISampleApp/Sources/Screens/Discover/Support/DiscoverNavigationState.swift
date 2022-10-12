// 
//  DiscoverNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIPresentation

final class DiscoverNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToProfile = false
    
    public var userName: String?
}
