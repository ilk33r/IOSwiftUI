// 
//  DiscoverNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class DiscoverNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToProfile = false
    
    var userName: String?
}
