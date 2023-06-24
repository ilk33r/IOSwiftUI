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
    
    @Published var navigateToMap = false
    @Published var navigateToProfile = false
    
    private(set) var mapEntity: FriendsMapEntity?
    private(set) var profileEntity: ProfileEntity?
    
    // MARK: - Helper Methods
    
    func navigateToProfile(profileEntity: ProfileEntity) {
        self.profileEntity = profileEntity
        self.navigateToProfile = true
    }
    
    func navigateToMap(mapEntity: FriendsMapEntity?) {
        self.mapEntity = mapEntity
        self.navigateToMap = true
    }
}
