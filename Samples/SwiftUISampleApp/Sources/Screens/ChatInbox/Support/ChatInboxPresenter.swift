// 
//  ChatInboxPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUI

final class ChatInboxPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Environment = SampleAppEnvironment
    typealias Interactor = ChatInboxInteractor
    
    var environment: EnvironmentObject<SampleAppEnvironment>!
    var interactor: ChatInboxInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
    
    // MARK: - Presenter
    
    func showTabBar() {
        self.interactor.appState.set(bool: false, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
}
