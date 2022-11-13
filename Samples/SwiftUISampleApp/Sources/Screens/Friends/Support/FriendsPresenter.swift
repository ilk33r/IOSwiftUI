// 
//  FriendsPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class FriendsPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: FriendsInteractor!
    public var navigationState: StateObject<FriendsNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
}
