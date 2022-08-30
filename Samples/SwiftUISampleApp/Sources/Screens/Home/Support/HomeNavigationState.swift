// 
//  HomeNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final public class HomeNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToCamera: Bool = false
    @Published public var navigateToPhotoLibrary: Bool = false
}
