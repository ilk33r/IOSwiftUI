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

final class LoginPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Environment = SampleAppEnvironment
    typealias Interactor = LoginInteractor
    
    var environment: EnvironmentObject<SampleAppEnvironment>!
    var interactor: LoginInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
