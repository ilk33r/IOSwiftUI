// 
//  ProfilePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUI

final class ProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Environment = SampleAppEnvironment
    typealias Interactor = ProfileInteractor
    
    var environment: EnvironmentObject<SampleAppEnvironment>!
    var interactor: ProfileInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
