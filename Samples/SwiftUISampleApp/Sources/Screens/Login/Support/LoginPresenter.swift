// 
//  LoginPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUI

final public class LoginPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public typealias Environment = SampleAppEnvironment
    public typealias Interactor = LoginInteractor
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: LoginInteractor!
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func loginCompleted() {
        self.environment.wrappedValue.isLoggedIn = true
    }
}
