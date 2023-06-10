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
import SwiftUISampleAppScreensShared

final public class SearchNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToProfile = false
    
    private(set) var profileEntity: ProfileEntity?
    
    // MARK: - Helper Methods
    
    func navigateToProfile(userName: String) {
        self.profileEntity = ProfileEntity(
            navigationBarHidden: true,
            userName: userName
        )
        self.navigateToProfile = true
    }
}
