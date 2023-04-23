//
//  SplashPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class SplashPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SplashInteractor!
    public var navigationState: StateObject<SplashNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var showButtons = false
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    @MainActor
    func prepare() async {
        do {
            try await self.interactor.handshake()
            self.environment.wrappedValue.appScreen = .loggedIn
        } catch let err {
            IOLogger.error(err.localizedDescription)
            self.showButtons = true
        }
    }
}
