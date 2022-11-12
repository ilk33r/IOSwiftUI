// 
//  HomeNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class HomeNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToCamera = false
    @Published public var navigateToPhotoLibrary = false
}
