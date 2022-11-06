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
import SwiftUISampleAppPresentation
import SwiftUI

final public class SplashPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SplashInteractor!
    public var navigationState: StateObject<SplashNavigationState>!
    
    // MARK: - Publisher
    
    @Published private(set) var showButtons = false
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    func updateButtons() {
        self.showButtons = true
    }
    
    func navigateToHome() {
        self.environment.wrappedValue.isLoggedIn = true
    }
}
