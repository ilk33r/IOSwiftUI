//
//  SplashPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUI

final public class SplashPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public typealias Environment = SampleAppEnvironment
    public typealias Interactor = SplashInteractor
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SplashInteractor!
    
    // MARK: - Publisher
    
    @Published var showButtons = false
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    func updateButtons() {
        self.showButtons = true
    }
}
