// 
//  ChatInboxNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class ChatInboxNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    public var alertData: IOAlertData!
    public var showAlert = CurrentValueSubject<Bool, Never>(false)
    
    @Published public var navigateToChat = false
    
    var chatEntity: ChatEntity!
}
