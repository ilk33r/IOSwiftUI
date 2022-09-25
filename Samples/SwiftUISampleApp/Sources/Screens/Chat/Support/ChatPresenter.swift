// 
//  ChatPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Combine
import Foundation
import IOSwiftUIPresentation
import SwiftUI
import UIKit
import SwiftUISampleAppPresentation

final class ChatPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Environment = SampleAppEnvironment
    typealias Interactor = ChatInteractor
    
    var environment: EnvironmentObject<SampleAppEnvironment>!
    var interactor: ChatInteractor!
    
    // MARK: - Publishers
    
    @Published var keyboardPublisher: AnyPublisher<Bool, Never>
    
    // MARK: - Initialization Methods
    
    init() {
        self.keyboardPublisher = Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in false }
            )
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Presenter
    
    func hideTabBar() {
        self.interactor.appState.set(bool: true, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
}
