// 
//  RegisterMRZReaderNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class RegisterMRZReaderNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToNFCReader = false
    
    var nfcReaderEntity: RegisterNFCReaderViewEntity!
}
