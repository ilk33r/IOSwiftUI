// 
//  FriendsNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class FriendsNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToProfile = false
    
    var profileEntity: ProfileEntity!
}
