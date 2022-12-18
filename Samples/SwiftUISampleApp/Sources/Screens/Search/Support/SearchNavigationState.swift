// 
//  SearchNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class SearchNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToProfile = false
    
    var userName: String?
}
